# Database Design & Architecture
## Retail & E-Commerce Relational Database

---

## 1. Relational Architecture Rationale

The database is built as a normalized relational database in Third Normal Form (3NF) within Microsoft SQL Server (`RetailEcommerce_DB`). 

### Core Design Decisions:
1. **Header vs. Line-Item Normalization:**
   - Separates order-level attributes (`Orders`) from product-level items (`OrderDetails`).
   - Resolves the raw dataset's `grand_total` duplication bug where order totals were repeated on every line item.
2. **Master Entities Decoupling:**
   - Dedicated master tables for `Customers`, `Products`, `Categories`, and `PaymentMethods` eliminate data redundancy and enforce referential integrity.
3. **Optimized Data Types:**
   - Strict typing across IDs, numeric quantities, currency decimals (`DECIMAL(18,2)`), and ISO dates (`DATE`) minimizes storage footprint and prevents invalid data insertion.
4. **Referential Integrity & Constraints:**
   - Foreign key constraints ensure 0 orphan records between orders, customers, payment methods, order details, and products.

---

## 2. Table Specifications

### 2.1 `dbo.Categories`
- **Description:** Master lookup for product categories.
- **Grain:** 1 row per merchandise category.
- **Row Count:** 16 records.

| Column | Data Type | Nullable | Constraint | Description |
| :--- | :--- | :---: | :---: | :--- |
| `category_id` | `INT` | No | **PK** | Unique identifier for each category. |
| `category_name` | `VARCHAR(100)` | No | — | Category name (e.g., Mobiles & Tablets, Men's Fashion). |

---

### 2.2 `dbo.PaymentMethods`
- **Description:** Master lookup for accepted payment gateways and channels.
- **Grain:** 1 row per payment method.
- **Row Count:** 18 records.

| Column | Data Type | Nullable | Constraint | Description |
| :--- | :--- | :---: | :---: | :--- |
| `payment_method_id` | `INT` | No | **PK** | Unique identifier for payment method. |
| `payment_method_name` | `VARCHAR(50)` | No | — | Method code (e.g., cod, easypay, jazzwallet). |

---

### 2.3 `dbo.Products`
- **Description:** Catalog of unique merchandise SKUs.
- **Grain:** 1 row per unique SKU.
- **Row Count:** 84,800 records.

| Column | Data Type | Nullable | Constraint | Description |
| :--- | :--- | :---: | :---: | :--- |
| `product_id` | `INT` | No | **PK** | Unique surrogate product identifier. |
| `sku` | `VARCHAR(150)` | No | — | Product SKU code. |
| `category_id` | `INT` | No | **FK** | References `Categories(category_id)`. |
| `price` | `DECIMAL(18,2)` | No | $\ge 0$ | Standard catalog selling price in PKR. |

---

### 2.4 `dbo.Customers`
- **Description:** Customer account profiles.
- **Grain:** 1 row per customer account.
- **Row Count:** 115,327 records.

| Column | Data Type | Nullable | Constraint | Description |
| :--- | :--- | :---: | :---: | :--- |
| `customer_id` | `INT` | No | **PK** | Unique customer identifier (`0` denotes guest checkout). |
| `customer_since` | `DATE` | Yes | — | Date of account registration or first purchase. |

---

### 2.5 `dbo.Orders`
- **Description:** Transaction headers capturing order-level financials and status.
- **Grain:** 1 row per distinct order (`order_id`).
- **Row Count:** 408,782 records.

| Column | Data Type | Nullable | Constraint | Description |
| :--- | :--- | :---: | :---: | :--- |
| `order_id` | `VARCHAR(50)` | No | **PK** | Order increment ID from e-commerce platform. |
| `customer_id` | `INT` | No | **FK** | References `Customers(customer_id)`. |
| `order_date` | `DATE` | No | — | Transaction placement date. |
| `payment_method_id` | `INT` | No | **FK** | References `PaymentMethods(payment_method_id)`. |
| `status` | `VARCHAR(50)` | No | — | Fulfillment status (e.g., complete, canceled, refund). |
| `grand_total` | `DECIMAL(18,2)` | No | $\ge 0$ | Final invoice amount for the order in PKR. |

---

### 2.6 `dbo.OrderDetails`
- **Description:** Transaction line items representing individual SKUs within an order.
- **Grain:** 1 row per line item (`order_detail_id`).
- **Row Count:** 584,524 records.

| Column | Data Type | Nullable | Constraint | Description |
| :--- | :--- | :---: | :---: | :--- |
| `order_detail_id` | `BIGINT` | No | **PK** | Unique identifier for each line item (`item_id`). |
| `order_id` | `VARCHAR(50)` | No | **FK** | References `Orders(order_id)`. |
| `product_id` | `INT` | No | **FK** | References `Products(product_id)`. |
| `qty_ordered` | `INT` | No | $> 0$ | Units purchased. |
| `price` | `DECIMAL(18,2)` | No | $\ge 0$ | Unit selling price in PKR. |
| `discount_amount` | `DECIMAL(18,2)` | No | $\ge 0$ | Item discount voucher deduction in PKR. |
| `total_amount` | `DECIMAL(18,2)` | No | — | Net line item total: $(\text{qty} \times \text{price}) - \text{discount}$. |

---

## 3. Indexing Strategy

To optimize transactional lookups and join performance across tables, non-clustered B-Tree indexes are created on foreign keys and frequently filtered columns:

| Index Name | Table | Indexed Column(s) | Purpose |
| :--- | :--- | :--- | :--- |
| `IX_Orders_CustomerID` | `Orders` | `customer_id` | Accelerates customer order history queries. |
| `IX_Orders_OrderDate` | `Orders` | `order_date` | Accelerates date filtering and range scans. |
| `IX_OrderDetails_OrderID` | `OrderDetails` | `order_id` | Accelerates master-detail joins between Orders and OrderDetails. |
| `IX_OrderDetails_ProductID` | `OrderDetails` | `product_id` | Accelerates product sales queries. |
| `IX_Products_CategoryID` | `Products` | `category_id` | Accelerates category product lookups. |
