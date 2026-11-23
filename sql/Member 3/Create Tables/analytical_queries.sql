--Total Sales--
SELECT
    SUM(grand_total) AS Total_Sales
FROM Fact_Orders;

--Total Orders--
SELECT
    COUNT(order_id) AS Total_Orders
FROM Fact_Orders;

--Average Order Value--
SELECT
    AVG(grand_total) AS Average_Order_Value
FROM Fact_Orders;

--Total Orders according to status--
SELECT
    order_status,
    COUNT(order_id) AS Total_Orders,
    SUM(grand_total) AS Total_Sales
FROM Fact_Orders
GROUP BY order_status
ORDER BY Total_Sales DESC;

--Sales according to year--
SELECT
    D.year_num,
    SUM(F.grand_total) AS Total_Sales
FROM Fact_Orders F
JOIN Dim_Date D
    ON F.order_date_key = D.date_key
GROUP BY D.year_num
ORDER BY D.year_num;


--Sales according to month--
SELECT
    D.year_num,
    D.month_num,
    D.month_name,
    SUM(F.grand_total) AS Total_Sales
FROM Fact_Orders F
JOIN Dim_Date D
    ON F.order_date_key = D.date_key
GROUP BY
    D.year_num,
    D.month_num,
    D.month_name
ORDER BY
    D.year_num,
    D.month_num;

--Comparing sales between holdidays and working days--
SELECT
    D.is_weekend,
    COUNT(F.order_id) AS Total_Orders,
    SUM(F.grand_total) AS Total_Sales
FROM Fact_Orders F
JOIN Dim_Date D
    ON F.order_date_key = D.date_key
GROUP BY D.is_weekend;

--Best Selling Products--
SELECT TOP 10
    P.sku,
    P.category_name,
    SUM(I.qty_ordered) AS Total_Quantity_Sold,
    SUM(I.total_amount) AS Total_Revenue
FROM Fact_OrderItems I
JOIN Dim_Product P
    ON I.product_key = P.product_key
GROUP BY
    P.sku,
    P.category_name
ORDER BY Total_Quantity_Sold DESC;

--Best Selling Categories--
SELECT
    P.category_name,
    SUM(I.qty_ordered) AS Total_Quantity,
    SUM(I.total_amount) AS Total_Revenue
FROM Fact_OrderItems I
JOIN Dim_Product P
    ON I.product_key = P.product_key
GROUP BY P.category_name
ORDER BY Total_Revenue DESC;

--Average unit price according to Category--
SELECT
    P.category_name,
    AVG(I.unit_price) AS Average_Unit_Price
FROM Fact_OrderItems I
JOIN Dim_Product P
    ON I.product_key = P.product_key
GROUP BY P.category_name
ORDER BY Average_Unit_Price DESC;

--Top 10 ordering Customers--
SELECT TOP 10
    C.customer_key,
    COUNT(F.order_id) AS Total_Orders,
    SUM(F.grand_total) AS Total_Spent
FROM Fact_Orders F
JOIN Dim_Customer C
    ON F.customer_key = C.customer_key
GROUP BY C.customer_key
ORDER BY Total_Orders DESC;

--Top 10 Paying Customers--
SELECT TOP 10
    C.customer_key,
    SUM(F.grand_total) AS Total_Spent
FROM Fact_Orders F
JOIN Dim_Customer C
    ON F.customer_key = C.customer_key
GROUP BY C.customer_key
ORDER BY Total_Spent DESC;

--New Customers according to years--
SELECT
    YEAR(customer_since) AS Join_Year,
    COUNT(customer_key) AS New_Customers
FROM Dim_Customer
GROUP BY YEAR(customer_since)
ORDER BY Join_Year;

--Most Used Payment methods--
SELECT
    P.payment_method_name,
    P.payment_channel,
    COUNT(F.order_id) AS Total_Orders,
    SUM(F.grand_total) AS Total_Sales
FROM Fact_Orders F
JOIN Dim_PaymentMethod P
    ON F.payment_method_key = P.payment_method_key
GROUP BY
    P.payment_method_name,
    P.payment_channel
ORDER BY Total_Orders DESC;

--Total discounts according to category--
SELECT
    P.category_name,
    SUM(I.discount_amount) AS Total_Discount,
    SUM(I.total_amount) AS Total_Revenue
FROM Fact_OrderItems I
JOIN Dim_Product P
    ON I.product_key = P.product_key
GROUP BY P.category_name
ORDER BY Total_Discount DESC;

--Top products getting discounts--
SELECT TOP 10
    P.sku,
    P.category_name,
    SUM(I.discount_amount) AS Total_Discount
FROM Fact_OrderItems I
JOIN Dim_Product P
    ON I.product_key = P.product_key
GROUP BY
    P.sku,
    P.category_name
ORDER BY Total_Discount DESC;


--Total Products, Sales, Orders, Customers--
SELECT
    (SELECT COUNT(*)
     FROM Fact_Orders) AS Total_Orders,

    (SELECT SUM(grand_total)
     FROM Fact_Orders) AS Total_Sales,

    (SELECT SUM(qty_ordered)
     FROM Fact_OrderItems) AS Total_Products_Sold,

    (SELECT COUNT(DISTINCT customer_key)
     FROM Fact_Orders) AS Total_Customers;
