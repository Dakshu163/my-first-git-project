with source as (
    select * from {{ source('raw', 'orders') }}
),
renamed as (
    select
        order_id,
        customer_id,
        order_date::date as order_date,
        status as order_status,
        amount::number(10,2) as order_amount
    from source
)
select * from renamed