USE RetailEcommerce_DB;
GO

ALTER TABLE dbo.Categories 
ADD CONSTRAINT PK_Categories PRIMARY KEY (category_id);
GO

ALTER TABLE dbo.PaymentMethods 
ADD CONSTRAINT PK_PaymentMethods PRIMARY KEY (payment_method_id);
GO

ALTER TABLE dbo.Products 
ADD CONSTRAINT PK_Products PRIMARY KEY (product_id);
GO

ALTER TABLE dbo.Customers 
ADD CONSTRAINT PK_Customers PRIMARY KEY (customer_id);
GO

ALTER TABLE dbo.Orders 
ADD CONSTRAINT PK_Orders PRIMARY KEY (order_id);
GO

ALTER TABLE dbo.OrderDetails 
ADD CONSTRAINT PK_OrderDetails PRIMARY KEY (order_detail_id);
GO

ALTER TABLE dbo.Products 
ADD CONSTRAINT FK_Products_Categories FOREIGN KEY (category_id) 
REFERENCES dbo.Categories(category_id);
GO

ALTER TABLE dbo.Orders 
ADD CONSTRAINT FK_Orders_Customers FOREIGN KEY (customer_id) 
REFERENCES dbo.Customers(customer_id);
GO

ALTER TABLE dbo.Orders 
ADD CONSTRAINT FK_Orders_PaymentMethods FOREIGN KEY (payment_method_id) 
REFERENCES dbo.PaymentMethods(payment_method_id);
GO

ALTER TABLE dbo.OrderDetails 
ADD CONSTRAINT FK_OrderDetails_Orders FOREIGN KEY (order_id) 
REFERENCES dbo.Orders(order_id);
GO

ALTER TABLE dbo.OrderDetails 
ADD CONSTRAINT FK_OrderDetails_Products FOREIGN KEY (product_id) 
REFERENCES dbo.Products(product_id);
GO

ALTER TABLE dbo.OrderDetails 
ADD CONSTRAINT CK_OrderDetails_Qty CHECK (qty_ordered > 0);
GO

ALTER TABLE dbo.OrderDetails 
ADD CONSTRAINT CK_OrderDetails_Price CHECK (price >= 0);
GO

ALTER TABLE dbo.Orders 
ADD CONSTRAINT CK_Orders_Total CHECK (grand_total >= 0);
GO

CREATE NONCLUSTERED INDEX IX_Orders_CustomerID ON dbo.Orders(customer_id);
GO

CREATE NONCLUSTERED INDEX IX_Orders_OrderDate ON dbo.Orders(order_date);
GO

CREATE NONCLUSTERED INDEX IX_OrderDetails_OrderID ON dbo.OrderDetails(order_id);
GO

CREATE NONCLUSTERED INDEX IX_OrderDetails_ProductID ON dbo.OrderDetails(product_id);
GO

CREATE NONCLUSTERED INDEX IX_Products_CategoryID ON dbo.Products(category_id);
GO
