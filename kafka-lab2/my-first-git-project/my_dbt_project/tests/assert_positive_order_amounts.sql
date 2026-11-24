select *
from {{ ref('fct_orders') }}
where net_amount < 0