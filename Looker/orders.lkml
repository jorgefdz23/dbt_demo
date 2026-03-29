view: orders {
  sql_table_name: astrafy-challenge-491418.dbt_jfdz.locker_orders ;;

  dimension_group: order_date {
    type: time
    timeframes: [raw, date, week, month, quarter, year]
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
    primary_key: yes
    label: "Order ID"
  }

  dimension: segment {
    type: string
    sql: ${TABLE}.segment ;;
    label: "Segment"
  }

  measure: total_orders {
    type: count_distinct
    sql: ${order_id} ;;
    label: "Total Orders"
  }

  measure: net_sales {
    type: sum
    sql: ${TABLE}.net_sales ;;
    value_format_name: usd
    label: "Net Sales"
  }
}
