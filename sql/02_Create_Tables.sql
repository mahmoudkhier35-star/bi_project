USE RetailEcommerce_DB;
GO

IF OBJECT_ID('dbo.OrderDetails', 'U') IS NOT NULL DROP TABLE dbo.OrderDetails;
IF OBJECT_ID('dbo.Orders', 'U') IS NOT NULL DROP TABLE dbo.Orders;
IF OBJECT_ID('dbo.Products', 'U') IS NOT NULL DROP TABLE dbo.Products;
IF OBJECT_ID('dbo.Customers', 'U') IS NOT NULL DROP TABLE dbo.Customers;
IF OBJECT_ID('dbo.PaymentMethods', 'U') IS NOT NULL DROP TABLE dbo.PaymentMethods;
IF OBJECT_ID('dbo.Categories', 'U') IS NOT NULL DROP TABLE dbo.Categories;
GO

CREATE TABLE dbo.Categories (
    category_id INT NOT NULL,
    category_name VARCHAR(100) NOT NULL
);
GO

CREATE TABLE dbo.PaymentMethods (
    payment_method_id INT NOT NULL,
    payment_method_name VARCHAR(50) NOT NULL
);
GO

CREATE TABLE dbo.Products (
    product_id INT NOT NULL,
    sku VARCHAR(150) NOT NULL,
    category_id INT NOT NULL,
    price DECIMAL(18, 2) NOT NULL
);
GO

CREATE TABLE dbo.Customers (
    customer_id INT NOT NULL,
    customer_since DATE NULL
);
GO

CREATE TABLE dbo.Orders (
    order_id VARCHAR(50) NOT NULL,
    customer_id INT NOT NULL,
    order_date DATE NOT NULL,
    payment_method_id INT NOT NULL,
    status VARCHAR(50) NOT NULL,
    grand_total DECIMAL(18, 2) NOT NULL
);
GO

CREATE TABLE dbo.OrderDetails (
    order_detail_id BIGINT NOT NULL,
    order_id VARCHAR(50) NOT NULL,
    product_id INT NOT NULL,
    qty_ordered INT NOT NULL,
    price DECIMAL(18, 2) NOT NULL,
    discount_amount DECIMAL(18, 2) NOT NULL,
    total_amount DECIMAL(18, 2) NOT NULL
);
GO
