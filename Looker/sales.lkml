view: sales {
  sql_table_name: astrafy-challenge-491418.dbt_jfdz.locker_sales ;;

   ############ Dimensions ############

  dimension_group: order_date {
    type: date
    sql: ${TABLE}.date ;;
    label: "Order Date"
  }

  dimension: customer_id {
    type: number
    sql: ${TABLE}.customer_id ;;
    label: "Customer ID"
  }

  dimension: order_id {
    type: number
    sql: ${TABLE}.order_id ;;
    label: "Order ID"
  }

  dimension: product_id {
    type: number
    sql: ${TABLE}.product_id ;;
    label: "Product ID"
  }

   ############ Measures ############

  measure: sum_net_sales {
    type: sum 
    sql: ${TABLE}.net_sales ;;
    label: "Total Sales"
    }

  measure: count_orders {
    type: count
    sql: ${TABLE}.orders_id ;;
    label: "Orders Count"
    }

  measure: total_quantity {
    type: sum
    sql: ${TABLE}.qty ;;
    label: "Total Quantity"
  }

  measure: distinct_customers {
    type: count_distinct
    sql: ${TABLE}.customer_id ;;
    label: "Distinct Customers"
  }

  measure: total_orders {
    type: count_distinct
    sql: ${TABLE}.order_id ;;
    label: "Distinct Orders"
  }

  measure: avg_quantity_per_order {
    type: number
    sql: ${total_quantity} / NULLIF(${total_orders}, 0) ;;
    value_format: "0.00"
    label: "Avg Quantity per Order"
  }
}