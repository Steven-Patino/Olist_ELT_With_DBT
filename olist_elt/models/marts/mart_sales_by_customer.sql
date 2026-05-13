{{ config(materialized='table') }}

with int_orders as (
    select * from {{ ref('int_order_items_details') }}
    -- Filtramos solo ventas efectivas
    where order_status = 'delivered'
)

select
    customer_unique_id,
    customer_city,
    customer_state,
    count(distinct order_id) as total_orders,
    sum(total_item_value) as total_revenue,
    round(avg(total_item_value), 2) as avg_ticket,
    min(purchase_date) as first_purchase_at,
    max(purchase_date) as last_purchase_at
from int_orders
group by 1, 2, 3
order by total_revenue desc