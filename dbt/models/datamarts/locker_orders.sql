
{{ config(
    materialized='incremental', 
    incremental_strategy='merge', 
    unique_key='order_id', 
    partition_by={'field': 'date', 'data_type': 'date'}, 
    cluster_by=['customer_id', 'segment'], 
    on_schema_change='sync_all_columns' 
) }}

with all_orders as ( --creates a temporary table to store the orders
    select
        date,
        customer_id,
        order_id,
        net_sales
    from {{ ref('stg_astrafy__raw_orders') }}
),

candidate_orders as ( --creates a temporary table to store the candidate orders
    select
        date,
        customer_id,
        order_id,
        net_sales
    from all_orders

--if the data is incremental, then select the data from the last 7 days
    {% if is_incremental() %} 
    where date >= date_sub( 
        (select coalesce(max(date), date('1900-01-01')) from {{ this }}), 
        interval 7 day
    )
    {% endif %}
),

orders_with_history as ( --creates a temporary table to store the orders with history
    select
        o1.date,
        o1.customer_id,
        o1.order_id,
        o1.net_sales,
        count(o2.order_id) as orders_last_12m
    from candidate_orders o1
    left join all_orders o2
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
    end as segment
from orders_with_history