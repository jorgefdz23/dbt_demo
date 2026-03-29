select 
    count(*) as total_orders
from {{ ref('stg_astrafy__raw_orders') }}
where extract(year from date_date) = 2023