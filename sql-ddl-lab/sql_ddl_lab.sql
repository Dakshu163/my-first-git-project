-- SQL Pre-Work — Lesson 2: SQL DDL — Lab
-- Student: Dakshayini M L

-- Part 1: Create Databases and Tables
CREATE DATABASE IF NOT EXISTS sql_ddl_lab;
USE sql_ddl_lab;

SELECT DATABASE() AS current_database;

-- Safe cleanup so script is rerunnable (child tables before parent tables - Q.19)
DROP TABLE IF EXISTS order_items;
DROP TABLE IF EXISTS orders;
DROP TABLE IF EXISTS products;
DROP TABLE IF EXISTS customers;
DROP TABLE IF EXISTS staging_customers;

-- Q.2: Create customers table
CREATE TABLE customers (
    customer_id INT PRIMARY KEY,
    email VARCHAR(120) NOT NULL,
    customer_name VARCHAR(100) NOT NULL,
    city VARCHAR(60),
    created_at DATETIME DEFAULT CURRENT_TIMESTAMP
);

-- Q.3: Add UNIQUE constraint on email
ALTER TABLE customers
ADD CONSTRAINT uq_customers_email UNIQUE (email);

DESCRIBE customers;

-- Part 2: Constraints and Relationships
-- Q.5: Create products table with CHECK constraint
CREATE TABLE products (
    product_id INT PRIMARY KEY,
    sku VARCHAR(40) NOT NULL UNIQUE,
    product_name VARCHAR(100) NOT NULL,
    price DECIMAL(10,2) NOT NULL,
    CONSTRAINT chk_product_price CHECK (price > 0)
);

-- Q.6: Create parent/child orders table with FOREIGN KEY
CREATE TABLE orders (
    order_id INT PRIMARY KEY,
    customer_id INT NOT NULL,
    order_date DATE NOT NULL,
    status VARCHAR(20) NOT NULL DEFAULT 'PLACED',
    CONSTRAINT fk_orders_customer
        FOREIGN KEY (customer_id) REFERENCES customers(customer_id)
);

-- Q.7: Create order_items with composite primary key (order_id, product_id)
CREATE TABLE order_items (
    order_id INT NOT NULL,
    product_id INT NOT NULL,
    quantity INT NOT NULL,
    unit_price DECIMAL(10,2) NOT NULL,
    PRIMARY KEY (order_id, product_id),
    FOREIGN KEY (order_id) REFERENCES orders(order_id),
    FOREIGN KEY (product_id) REFERENCES products(product_id),
    CHECK (quantity > 0)
);

-- Part 3: ALTER TABLE and Column Definitions
-- Q.9: Add optional phone column
ALTER TABLE customers
ADD COLUMN phone VARCHAR(20);

-- Q.10: Modify customer_name length to VARCHAR(150) NOT NULL
ALTER TABLE customers
MODIFY COLUMN customer_name VARCHAR(150) NOT NULL;

-- Q.11: Add country column with DEFAULT 'India'
ALTER TABLE customers
ADD COLUMN country VARCHAR(60) NOT NULL DEFAULT 'India';

DESCRIBE customers;

-- Part 4: DROP, TRUNCATE, and Safe Structure Changes
-- Q.14: Create and truncate disposable table
CREATE TABLE staging_customers (
    customer_id INT,
    customer_name VARCHAR(100),
    city VARCHAR(60)
);

TRUNCATE TABLE staging_customers;
DESCRIBE staging_customers;

-- Q.15: Drop disposable table and list remaining tables
DROP TABLE staging_customers;
SHOW TABLES;

-- Optional Practice Q.20: Complete four-table schema in sql_ddl_final
CREATE DATABASE IF NOT EXISTS sql_ddl_final;
USE sql_ddl_final;

DROP TABLE IF EXISTS order_items;
DROP TABLE IF EXISTS orders;
DROP TABLE IF EXISTS products;
DROP TABLE IF EXISTS customers;

CREATE TABLE customers (
    customer_id INT PRIMARY KEY,
    email VARCHAR(120) NOT NULL UNIQUE,
    customer_name VARCHAR(150) NOT NULL
);

CREATE TABLE products (
    product_id INT PRIMARY KEY,
    sku VARCHAR(40) NOT NULL UNIQUE,
    product_name VARCHAR(100) NOT NULL,
    price DECIMAL(10,2) NOT NULL CHECK (price > 0)
);

CREATE TABLE orders (
    order_id INT PRIMARY KEY,
    customer_id INT NOT NULL,
    order_date DATE NOT NULL,
    status VARCHAR(20) NOT NULL DEFAULT 'PLACED',
    FOREIGN KEY (customer_id) REFERENCES customers(customer_id)
);

CREATE TABLE order_items (
    order_id INT NOT NULL,
    product_id INT NOT NULL,
    quantity INT NOT NULL CHECK (quantity > 0),
    unit_price DECIMAL(10,2) NOT NULL,
    PRIMARY KEY (order_id, product_id),
    FOREIGN KEY (order_id) REFERENCES orders(order_id),
    FOREIGN KEY (product_id) REFERENCES products(product_id)
);

SHOW TABLES;
