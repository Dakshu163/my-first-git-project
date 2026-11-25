SELECT
    customer,
    COUNT(DISTINCT order_id) AS total_orders,
    SUM(amount) AS total_sales,
    ROUND(AVG(amount), 2) AS avg_order_value
FROM {{ ref('sales_data') }}
GROUP BY customer
ORDER BY total_sales DESC