{{ config(
    materialized='incremental',
    incremental_strategy='merge', 
    unique_key=['order_id', 'product_id'], 
    partition_by={'field': 'date', 'data_type': 'date'}, 
    cluster_by=['customer_id', 'order_id'], 
    on_schema_change='sync_all_columns' 
) }}

--creates a temporary table to store the sales data
with source_sales as (
    select
        date,
        customer_id,
        order_id,
        product_id,
        net_sales,
        qty
    from {{ ref('stg_astrafy__raw_sales') }}

--if the data is incremental, then select the data from the last 7 days
    {% if is_incremental() %} 
    where date >= date_sub( 
        (select coalesce(max(date), date('1900-01-01')) from {{ this }}), 
        interval 7 day 
    )
    {% endif %}
)

select  --selects the sales data from the temporary table
    date,
    customer_id,
    order_id,
    product_id,
    net_sales,
    qty
from source_sales 