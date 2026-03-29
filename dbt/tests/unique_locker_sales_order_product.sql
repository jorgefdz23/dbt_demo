-- Fails when locker_sales has duplicate grain rows.
select
    order_id,
    product_id,
    count(*) as row_count
from {{ ref('locker_sales') }}
group by
    order_id,
    product_id
having count(*) > 1
