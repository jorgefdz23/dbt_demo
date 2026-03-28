{{ config(materialized='table') }}

select 
    date_date,
    customers_id,
    orders_id,
    net_sales,
    segment
from {{ ref('ex5_order_segmentation') }} 
where extract(year from date_date) = 2023