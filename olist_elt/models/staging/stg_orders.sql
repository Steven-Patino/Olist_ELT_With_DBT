-- models/staging/stg_orders.sql

with source as (
    select * from {{ source('raw_data', 'orders') }}
),

transformed as (
    select
        -- Identificadores
        order_id,
        customer_id,

        -- Estado de la orden
        order_status,

        -- Casteo de fechas (de text a timestamp)
        cast(order_purchase_timestamp as timestamp) as purchased_at,
        cast(order_approved_at as timestamp) as approved_at,
        cast(order_delivered_carrier_date as timestamp) as delivered_carrier_at,
        cast(order_delivered_customer_date as timestamp) as delivered_customer_at,
        cast(order_estimated_delivery_date as timestamp) as estimated_delivery_at

    from source
)

select * from transformed