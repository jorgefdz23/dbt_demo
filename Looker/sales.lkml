view: users {
  sql_table_name: astrafy-challenge-491418.dbt_jfdz.locker_sales ;;

   ############ Dimensions ############

  dimension: date_date {
    type: date
    sql: ${TABLE}.date_date ;;
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

  measure: net_sales {
    type: sum
    sql: ${TABLE}.net_sales ;;
    value_format_name: "usd"
    label: "Net Sale (USD)"
    }

  dimension: segment {
    type: string
    sql: ${TABLE}.segment ;;
    label: "Segment"
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
  
  measure: distint_count_customers {
    type: count_distinct
    sql: ${TABLE}.customers_id ;;
    label: "Total Customers"
    }

    measure: year_month  {
    type: date
    sql: DATE(EXTRACT(YEAR FROM ${TABLE}.date_date),
            EXTRACT(MONTH FROM ${TABLE}.date_date),
            1) ;;
    label: "Year Month"
    }

  measure: total_quantity {
    type: sum
    sql: ${TABLE}.qty ;;
    }

  measure: total_orders {
    type: count_distinct
    sql: ${TABLE}.order_id ;;
    }

  measure: avg_sales_per_order {
    type: number
    sql: ${total_quantity} / NULLIF(${total_orders}, 0) ;;
    value_format_name: decimal_2
    }
}