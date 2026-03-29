{{ config(materialized='table') }} --configures the model to be materialized as a table

--this model is used to get the total number of products per order for the year 2022 and 2023
select 
    orders.date,
    orders.customer_id,
    orders.order_id,
    orders.net_sales,
    sales.total_products as qty_product --qty_product is the total number of products per order
from {{ ref('stg_astrafy__raw_orders') }} orders --refers to the staging model
left join ( --creates a temporary table to store the total number of products per order
    select
        order_id,
        sum(qty) as total_products
    from {{ ref('stg_astrafy__raw_sales') }}
    group by order_id
) sales --joins the temporary table with the staging model
    on orders.order_id = sales.order_id