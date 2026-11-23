# Data Cleaning Log
## Retail & E-Commerce Platform

---

## 1. Summary of Cleaning Decisions

This report logs the cleaning transformations applied to the raw export (`Pakistan Largest Ecommerce Dataset.csv`). All decisions were implemented in Python via `notebooks/02_data_cleaning.ipynb` and output to `data/cleaned/`. The raw source file remains unchanged in `data/raw/`.

| Ref | Issue Identified | Action Taken | Records Affected | Decision Type |
| :---: | :--- | :--- | :---: | :---: |
| **01** | **Blank Row Padding** (464,051 empty rows) | Filtered rows where `item_id IS NOT NULL`. | 464,051 rows | Excluded |
| **02** | **Ghost Columns** (`Unnamed: 21` to `25`) | Dropped all 5 unpopulated trailing columns. | 5 columns | Excluded |
| **03** | **Header Whitespace** (`' MV '`) | Trimmed column names (`col.strip()`). | All columns | Corrected |
| **04** | **Literal `\N` Strings** (MySQL exports) | Replaced `\N` with `NaN` in categories; `'unknown'` in status; `'NONE'` in commission code. | 273,202 fields | Corrected |
| **05** | **Missing Categories** (164 nulls + 7,850 `\N`) | Recovered categories from existing SKU mappings; remainder set to `'Uncategorized'`. | 8,014 records | Imputed |
| **06** | **Formula Error `#REF!`** (in `BI Status`) | Corrected row 0 to `'Net'`. | 1 record | Corrected |
| **07** | **Formatted Numbers** (`MV` string) | Stripped commas and spaces, cast to `DECIMAL(12,2)`. | 584,524 records | Corrected |
| **08** | **Missing Customer IDs** (11 rows null) | Imputed to surrogate key `0` (`'Guest / Unregistered'`). | 11 records | Imputed |
| **09** | **Missing SKUs** (20 rows null) | Imputed to `'UNKNOWN_SKU'`. | 20 records | Imputed |
| **10** | **Null Status** (15 rows null) | Imputed to `'unknown'`. | 15 records | Imputed |
| **11** | **Negative Discounts** (3 rows negative) | Converted to positive using `abs(discount_amount)`. | 3 records | Corrected |
| **12** | **Negative Order Totals** (76 rows negative) | Flagged adjustments and recalculated from line items. | 76 records | Corrected |
| **13** | **Zero Unit Prices** (2,232 rows with price 0.00) | Retained giveaways and flagged with `is_promotional_sample = 1`. | 2,232 records | Flagged & Retained |
| **14** | **Wholesale Outliers** (qty > 100) | Retained bulk orders and flagged with `is_wholesale_bulk = 1` for qty $\ge 50$. | 2,268 records | Flagged & Retained |
| **15** | **Repeated Order Headers** (1.09B PKR inflation) | Separated order header total into `Orders`; computed line-item metrics in `OrderDetails`. | 81,854 multi-item orders | Resolved by Schema Design |

---

## 2. Details on Major Actions

### Action 01 & 02: Removing Blank Rows and Columns
- **Context:** The raw export contained 1,048,575 rows and 26 columns.
- **Finding:** Exactly 464,051 rows were 100% blank, and columns `Unnamed: 21` through `25` contained zero values. This is caused by Excel's row ceiling ($2^{20}-1 = 1,048,575$) when files are opened and re-saved.
- **Result:** After filtering on `item_id IS NOT NULL`, exactly 584,524 valid transaction records remain.

### Action 04 & 05: Category Imputation
- **Context:** 7,850 rows had the text `\N` in `category_name_1`, and 164 rows were null.
- **Resolution:** A mapping dictionary was built from SKUs with valid categories. 20 SKU mappings were successfully matched and recovered. The remaining unmapped records were assigned `'Uncategorized'`. No historical records were deleted.

### Action 08 & 09: Foreign Key Preservation
- **Context:** 11 records had null `Customer ID` and 20 had null `sku`.
- **Resolution:** Rather than deleting valid order records, surrogate records were established in dimension tables:
  - `Customer ID = 0` $\rightarrow$ `'Guest / Unregistered'` in `Customers`.
  - `sku = 'UNKNOWN_SKU'` $\rightarrow$ `'Unknown Catalog Item'` in `Products`.
- **Result:** 100% of foreign keys resolve with zero orphan records.

### Action 15: Grand Total Duplication Fix
- **Context:** For orders with multiple items, the raw file repeated the entire order `grand_total` on every line item row.
- **Resolution:** 
  - `Orders` holds 1 row per order with the actual order-level totals.
  - `OrderDetails` holds line-item metrics:
    $$\text{total\_amount} = (\text{price} \times \text{qty\_ordered}) - \text{discount\_amount}$$
- **Reconciliation:** Order-level totals match distinct transactions without duplicate inflation.

---

## 3. Record Count Reconciliation

```
[Raw CSV File]                     1,048,575 rows
      |
      v
[Blank Rows Filtered]             -  464,051 rows
      |
      v
[Cleaned Transactions]               584,524 rows
      |
      +---> Categories                    16 rows
      +---> PaymentMethods                18 rows
      +---> Products                  84,800 rows
      +---> Customers                115,327 rows
      +---> Orders                   408,782 rows
      +---> OrderDetails             584,524 rows
```
