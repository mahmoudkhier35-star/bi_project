# Data Integration & Schema Verification Report
## Retail & E-Commerce Relational Database

---

## 1. Integration Strategy

The raw transactional export was decomposed into 6 normalized relational tables (3NF) to resolve data redundancy, enforce referential integrity, and decouple transactional line items from order headers.

---

## 2. Table Grains, Keys, and Cardinality

| Table Name | Grain | Primary Key | Foreign Keys | Relationship |
| :--- | :--- | :--- | :--- | :---: |
| `Categories` | 1 row per product category | `category_id` | None | $1 : N$ with `Products` |
| `PaymentMethods` | 1 row per payment method | `payment_method_id` | None | $1 : N$ with `Orders` |
| `Products` | 1 row per unique SKU | `product_id` | `category_id` | Many-to-1 with `Categories`, $1 : N$ with `OrderDetails` |
| `Customers` | 1 row per customer account | `customer_id` | None | $1 : N$ with `Orders` |
| `Orders` | 1 row per transaction order | `order_id` | `customer_id`, `payment_method_id` | Many-to-1 with `Customers` & `PaymentMethods`, $1 : N$ with `OrderDetails` |
| `OrderDetails` | 1 row per line item | `order_detail_id` | `order_id`, `product_id` | Child table of `Orders` and `Products` |

---

## 3. Relationship Verification & Orphan Checks

### 3.1 Primary Key Uniqueness
- `Categories.category_id`: 16 rows, 16 distinct (0 duplicates).
- `PaymentMethods.payment_method_id`: 18 rows, 18 distinct (0 duplicates).
- `Products.product_id`: 84,800 rows, 84,800 distinct (0 duplicates).
- `Customers.customer_id`: 115,327 rows, 115,327 distinct (0 duplicates).
- `Orders.order_id`: 408,782 rows, 408,782 distinct (0 duplicates).
- `OrderDetails.order_detail_id`: 584,524 rows, 584,524 distinct (0 duplicates).

### 3.2 Foreign Key Orphan Audit
- `Orders` $\rightarrow$ `Customers`: 0 orphan records.
- `Orders` $\rightarrow$ `PaymentMethods`: 0 orphan records.
- `OrderDetails` $\rightarrow$ `Orders`: 0 orphan records.
- `OrderDetails` $\rightarrow$ `Products`: 0 orphan records.
- `Products` $\rightarrow$ `Categories`: 0 orphan records.

---

## 4. Key Metrics Reconciliation

| Metric | Raw Cleaned Extract | Relational Tables | Variance | Status |
| :--- | :---: | :---: | :---: | :---: |
| **Distinct Orders** | 408,782 | 408,782 | 0 | Exact Match |
| **Distinct Line Items** | 584,524 | 584,524 | 0 | Exact Match |
| **Total Units Sold** | 757,771 | 757,771 | 0 | Exact Match |
| **Sum of Order Grand Totals** | 3,105,404,260.62 PKR | 3,105,404,260.62 PKR | 0.00 | Exact Match |
| **Total Customers** | 115,327 | 115,327 | 0 | Exact Match |
| **Total Catalog SKUs** | 84,800 | 84,800 | 0 | Exact Match |
