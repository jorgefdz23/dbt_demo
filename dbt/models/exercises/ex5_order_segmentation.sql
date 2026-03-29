--this model is used to get the segmentation of orders in 2023 based on the number of previous orders in the past 12 months

with orders as ( --creates a temporary table to store the orders
    select
        date,
        customer_id,
        order_id,
        net_sales
    from {{ ref('stg_astrafy__raw_orders') }}
),

orders_with_history as ( --creates a temporary table to store the orders with history
    select
        o1.date,
        o1.customer_id,
        o1.order_id,
        o1.net_sales,
        count(o2.order_id) as orders_last_12m
    from orders o1
    left join orders o2
        on o1.customer_id = o2.customer_id
        and o2.date < o1.date
        and o2.date >= date_sub(o1.date, interval 12 month)
    group by o1.order_id, o1.customer_id, o1.date, o1.net_sales
)

select
    date,
    customer_id,
    order_id,
    net_sales,
    case 
        when orders_last_12m = 0 then 'New'
        when orders_last_12m between 1 and 3 then 'Returning'
        else 'VIP'
    end as segment --segment is the segmentation of the order
from orders_with_history --joins the temporary table with the staging model
where extract(year from date) = 2023 --selects only orders from 2023