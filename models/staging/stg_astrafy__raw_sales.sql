with source as ( --creates a temporary table to store the sales
    select
        date_date,
        customer_id,
        order_id,
        products_id,
        net_sales,
        qty
    from {{ source('astrafy', 'raw_sales') }}
),

renamed as ( --creates a temporary table to store the renamed sales
    select
        parse_date('%Y-%m-%d', date_date) as date,
        cast(customer_id as int64) as customer_id,
        cast(order_id as int64) as order_id,
        cast(products_id as int64) as product_id,
        cast(replace(net_sales, ',', '.') as float64) as net_sales,
        cast(qty as int64) as qty
    from source
)

select
    date,
    customer_id,
    order_id,
    product_id,
    net_sales,
    qty
from renamed