select
    p.order_id,
    p.customer_id,
    c.first_name,
    c.last_name,
    p.order_date,
    p.net_amount
from {{ ref('int_order_payments') }} p
left join {{ ref('stg_customers') }} c
    on p.customer_id = c.customer_id