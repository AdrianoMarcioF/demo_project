{{ dynamic_total_sales(
    source_relation =
ref('stg_orders'),
    amount_column = 'order_amount',
    where_clause  = "order_date >= date
'2024-01-01' and order_date < date
'2025-01-01'"
) }}