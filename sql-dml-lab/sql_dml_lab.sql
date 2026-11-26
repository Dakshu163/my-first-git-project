-- SQL Pre-Work — Lesson 3: SQL DML — Lab
-- Student: Dakshayini M L

-- Lab Setup
DROP DATABASE IF EXISTS sql_dml_lab;
CREATE DATABASE sql_dml_lab;
USE sql_dml_lab;

CREATE TABLE customers (
    customer_id INT PRIMARY KEY,
    email VARCHAR(120) NOT NULL UNIQUE,
    customer_name VARCHAR(100) NOT NULL,
    city VARCHAR(60)
);

CREATE TABLE orders (
    order_id INT PRIMARY KEY,
    customer_id INT NOT NULL,
    order_date DATE NOT NULL,
    status VARCHAR(20) NOT NULL DEFAULT 'PLACED',
    total_amount DECIMAL(10,2) NOT NULL,
    FOREIGN KEY (customer_id) REFERENCES customers(customer_id)
);

INSERT INTO customers VALUES
(1, 'amit@example.com', 'Amit Patil', 'Pune'),
(2, 'neha@example.com', 'Neha Shah', 'Mumbai'),
(3, 'rahul@example.com', 'Rahul Verma', 'Delhi');

INSERT INTO orders VALUES
(101, 1, '2026-08-01', 'PLACED', 1200.00),
(102, 2, '2026-08-02', 'SHIPPED', 850.00),
(103, 1, '2026-08-03', 'DELIVERED', 2100.00);

SELECT * FROM customers ORDER BY customer_id;
SELECT * FROM orders ORDER BY order_id;

-- Part 1: Insert Data
-- Q.1: Insert One Customer
INSERT INTO customers (customer_id, email, customer_name, city)
VALUES (4, 'priya@example.com', 'Priya Nair', 'Bengaluru');
SELECT * FROM customers WHERE customer_id = 4;

-- Q.2: Insert Multiple Customers
INSERT INTO customers (customer_id, email, customer_name, city) VALUES
(5, 'arjun@example.com', 'Arjun Mehta', 'Ahmedabad'),
(6, 'kavya@example.com', 'Kavya Iyer', 'Chennai');
SELECT * FROM customers WHERE customer_id IN (5, 6);

-- Q.3: Insert an Order
INSERT INTO orders (order_id, customer_id, order_date, status, total_amount)
VALUES (104, 3, '2026-08-04', 'PLACED', 999.00);
SELECT * FROM orders WHERE order_id = 104;

-- Part 2: Update Data Safely
-- Q.5 & Q.6: Preview and update customer 2 to Pune
SELECT customer_id, customer_name, city FROM customers WHERE customer_id = 2;
UPDATE customers SET city = 'Pune' WHERE customer_id = 2;
SELECT * FROM customers WHERE customer_id = 2;

-- Q.7: Update multiple columns on order 101
UPDATE orders
SET status = 'SHIPPED',
    total_amount = 1250.00
WHERE order_id = 101;
SELECT * FROM orders WHERE order_id = 101;

-- Part 3: Delete and Referential Integrity
-- Q.9: Delete order 104
DELETE FROM orders WHERE order_id = 104;
SELECT * FROM orders WHERE order_id = 104;

-- Q.10: Preview PLACED orders
SELECT * FROM orders WHERE status = 'PLACED';

-- Q.11: Attempt parent delete with existing child orders (fails due to FK)
-- DELETE FROM customers WHERE customer_id = 1;

-- Part 4: Transactions, Commit, and Rollback
-- Q.13: Rollback an update
START TRANSACTION;
UPDATE customers SET city = 'Jaipur' WHERE customer_id = 3;
SELECT * FROM customers WHERE customer_id = 3;
ROLLBACK;
SELECT * FROM customers WHERE customer_id = 3;

-- Q.14: Commit an update
START TRANSACTION;
UPDATE customers SET city = 'Gurugram' WHERE customer_id = 3;
COMMIT;
SELECT * FROM customers WHERE customer_id = 3;

-- Optional Practice
-- Q.17: Duplicate email constraint failure (fails due to UNIQUE)
-- INSERT INTO customers (customer_id, email, customer_name, city) VALUES (7, 'amit@example.com', 'Another Amit', 'Pune');

-- Q.18: Update all matching PLACED rows to PROCESSING
SELECT * FROM orders WHERE status = 'PLACED';
UPDATE orders SET status = 'PROCESSING' WHERE status = 'PLACED';
SELECT * FROM orders WHERE status = 'PROCESSING';

-- Q.19: Delete safely inside a transaction and rollback
START TRANSACTION;
DELETE FROM orders WHERE order_id = 102;
SELECT * FROM orders WHERE order_id = 102;
ROLLBACK;
SELECT * FROM orders WHERE order_id = 102;

-- Q.20: Integrated DML Change Set
START TRANSACTION;
INSERT INTO customers (customer_id, email, customer_name, city)
VALUES (8, 'sara@example.com', 'Sara Khan', 'Hyderabad');
INSERT INTO orders (order_id, customer_id, order_date, status, total_amount)
VALUES (108, 8, '2026-08-08', 'PLACED', 1750.00);
UPDATE orders SET status = 'SHIPPED' WHERE order_id = 108;
SELECT * FROM customers WHERE customer_id = 8;
SELECT * FROM orders WHERE order_id = 108;
COMMIT;
