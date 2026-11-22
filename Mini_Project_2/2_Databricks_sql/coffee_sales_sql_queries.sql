CREATE OR REPLACE TABLE coffee_sales AS
SELECT *
FROM read_files(
    '/Volumes/workspace/default/coffee2',
    format => 'csv',
    header => true
);

-- Q1. Top 5 best-selling coffee types by revenue
SELECT coffee_name, ROUND(SUM(money), 2) AS total_revenue
FROM coffee_sales
GROUP BY coffee_name
ORDER BY total_revenue DESC
LIMIT 5;

-- Q2. Total revenue by payment type (cash_type)
SELECT cash_type, ROUND(SUM(money), 2) AS total_revenue
FROM coffee_sales
GROUP BY cash_type;

-- Q3. Total revenue per month using a CTE
WITH monthly_sales AS (
    SELECT DATE_TRUNC('month', CAST(date AS DATE)) AS sales_month, money
    FROM coffee_sales
)
SELECT sales_month, ROUND(SUM(money), 2) AS total_revenue
FROM monthly_sales
GROUP BY sales_month
ORDER BY sales_month;

-- Q4. Day with the highest number of transactions
SELECT date, COUNT(*) AS transaction_count
FROM coffee_sales
GROUP BY date
ORDER BY transaction_count DESC
LIMIT 1;