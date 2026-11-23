USE master;
GO

IF NOT EXISTS (SELECT name FROM sys.databases WHERE name = 'RetailEcommerce_DB')
BEGIN
    CREATE DATABASE RetailEcommerce_DB;
END
GO

USE RetailEcommerce_DB;
GO
