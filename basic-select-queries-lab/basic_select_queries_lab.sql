-- SQL Pre-Work — Lesson 4: Basic SELECT Queries — Lab
-- Student: Dakshayini M L

-- Lab Setup
DROP DATABASE IF EXISTS sql_select_lab;
CREATE DATABASE sql_select_lab;
USE sql_select_lab;

CREATE TABLE orders (
    order_id INT PRIMARY KEY,
    customer_name VARCHAR(100) NOT NULL,
    city VARCHAR(60),
    order_date DATE NOT NULL,
    status VARCHAR(20) NOT NULL,
    total_amount DECIMAL(10,2) NOT NULL,
    coupon_code VARCHAR(20) NULL
);

INSERT INTO orders VALUES
(101, 'Amit Patil', 'Pune',       '2026-08-01', 'DELIVERED', 1200.00, 'SAVE10'),
(102, 'Neha Shah', 'Mumbai',     '2026-08-02', 'SHIPPED',    850.00, NULL),
(103, 'Rahul Verma', 'Delhi',    '2026-08-03', 'PLACED',    2100.00, 'NEW20'),
(104, 'Priya Nair', 'Bengaluru', '2026-08-04', 'CANCELLED',  499.00, NULL),
(105, 'Arjun Mehta', 'Pune',     '2026-08-05', 'DELIVERED', 3200.00, 'SAVE10'),
(106, 'Kavya Iyer', 'Chennai',   '2026-08-06', 'SHIPPED',   1750.00, NULL),
(107, 'Sara Khan', 'Mumbai',     '2026-08-07', 'PLACED',     999.00, 'NEW20'),
(108, 'Rohan Das', 'Pune',       '2026-08-08', 'DELIVERED', 2400.00, NULL),
(109, 'Maya Rao', NULL,          '2026-08-09', 'PLACED',     650.00, NULL),
(110, 'Vikram Singh', 'Delhi',   '2026-08-10', 'SHIPPED',   1800.00, 'SAVE10');

-- Part 1: Select and Filter
-- Q.1: Select All Orders
SELECT * FROM orders;

-- Q.2: Select Specific Columns
SELECT order_id, customer_name, total_amount FROM orders;

-- Q.3: Filter by Status
SELECT * FROM orders WHERE status = 'DELIVERED';

-- Part 2: Conditions and Membership
-- Q.5: Combine Conditions
SELECT * FROM orders WHERE city = 'Pune' AND total_amount > 1500;

-- Q.6: Use IN
SELECT * FROM orders WHERE status IN ('PLACED', 'SHIPPED');

-- Q.7: Use BETWEEN
SELECT * FROM orders WHERE total_amount BETWEEN 1000 AND 2000;

-- Part 3: Distinct, Pattern, Null, and Aliases
-- Q.9: Return Distinct Cities
SELECT DISTINCT city FROM orders WHERE city IS NOT NULL ORDER BY city;

-- Q.10: Search with LIKE
SELECT order_id, customer_name FROM orders WHERE customer_name LIKE 'P%';

-- Q.11: Find Missing Cities
SELECT order_id, customer_name, city FROM orders WHERE city IS NULL;

-- Part 4: Sort, Limit, and Logical Query Flow
-- Q.13: Sort Highest Amount First
SELECT order_id, customer_name, total_amount FROM orders ORDER BY total_amount DESC;

-- Q.14: Return the Top Three Rows
SELECT order_id, customer_name, total_amount FROM orders ORDER BY total_amount DESC LIMIT 3;

-- Q.15: Use an Alias
SELECT order_id, total_amount AS order_value FROM orders;

-- Optional Practice
-- Q.17: Use NOT IN
SELECT * FROM orders WHERE status NOT IN ('CANCELLED', 'DELIVERED');

-- Q.18: Date Range Filter
SELECT * FROM orders WHERE order_date BETWEEN '2026-08-04' AND '2026-08-08' ORDER BY order_date;

-- Q.19: Coupon Logic with NULL
SELECT order_id, customer_name, coupon_code FROM orders WHERE coupon_code IS NOT NULL;

-- Q.20: Combined Read Query
SELECT
    order_id,
    customer_name,
    status,
    total_amount AS order_value
FROM orders
WHERE status != 'CANCELLED'
  AND total_amount >= 900
ORDER BY order_date DESC
LIMIT 5;
