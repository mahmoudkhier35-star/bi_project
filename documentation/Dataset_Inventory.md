# Dataset Inventory
## Retail & E-Commerce Platform

---

## 1. Raw Source Details
- **File Name:** `Pakistan Largest Ecommerce Dataset.csv`
- **Location:** `data/raw/Pakistan Largest Ecommerce Dataset.csv`
- **File Size:** 101.58 MB (106,513,675 bytes)
- **Total Rows in File:** 1,048,575 rows (matches Excel sheet limit of $2^{20} - 1$)
- **Empty Filler Rows:** 464,051 rows (44.26%)
- **Valid Data Rows:** 584,524 rows (55.74%)
- **Total Columns:** 26 columns
- **Date Range:** July 1, 2016 to August 28, 2018 (26 months)

---

## 2. File Summary & Grain

| Metric | Count | Details |
| :--- | :---: | :--- |
| **Physical File Rows** | 1,048,575 | Exported with blank row padding from Excel |
| **Valid Transactions** | 584,524 | Primary key: `item_id` (0 duplicates) |
| **Distinct Orders** | 408,782 | Grouped by `increment_id` |
| **Multi-Item Orders** | 81,854 | Orders with 2 to 72 line items (20.02% of orders) |
| **Distinct Customers** | 115,326 | Tracked by `Customer ID` (11 missing mapped to guest) |
| **Distinct SKUs** | 84,889 | Tracked by `sku` (20 missing mapped to unknown) |
| **Distinct Categories** | 16 | Top-level product categories |
| **Distinct Payment Methods** | 18 | Cash on delivery, mobile wallets, and bank gateways |

---

## 3. Column Overview (Pre-Cleaning)

| Index | Column Name | Raw Type | Valid Count | Null Count | Unique | Description |
| :---: | :--- | :--- | :---: | :---: | :---: | :--- |
| 0 | `item_id` | `float64` | 584,524 | 0 | 584,524 | Line item transaction key (unique across all rows). |
| 1 | `status` | `object` | 584,509 | 15 | 16 | Order fulfillment status (`complete`, `canceled`, etc.). |
| 2 | `created_at` | `object` | 584,524 | 0 | 789 | Order date string (`M/D/YYYY`). |
| 3 | `sku` | `object` | 584,504 | 20 | 84,889 | Product SKU code. |
| 4 | `price` | `float64` | 584,524 | 0 | 9,121 | Unit price in PKR. |
| 5 | `qty_ordered` | `float64` | 584,524 | 0 | 74 | Quantity purchased. |
| 6 | `grand_total` | `float64` | 584,524 | 0 | 36,829 | Order-level total invoice value (repeated on line items). |
| 7 | `increment_id` | `object` | 584,524 | 0 | 408,782 | Order identifier. |
| 8 | `category_name_1` | `object` | 584,360 | 164 | 16 | Category name (contains `\N` in 7,850 rows). |
| 9 | `sales_commission_code` | `object` | 447,346 | 137,178 | 7,225 | Commission / referral tracking code. |
| 10 | `discount_amount` | `float64` | 584,524 | 0 | 28,058 | Discount amount in PKR. |
| 11 | `payment_method` | `object` | 584,524 | 0 | 18 | Payment method string. |
| 12 | `Working Date` | `object` | 584,524 | 0 | 789 | Matches `created_at` in 100% of rows. |
| 13 | `BI Status` | `object` | 584,524 | 0 | 4 | Reporting flag (`Net`, `Gross`, `Valid`, `#REF!`). |
| 14 | ` MV ` | `object` | 584,524 | 0 | 9,720 | Merchandise value string with commas and spaces. |
| 15 | `Year` | `float64` | 584,524 | 0 | 3 | Year (2016, 2017, 2018). |
| 16 | `Month` | `float64` | 584,524 | 0 | 12 | Month number (1 to 12). |
| 17 | `Customer Since` | `object` | 584,513 | 11 | 26 | Customer cohort string (`YYYY-M`). |
| 18 | `M-Y` | `object` | 584,524 | 0 | 26 | Month-Year string (`M-YYYY`). |
| 19 | `FY` | `object` | 584,524 | 0 | 3 | Fiscal Year (`FY17`, `FY18`, `FY19`). |
| 20 | `Customer ID` | `float64` | 584,513 | 11 | 115,326 | Customer account identifier. |
| 21-25 | `Unnamed: 21`..`25` | `float64` | 0 | 584,524 | 0 | Unused trailing columns (100% null). |

---

## 4. Normalized Relational Tables

To eliminate row-level redundancy and establish a 3NF relational database structure, the data is split into 6 normalized relational tables:

1. `Categories.csv` (16 categories)
2. `PaymentMethods.csv` (18 payment methods)
3. `Products.csv` (84,800 catalog SKUs)
4. `Customers.csv` (115,327 customer records)
5. `Orders.csv` (408,782 order headers)
6. `OrderDetails.csv` (584,524 order line items)
