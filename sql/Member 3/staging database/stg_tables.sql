USE RetailEcommerce_DB;
GO

CREATE TABLE Stg_Categories (
    category_id INT,
    category_name VARCHAR(100)
);

CREATE TABLE Stg_Customers (
    customer_id INT,
    customer_since DATE NULL
);

CREATE TABLE Stg_Products (
    product_id INT,
    sku VARCHAR(100),
    category_id INT,
    price DECIMAL(12,2)
);

CREATE TABLE Stg_PaymentMethods (
    payment_method_id INT,
    payment_method_name VARCHAR(50)
);

CREATE TABLE Stg_Orders (
    order_id VARCHAR(20),
    customer_id INT,
    order_date DATE,
    payment_method_id INT,
    status VARCHAR(50),
    grand_total DECIMAL(12,2)
);

CREATE TABLE Stg_OrderDetails (
    order_detail_id INT,
    order_id VARCHAR(20),
    product_id INT,
    qty_ordered INT,
    price DECIMAL(12,2),
    discount_amount DECIMAL(12,2),
    total_amount DECIMAL(12,2)
);
select name from sys.tables;

ALTER TABLE Stg_Products
ALTER COLUMN sku VARCHAR(100);

SELECT * FROM Stg_Products;
select * from Stg_Customers;
select * from Stg_Categories;
SELECT * FROM Stg_PaymentMethods;
select * from Stg_Orders;
select * from Stg_OrderDetails;

TRUNCATE TABLE Stg_Categories;
TRUNCATE TABLE Stg_Customers;
TRUNCATE TABLE Stg_Products;
TRUNCATE TABLE Stg_PaymentMethods;
TRUNCATE TABLE Stg_Orders;
TRUNCATE TABLE Stg_OrderDetails;


-- 1. Clear Fact tables first
DELETE FROM dbo.Fact_OrderItems;
DELETE FROM dbo.Fact_Orders;

-- 2. Clear Dimension tables
DELETE FROM dbo.Dim_Product;
DELETE FROM dbo.Dim_Customer;
DELETE FROM dbo.Dim_PaymentMethod;
DELETE FROM dbo.Dim_Date;

