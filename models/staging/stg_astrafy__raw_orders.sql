with source as ( --creates a temporary table to store the orders
    select
        date_date,
        customers_id,
        orders_id,
        net_sales
    from {{source('astrafy', 'raw_orders')}} --refers to the source model
),

renamed as ( --creates a temporary table to store the renamed orders
    select
        parse_date('%Y-%m-%d', date_date) as date,
        cast(customers_id as int64) as customer_id,
        cast(orders_id as int64) as order_id,
        cast(replace(net_sales, ',', '.') as float64) as net_sales
    from source
)

select
    date,
    customer_id,
    order_id,
    net_sales
from renamed