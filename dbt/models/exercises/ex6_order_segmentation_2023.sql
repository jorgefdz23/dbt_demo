{{ config(materialized='table') }} --configures the model to be materialized as a table

--this model is used to get the segmentation of orders in 2023
select
    date,
    customer_id,
    order_id,
    net_sales,
    segment
from {{ ref('ex5_order_segmentation') }} --refers to the exercise model
where extract(year from date) = 2023 --selects only orders from 2023