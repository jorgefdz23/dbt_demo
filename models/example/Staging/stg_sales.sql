SELECT
    parse_date('%Y-%m-%d', date_date) AS date_date,
    cast(customers_id AS int64) AS customers_id,
    cast(orders_id AS int64) AS orders_id,
    cast(products_id AS int64) AS products_id,
    cast(replace(net_sales, ',', '.') AS float64) AS net_sales,
    cast(qty AS int64) AS qt
FROM `raw_data.sales_raw`