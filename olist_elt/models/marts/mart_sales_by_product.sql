{{ config(materialized='table') }}

with int_orders as (
    select * from {{ ref('int_order_items_details') }}
    where order_status = 'delivered'
)

select
    product_id,
    product_category_name,
    count(*) as units_sold,
    sum(total_item_value) as total_revenue
from int_orders
group by 1, 2
order by units_sold desc