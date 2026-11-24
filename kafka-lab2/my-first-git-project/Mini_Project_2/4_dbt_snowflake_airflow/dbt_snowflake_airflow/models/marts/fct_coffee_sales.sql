SELECT
    sale_date,
    COUNT(*) AS total_orders,
    ROUND(SUM(amount), 2) AS total_daily_revenue,
    ROUND(AVG(amount), 2) AS avg_order_value
FROM {{ ref('stg_coffee_sales') }}
GROUP BY sale_date
ORDER BY sale_date DESC