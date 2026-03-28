-- the orders info added the segmentation column for each order
with orders as (
    select *
    from {{ ref('stg_astrafy__raw_orders') }}
),

orders_with_history as (
    select
        o1.date_date,
        o1.customers_id,
        o1.orders_id,
        o1.net_sales
    from orders o1
    left join orders o2
        on o1.customers_id = o2.customers_id
        and o2.date_date < o1.date_date
        and o2.date_date >= date_sub(o1.date_date, interval 12 month)
    group by o1.orders_id, o1.customers_id, o1.date_date, o1.net_sales
)

select *,
    case
        when orders_last_12m = 0 then 'New'
        when orders_last_12m between 1 and 3 then 'Returning'
        else 'VIP'
    end as segment
from orders_with_history