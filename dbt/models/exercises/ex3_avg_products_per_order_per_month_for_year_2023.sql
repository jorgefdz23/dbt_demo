--this model is used to get the average number of products per order per month for the year 2023
with sales_per_order as ( --creates a temporary table to store the number of products per order
    select
        order_id,
        count(*) as products_per_order --counts the number of products per order
    from {{ ref('stg_astrafy__raw_sales') }} --refers to the staging model
    group by order_id
)

select
    extract(month from orders.date) as month,
    avg(sales.products_per_order) as avg_products
from {{ ref('stg_astrafy__raw_orders') }} orders --refers to the staging model
join sales_per_order as sales --joins the temporary table with the staging model
    on orders.order_id = sales.order_id

where extract(year from orders.date) = 2023 --selects only orders from 2023
group by month
order by month