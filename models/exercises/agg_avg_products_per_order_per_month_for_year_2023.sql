select
    extract(month from orders.date_date) as month,
    avg(sales.products_per_order) as avg_products
from {{ ref('stg_astrafy__raw_orders') }} orders

join (
    select order_id, count(*) as products_per_order
    from {{ ref('stg_astrafy__raw_sales') }}
    group by 1
    ) sales on orders.orders_id = sales.order_id

where extract(year from orders.date_date) = 2023
group by 1
order by 1