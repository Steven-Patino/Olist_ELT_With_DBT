-- models/intermediate/int_order_items_details.sql

with orders as (
    select * from {{ ref('stg_orders') }}
),

order_items as (
    select * from {{ ref('stg_order_items') }}
),

products as (
    select * from {{ ref('stg_products') }}
),

customers as (
    select * from {{ ref('stg_customers') }}
),

final as (
    select
        -- Identificadores (Llaves para granularidad)
        oi.order_id,
        oi.order_item_id,
        oi.product_id,
        oi.seller_id,
        
        -- Información del Cliente (Crucial para Parte 5: Ventas por cliente)
        o.customer_id,
        c.customer_unique_id, -- Necesario para identificar clientes recurrentes
        c.customer_city,
        c.customer_state,

        -- Dimensiones de Tiempo (Crucial para Parte 6: Mes con más ventas y Tendencias)
        o.purchased_at,
        extract(year from o.purchased_at) as purchase_year,
        extract(month from o.purchased_at) as purchase_month,
        cast(o.purchased_at as date) as purchase_date,
        
        -- Dimensiones de Producto (Crucial para Parte 5: Ventas por producto/categoría)
        p.product_category_name,
        
        -- Métricas Financieras Atómicas
        oi.price,
        oi.freight_value,
        oi.total_item_value,
        
        -- Estado de la Orden (Para filtrar solo ventas efectivas en Marts)
        o.order_status

    from order_items oi
    left join orders o on oi.order_id = o.order_id
    left join products p on oi.product_id = p.product_id
    left join customers c on o.customer_id = c.customer_id
)

select * from final