select 
    count(*) as total_orders --counts the total number of orders
from {{ ref('stg_astrafy__raw_orders') }} --refers to the staging model
where extract(year from date) = 2023 --selects only orders from 2023