# Generic connection
connection: "pending_connection"

# Include all view files from the views folder
include: "/views/*.view.lkml"


explore: sales_table {
  join: orders_table {
    type: left_outer
    # Join condition based on the order_id key
    sql_on: ${sales_table.order_id} = ${orders_table.order_id} ;;
     # One order (sales) can have multiple rows in orders (products)
    relationship: one_to_many
  }

}