-- models/staging/stg_order_items.sql

with source as (
    -- Referencia a la tabla raw definida en tu src_olist.yml
    select * from {{ source('raw_data', 'order_items') }}
),

transformed as (
    select
        -- Identificadores (Llave primaria compuesta: order_id + order_item_id)
        order_id,
        cast(order_item_id as integer) as order_item_id,
        product_id,
        seller_id,

        -- Conversión de fecha límite de envío (De TEXT a TIMESTAMP)
        cast(shipping_limit_date as timestamp) as shipping_limit_at,

        -- Precisión Financiera (De FLOAT8 a NUMERIC para evitar errores de redondeo)
        cast(price as numeric(10,2)) as price,
        cast(freight_value as numeric(10,2)) as freight_value,

        -- Cálculo derivado útil para la capa intermediate (Opcional pero recomendado)
        cast(price + freight_value as numeric(10,2)) as total_item_value

    from source
)

select * from transformed