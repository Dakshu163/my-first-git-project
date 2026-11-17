select
    o.order_id,
    o.customer_id,
    o.order_date,
    o.order_amount,
    case when o.order_status = 'refunded' then 0 else o.order_amount end as net_amount
from {{ ref('stg_orders') }} o