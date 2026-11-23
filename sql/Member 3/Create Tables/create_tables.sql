CREATE TABLE Dim_Product (
    product_key INT PRIMARY KEY,
    sku VARCHAR(50),
    category_name VARCHAR(100),
    price DECIMAL(10,2)
);

CREATE TABLE Dim_Date (
    date_key INT PRIMARY KEY,
    full_date DATE,
    year_num INT,
    month_num INT,
    month_name VARCHAR(20),
    month_year VARCHAR(20),
    day_of_month INT,
    day_of_week INT,
    day_name VARCHAR(20),
    is_weekend BIT
);


CREATE TABLE Dim_Customer (
    customer_key INT PRIMARY KEY,
    customer_since DATE
);

CREATE TABLE Dim_PaymentMethod (
    payment_method_key INT PRIMARY KEY,
    payment_method_name VARCHAR(50),
    payment_channel VARCHAR(50)
);

CREATE TABLE Fact_Orders (
    order_id INT PRIMARY KEY,
    customer_key INT,
    payment_method_key INT,
    order_date_key INT,
    order_status VARCHAR(50),
    grand_total DECIMAL(12,2),

    FOREIGN KEY (customer_key)
        REFERENCES Dim_Customer(customer_key),

    FOREIGN KEY (payment_method_key)
        REFERENCES Dim_PaymentMethod(payment_method_key),

    FOREIGN KEY (order_date_key)
        REFERENCES Dim_Date(date_key)
);

CREATE TABLE Fact_OrderItems (
    order_detail_id INT PRIMARY KEY,
    order_id INT,
    product_key INT,
    order_date_key INT,
    qty_ordered INT,
    unit_price DECIMAL(10,2),
    discount_amount DECIMAL(10,2),
    total_amount DECIMAL(12,2),

    FOREIGN KEY (order_id)
        REFERENCES Fact_Orders(order_id),

    FOREIGN KEY (product_key)
        REFERENCES Dim_Product(product_key),

    FOREIGN KEY (order_date_key)
        REFERENCES Dim_Date(date_key)
);

