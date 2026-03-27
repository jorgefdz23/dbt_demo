SELECT
    parse_date('%Y-%m-%d', date_date) AS date_date,
    cast(customers_id AS int64) AS customers_id,
    cast(orders_id AS int64) AS orders_id,
    cast(replace(net_sales, ',', '.') AS float64) AS net_sales
FROM `raw_data.raw_orders`