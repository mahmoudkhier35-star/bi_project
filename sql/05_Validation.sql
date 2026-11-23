USE RetailEcommerce_DB;
GO

SELECT 'Categories' AS TableName, COUNT(*) AS RecordCount FROM dbo.Categories
UNION ALL
SELECT 'PaymentMethods', COUNT(*) FROM dbo.PaymentMethods
UNION ALL
SELECT 'Products', COUNT(*) FROM dbo.Products
UNION ALL
SELECT 'Customers', COUNT(*) FROM dbo.Customers
UNION ALL
SELECT 'Orders', COUNT(*) FROM dbo.Orders
UNION ALL
SELECT 'OrderDetails', COUNT(*) FROM dbo.OrderDetails;
GO

SELECT 'Duplicate Customers' AS CheckName, COUNT(*) AS FailureCount 
FROM (SELECT customer_id FROM dbo.Customers GROUP BY customer_id HAVING COUNT(*) > 1) t
UNION ALL
SELECT 'Duplicate Categories', COUNT(*) 
FROM (SELECT category_id FROM dbo.Categories GROUP BY category_id HAVING COUNT(*) > 1) t
UNION ALL
SELECT 'Duplicate PaymentMethods', COUNT(*) 
FROM (SELECT payment_method_id FROM dbo.PaymentMethods GROUP BY payment_method_id HAVING COUNT(*) > 1) t
UNION ALL
SELECT 'Duplicate Products', COUNT(*) 
FROM (SELECT product_id FROM dbo.Products GROUP BY product_id HAVING COUNT(*) > 1) t
UNION ALL
SELECT 'Duplicate Orders', COUNT(*) 
FROM (SELECT order_id FROM dbo.Orders GROUP BY order_id HAVING COUNT(*) > 1) t
UNION ALL
SELECT 'Duplicate OrderDetails', COUNT(*) 
FROM (SELECT order_detail_id FROM dbo.OrderDetails GROUP BY order_detail_id HAVING COUNT(*) > 1) t;
GO

SELECT 'Orphan Orders (Customer FK)' AS CheckName, COUNT(*) AS OrphanCount
FROM dbo.Orders o
LEFT JOIN dbo.Customers c ON o.customer_id = c.customer_id
WHERE c.customer_id IS NULL
UNION ALL
SELECT 'Orphan Orders (PaymentMethod FK)', COUNT(*)
FROM dbo.Orders o
LEFT JOIN dbo.PaymentMethods pm ON o.payment_method_id = pm.payment_method_id
WHERE pm.payment_method_id IS NULL
UNION ALL
SELECT 'Orphan OrderDetails (Order FK)', COUNT(*)
FROM dbo.OrderDetails od
LEFT JOIN dbo.Orders o ON od.order_id = o.order_id
WHERE o.order_id IS NULL
UNION ALL
SELECT 'Orphan OrderDetails (Product FK)', COUNT(*)
FROM dbo.OrderDetails od
LEFT JOIN dbo.Products p ON od.product_id = p.product_id
WHERE p.product_id IS NULL
UNION ALL
SELECT 'Orphan Products (Category FK)', COUNT(*)
FROM dbo.Products p
LEFT JOIN dbo.Categories c ON p.category_id = c.category_id
WHERE c.category_id IS NULL;
GO

SELECT 
    COUNT(DISTINCT o.order_id) AS TotalOrders,
    COUNT(od.order_detail_id) AS TotalOrderLines,
    SUM(o.grand_total) AS TotalOrderGrandTotal,
    SUM(od.total_amount) AS TotalLinesAmount
FROM dbo.Orders o
JOIN dbo.OrderDetails od ON o.order_id = od.order_id;
GO
