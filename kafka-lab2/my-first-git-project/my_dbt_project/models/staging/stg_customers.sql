select
    customer_id,
    first_name,
    last_name,
    email,
    signup_date::date as signup_date
from {{ source('raw', 'customers') }}