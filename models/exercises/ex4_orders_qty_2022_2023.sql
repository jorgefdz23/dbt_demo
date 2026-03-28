{{ config(materialized='table') }}

select
    orders.*,
    sales.total_products as qty_product
from {{ ref('stg_astrafy__raw_orders') }} orders
left join (
    select order_id, sum(qty) as total_products
    from {{ ref('stg_astrafy__raw_sales') }}
    group by 1
) sales
on orders.orders_id = sales.order_id