-- ============================================================================
-- SECTION B - Q1: INTERMEDIATE SQL QUERIES
-- ============================================================================

-- 1. Top 10 customers by revenue
SELECT 
    c.customer_id,
    c.customer_name,
    SUM(o.quantity * o.unit_price) AS total_revenue
FROM customers c
JOIN orders o ON c.customer_id = o.customer_id
WHERE o.payment_status = 'Completed'
GROUP BY c.customer_id, c.customer_name
ORDER BY total_revenue DESC
LIMIT 10;

-- 2. Month-over-Month (MoM) sales growth
WITH monthly_sales AS (
    SELECT 
        DATE_TRUNC('month', order_date) AS sales_month,
        SUM(quantity * unit_price) AS total_sales
    FROM orders
    WHERE payment_status = 'Completed'
    GROUP BY DATE_TRUNC('month', order_date)
)
SELECT 
    sales_month,
    total_sales,
    LAG(total_sales) OVER (ORDER BY sales_month) AS prev_month_sales,
    ROUND(
        (total_sales - LAG(total_sales) OVER (ORDER BY sales_month)) 
        / NULLIF(LAG(total_sales) OVER (ORDER BY sales_month), 0) * 100, 2
    ) AS mom_growth_pct
FROM monthly_sales;

-- 3. Customers who ordered in consecutive months
WITH customer_months AS (
    SELECT DISTINCT 
        customer_id,
        DATE_TRUNC('month', order_date) AS order_month
    FROM orders
),
consecutive_check AS (
    SELECT 
        customer_id,
        order_month,
        LAG(order_month) OVER (PARTITION BY customer_id ORDER BY order_month) AS prev_month
    FROM customer_months
)
SELECT DISTINCT customer_id
FROM consecutive_check
WHERE order_month = prev_month + INTERVAL '1 month';

-- 4. Products never ordered
SELECT 
    p.product_id,
    p.product_name
FROM products p
LEFT JOIN orders o ON p.product_id = o.product_id
WHERE o.order_id IS NULL;

-- 5. Revenue contribution percentage by category
WITH category_revenue AS (
    SELECT 
        p.category,
        SUM(o.quantity * o.unit_price) AS cat_revenue
    FROM orders o
    JOIN products p ON o.product_id = p.product_id
    WHERE o.payment_status = 'Completed'
    GROUP BY p.category
)
SELECT 
    category,
    cat_revenue,
    ROUND((cat_revenue / SUM(cat_revenue) OVER ()) * 100, 2) AS revenue_pct
FROM category_revenue
ORDER BY cat_revenue DESC;


-- ============================================================================
-- SECTION B - Q2: ADVANCED SQL
-- ============================================================================

-- 1. Rank customers based on total revenue
SELECT 
    c.customer_id,
    c.customer_name,
    SUM(o.quantity * o.unit_price) AS total_revenue,
    DENSE_RANK() OVER (ORDER BY SUM(o.quantity * o.unit_price) DESC) AS revenue_rank
FROM customers c
JOIN orders o ON c.customer_id = o.customer_id
WHERE o.payment_status = 'Completed'
GROUP BY c.customer_id, c.customer_name;

-- 2. Running total sales by month
WITH monthly_sales AS (
    SELECT 
        DATE_TRUNC('month', order_date) AS sales_month,
        SUM(quantity * unit_price) AS monthly_revenue
    FROM orders
    WHERE payment_status = 'Completed'
    GROUP BY DATE_TRUNC('month', order_date)
)
SELECT 
    sales_month,
    monthly_revenue,
    SUM(monthly_revenue) OVER (ORDER BY sales_month ASC) AS running_total_sales
FROM monthly_sales;

-- 3. Highest selling product per category (by revenue)
WITH product_revenue AS (
    SELECT 
        p.category,
        p.product_id,
        p.product_name,
        SUM(o.quantity * o.unit_price) AS total_revenue,
        ROW_NUMBER() OVER (
            PARTITION BY p.category 
            ORDER BY SUM(o.quantity * o.unit_price) DESC
        ) AS rank_in_cat
    FROM products p
    JOIN orders o ON p.product_id = o.product_id
    WHERE o.payment_status = 'Completed'
    GROUP BY p.category, p.product_id, p.product_name
)
SELECT category, product_id, product_name, total_revenue
FROM product_revenue
WHERE rank_in_cat = 1;

-- 4. 7-day rolling average sales
WITH daily_sales AS (
    SELECT 
        CAST(order_date AS DATE) AS sale_date,
        SUM(quantity * unit_price) AS daily_revenue
    FROM orders
    WHERE payment_status = 'Completed'
    GROUP BY CAST(order_date AS DATE)
)
SELECT 
    sale_date,
    daily_revenue,
    ROUND(
        AVG(daily_revenue) OVER (
            ORDER BY sale_date 
            ROWS BETWEEN 6 PRECEDING AND CURRENT ROW
        ), 2
    ) AS rolling_7day_avg_sales
FROM daily_sales;



-- 1. Shipment Tracking
CREATE TABLE shipments (
    shipment_id SERIAL PRIMARY KEY,
    order_id INT NOT NULL REFERENCES orders(order_id),
    carrier_name VARCHAR(100) NOT NULL,
    tracking_number VARCHAR(100) UNIQUE NOT NULL,
    shipment_status VARCHAR(50) NOT NULL DEFAULT 'In Transit',
    dispatch_date TIMESTAMP,
    estimated_delivery DATE,
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP
);

CREATE INDEX idx_shipments_order ON shipments(order_id);
CREATE INDEX idx_shipments_status ON shipments(shipment_status);

-- 2. Product Inventory
CREATE TABLE inventory (
    inventory_id SERIAL PRIMARY KEY,
    product_id INT NOT NULL REFERENCES products(product_id),
    warehouse_location VARCHAR(100) NOT NULL,
    stock_quantity INT NOT NULL CHECK (stock_quantity >= 0),
    reserved_quantity INT DEFAULT 0 CHECK (reserved_quantity >= 0),
    last_updated TIMESTAMP DEFAULT CURRENT_TIMESTAMP
);

CREATE INDEX idx_inventory_product ON inventory(product_id);

-- 3. Customer Support Tickets
CREATE TABLE customer_support_tickets (
    ticket_id SERIAL PRIMARY KEY,
    customer_id INT NOT NULL REFERENCES customers(customer_id),
    order_id INT REFERENCES orders(order_id),
    issue_category VARCHAR(100) NOT NULL,
    ticket_status VARCHAR(50) NOT NULL DEFAULT 'Open',
    priority VARCHAR(20) DEFAULT 'Medium',
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    resolved_at TIMESTAMP
);

CREATE INDEX idx_tickets_customer ON customer_support_tickets(customer_id);
CREATE INDEX idx_tickets_status_priority ON customer_support_tickets(ticket_status, priority);