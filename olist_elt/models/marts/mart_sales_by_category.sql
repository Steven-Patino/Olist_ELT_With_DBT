{{ config(materialized='table') }}

with int_orders as (
    select * from {{ ref('int_order_items_details') }}
    where order_status = 'delivered'
)

select
    product_category_name,
    count(*) as units_sold,
    count(distinct order_id) as total_orders,
    sum(total_item_value) as total_revenue,
    round(avg(total_item_value), 2) as avg_item_value
from int_orders
group by 1
order by total_revenue desc