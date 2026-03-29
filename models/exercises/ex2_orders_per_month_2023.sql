--this model is used to get the number of orders per month in 2023
select 
    extract(year from date) as year, 
    extract(month from date) as month, 
    count(*) as total_orders --counts the total number of orders
from {{ ref('stg_astrafy__raw_orders') }} --refers to the staging model
where extract(year from date) = 2023 --selects only orders from 2023
group by
    year,
    month
order by
    month