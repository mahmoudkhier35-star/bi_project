USE RetailEcommerce_DB;
GO

BULK INSERT dbo.Categories
FROM 'C:\Users\Loq\Downloads\repo\bi_project\data\cleaned\Categories.csv'
WITH (
    FIRSTROW = 2,
    FIELDTERMINATOR = ',',
    ROWTERMINATOR = '\n',
    TABLOCK,
    CODEPAGE = '65001'
);
GO

BULK INSERT dbo.PaymentMethods
FROM 'C:\Users\Loq\Downloads\repo\bi_project\data\cleaned\PaymentMethods.csv'
WITH (
    FIRSTROW = 2,
    FIELDTERMINATOR = ',',
    ROWTERMINATOR = '\n',
    TABLOCK,
    CODEPAGE = '65001'
);
GO

BULK INSERT dbo.Products
FROM 'C:\Users\Loq\Downloads\repo\bi_project\data\cleaned\Products.csv'
WITH (
    FIRSTROW = 2,
    FIELDTERMINATOR = ',',
    ROWTERMINATOR = '\n',
    TABLOCK,
    CODEPAGE = '65001'
);
GO

BULK INSERT dbo.Customers
FROM 'C:\Users\Loq\Downloads\repo\bi_project\data\cleaned\Customers.csv'
WITH (
    FIRSTROW = 2,
    FIELDTERMINATOR = ',',
    ROWTERMINATOR = '\n',
    TABLOCK,
    CODEPAGE = '65001'
);
GO

BULK INSERT dbo.Orders
FROM 'C:\Users\Loq\Downloads\repo\bi_project\data\cleaned\Orders.csv'
WITH (
    FIRSTROW = 2,
    FIELDTERMINATOR = ',',
    ROWTERMINATOR = '\n',
    TABLOCK,
    CODEPAGE = '65001'
);
GO

BULK INSERT dbo.OrderDetails
FROM 'C:\Users\Loq\Downloads\repo\bi_project\data\cleaned\OrderDetails.csv'
WITH (
    FIRSTROW = 2,
    FIELDTERMINATOR = ',',
    ROWTERMINATOR = '\n',
    TABLOCK,
    CODEPAGE = '65001'
);
GO
