# Entity Relationship Diagram (ERD) — Relational Database

```mermaid
erDiagram
    CUSTOMERS ||--o{ ORDERS : "places"
    PAYMENT_METHODS ||--o{ ORDERS : "pays_with"
    CATEGORIES ||--o{ PRODUCTS : "categorizes"
    PRODUCTS ||--o{ ORDER_DETAILS : "ordered_in"
    ORDERS ||--|{ ORDER_DETAILS : "contains"

    CUSTOMERS {
        INT customer_id PK
        DATE customer_since
    }

    CATEGORIES {
        INT category_id PK
        VARCHAR category_name
    }

    PAYMENT_METHODS {
        INT payment_method_id PK
        VARCHAR payment_method_name
    }

    PRODUCTS {
        INT product_id PK
        VARCHAR sku
        INT category_id FK
        DECIMAL price
    }

    ORDERS {
        VARCHAR order_id PK
        INT customer_id FK
        DATE order_date
        INT payment_method_id FK
        VARCHAR status
        DECIMAL grand_total
    }

    ORDER_DETAILS {
        BIGINT order_detail_id PK
        VARCHAR order_id FK
        INT product_id FK
        INT qty_ordered
        DECIMAL price
        DECIMAL discount_amount
        DECIMAL total_amount
    }
```

## Schema Entities & Relationships

| Entity | Grain | Primary Key | Foreign Keys | Relationships |
| :--- | :--- | :--- | :--- | :--- |
| **Customers** | One row per customer account | `customer_id` | - | 1-to-Many with `Orders` |
| **Categories** | One row per product category | `category_id` | - | 1-to-Many with `Products` |
| **PaymentMethods** | One row per payment method | `payment_method_id` | - | 1-to-Many with `Orders` |
| **Products** | One row per distinct SKU | `product_id` | `category_id` | Many-to-1 with `Categories`, 1-to-Many with `OrderDetails` |
| **Orders** | One row per transaction order | `order_id` | `customer_id`, `payment_method_id` | Many-to-1 with `Customers` & `PaymentMethods`, 1-to-Many with `OrderDetails` |
| **OrderDetails** | One row per item in an order | `order_detail_id` | `order_id`, `product_id` | Many-to-1 with `Orders` & `Products` |
