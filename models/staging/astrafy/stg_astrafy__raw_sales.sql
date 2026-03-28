with 
source as (
    select * from {{ source('astrafy', 'raw_sales') }}
),

renamed as (
    select
        parse_date('%Y-%m-%d', date_date) AS date_date,
        cast(customer_id AS int64) AS customer_id,
        cast(order_id AS int64) AS order_id,
        cast(products_id AS int64) AS products_id,
        cast(replace(net_sales, ',', '.') AS float64) AS net_sales,
        cast(qty AS int64) AS qty
    from source
)

select * from renamed