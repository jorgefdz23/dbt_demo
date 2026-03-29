# Generic connection
connection: "pending_connection"

# Include all view files from the views folde
include: "*.lkml"

explore: sales {
  label: "Sales"
  description: "Product-line sales joined with order-level segmentation."
  join: orders {
    type: left_outer
    sql_on: ${sales.order_id} = ${orders.order_id} ;;
    relationship: many_to_one
    fields: [orders.segment]
  }
}