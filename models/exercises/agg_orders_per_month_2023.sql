select
    extract(year from date_date) as year,
    extract(month from date_date) as month, 
    count(*) as total_orders
from {{ref('stg_astrafy__raw_orders')}}
where extract(year from date_date) = 2023
group by 
    1, 2
order by 
    2