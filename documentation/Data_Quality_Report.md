# Data Quality & Anomaly Report
## Retail & E-Commerce Platform

---

## 1. Summary of Identified Data Issues

The audit of the raw extract (`Pakistan Largest Ecommerce Dataset.csv`) identified 7 main issues that directly impact reporting accuracy and database loading:

| Issue | Scope | Details | Impact |
| :--- | :---: | :--- | :--- |
| **Excel Sheet Row Padding** | 464,051 rows | The raw file has exactly 1,048,575 rows (the Excel sheet boundary). 464,051 rows are completely blank. | Adds ~50 MB of useless data and breaks standard bulk loaders. |
| **Ghost Columns** | 5 columns | Columns `Unnamed: 21` through `25` contain 100% null values. | Trailing delimiter artifact. |
| **Header Total Duplication** | 81,854 orders | `grand_total` is repeated across every line item of multi-item orders. | Summing `grand_total` over-counts platform revenue by 1.09B PKR (+28.0%). |
| **String Null Representations** | 273,202 cells | Columns contain the literal string `\N` from MySQL exports. | Not recognized as nulls by SQL Server/Pandas. |
| **Broken Excel Formula** | 1 cell | `BI Status` in row 0 contains `#REF!`. | Broken spreadsheet formula prior to export. |
| **Leading/Trailing Whitespace** | Multiple | Column name `' MV '` has leading/trailing spaces; values contain formatting commas and spaces. | Causes key errors during scripted access. |
| **Missing Foreign Keys** | 31 rows | 11 rows missing `Customer ID`; 20 rows missing `sku`. | Violates foreign key referential integrity. |

---

## 2. Quantitative Defect Breakdown

### 2.1 Empty Rows and Trailing Delimiters
- Total rows in file: 1,048,575
- Completely blank rows: 464,051 (44.26%)
- Valid operational records: 584,524 (55.74%)
- All empty rows were removed by filtering on `item_id IS NOT NULL`.

### 2.2 The Repeated Grand Total Problem
When an order contains multiple items, the system exported the entire order invoice total into every row:
- Sample Order `100147454` contains 2 line items.
- Item 1 has price 183.00, qty 1.
- Item 2 has price 183.00, qty 1.
- The order total is 366.00.
- Both rows show `grand_total = 366.00`.
- Summing `grand_total` row by row results in $366.00 + 366.00 = 732.00$ (2x the actual amount).
- Across all 81,854 multi-item orders, this repeats up to 72 times per order.
- **Resolution:** `grand_total` was separated into `Orders`. Line-item metrics in `OrderDetails` are calculated as `price * qty_ordered - discount_amount`.

### 2.3 Literal String `\N`
- `category_name_1`: 7,850 rows contain `\N`, plus 164 nulls.
- `status`: 4 rows contain `\N`, plus 15 nulls.
- `sales_commission_code`: 265,348 rows contain `\N`, plus 137,178 nulls.
- **Resolution:** Replaced `\N` with `NaN` in categories; imputed known SKUs and labeled the remainder `'Uncategorized'`. Status `\N` mapped to `'unknown'`. Sales code `\N` mapped to `'NONE'`.

### 2.4 Missing Identifiers
- 11 line items had no `Customer ID` (guest checkouts). Mapped to surrogate customer ID `0` (`'Guest / Unregistered'`).
- 20 line items had no `sku`. Mapped to surrogate SKU `'UNKNOWN_SKU'`.
- This ensures 100% of foreign keys resolve successfully without deleting transaction history.

### 2.5 Negative & Zero Values
- 76 orders show negative `grand_total` (down to -1,594.00 PKR).
- 3 items show negative `discount_amount` (down to -599.50 PKR).
- 2,232 items show `price = 0.00` (promotional samples or giveaways).
- **Resolution:** Negative discounts converted with `abs()`. Zero-price items retained and flagged with `is_promotional_sample = 1`.

---

## 3. Relationship Verification

- **Order to Line Item:** 1-to-many relationship. Validated that every `item_id` has an `increment_id` (0 orphans).
- **Customer to Order:** 1-to-many relationship. Validated that every `order_id` links to a valid `customer_id` (0 orphans).
- **Product to Line Item:** 1-to-many relationship. Validated that every `product_id` resolves in `Products` (0 orphans).
- **Category to Product:** 1-to-many relationship. Validated that every product has a valid `category_id` (0 orphans).
