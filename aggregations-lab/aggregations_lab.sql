-- SQL Pre-Work — Lesson 5: Aggregations — Lab
-- Student: Dakshayini M L

-- Lab Setup
DROP DATABASE IF EXISTS sql_aggregation_lab;
CREATE DATABASE sql_aggregation_lab;
USE sql_aggregation_lab;

CREATE TABLE orders (
    order_id INT PRIMARY KEY,
    customer_id INT NOT NULL,
    city VARCHAR(60) NOT NULL,
    order_date DATE NOT NULL,
    status VARCHAR(20) NOT NULL,
    total_amount DECIMAL(10,2) NOT NULL,
    discount_amount DECIMAL(10,2) NULL
);

INSERT INTO orders VALUES
(101, 1, 'Pune',       '2026-08-01', 'DELIVERED', 1200.00, 100.00),
(102, 2, 'Mumbai',     '2026-08-01', 'SHIPPED',    850.00, NULL),
(103, 3, 'Delhi',      '2026-08-02', 'PLACED',    2100.00, 200.00),
(104, 4, 'Bengaluru',  '2026-08-02', 'CANCELLED',  499.00, NULL),
(105, 1, 'Pune',       '2026-08-03', 'DELIVERED', 3200.00, 250.00),
(106, 5, 'Chennai',    '2026-08-03', 'SHIPPED',   1750.00, NULL),
(107, 2, 'Mumbai',     '2026-08-04', 'PLACED',     999.00,  50.00),
(108, 6, 'Pune',       '2026-08-04', 'DELIVERED', 2400.00, NULL),
(109, 3, 'Delhi',      '2026-08-05', 'PLACED',     650.00, NULL),
(110, 7, 'Delhi',      '2026-08-05', 'SHIPPED',   1800.00, 150.00),
(111, 8, 'Mumbai',     '2026-08-06', 'DELIVERED', 2750.00, 200.00),
(112, 1, 'Pune',       '2026-08-06', 'DELIVERED', 1300.00, NULL);

-- Part 1: Basic Aggregate Functions
-- Q.1: Count All Rows
SELECT COUNT(*) AS total_orders FROM orders;

-- Q.2: Count Non-Null Discounts
SELECT COUNT(discount_amount) AS orders_with_discount FROM orders;

-- Q.3: Count Distinct Customers
SELECT COUNT(DISTINCT customer_id) AS distinct_customers FROM orders;

-- Part 2: Sum, Average, Minimum, and Maximum
-- Q.5: Calculate Total Revenue Value
SELECT SUM(total_amount) AS total_order_value FROM orders;

-- Q.6: Calculate Average Order Value
SELECT AVG(total_amount) AS average_order_value FROM orders;

-- Q.7: Find Minimum and Maximum
SELECT
    MIN(total_amount) AS minimum_order_value,
    MAX(total_amount) AS maximum_order_value
FROM orders;

-- Part 3: Grouping and Result Grain
-- Q.9: Count Orders by Status
SELECT status, COUNT(*) AS order_count
FROM orders
GROUP BY status
ORDER BY status;

-- Q.10: Revenue by City
SELECT city, SUM(total_amount) AS city_order_value
FROM orders
GROUP BY city
ORDER BY city;

-- Q.11: Group by Two Columns
SELECT city, status, COUNT(*) AS order_count
FROM orders
GROUP BY city, status
ORDER BY city, status;

-- Part 4: WHERE, HAVING, and Business Aggregation
-- Q.13: Filter Before Grouping
SELECT city, SUM(total_amount) AS delivered_value
FROM orders
WHERE status = 'DELIVERED'
GROUP BY city
ORDER BY city;

-- Q.14: Filter Groups with HAVING
SELECT city, SUM(total_amount) AS city_order_value
FROM orders
GROUP BY city
HAVING SUM(total_amount) > 3000
ORDER BY city_order_value DESC;

-- Optional Practice
-- Q.17: Daily Order Summary
SELECT
    order_date,
    COUNT(*) AS order_count,
    SUM(total_amount) AS total_value
FROM orders
GROUP BY order_date
ORDER BY order_date;

-- Q.18: Customers with More Than One Order
SELECT customer_id, COUNT(*) AS order_count
FROM orders
GROUP BY customer_id
HAVING COUNT(*) > 1
ORDER BY customer_id;

-- Q.19: Observe Null Behaviour
SELECT
    COUNT(*) AS all_rows,
    COUNT(discount_amount) AS non_null_discounts
FROM orders;

-- Q.20: Combined Business Summary
SELECT
    city,
    COUNT(*) AS order_count,
    SUM(total_amount) AS total_value,
    AVG(total_amount) AS average_value,
    MIN(total_amount) AS minimum_value,
    MAX(total_amount) AS maximum_value
FROM orders
WHERE status != 'CANCELLED'
GROUP BY city
HAVING COUNT(*) >= 2
ORDER BY total_value DESC;
