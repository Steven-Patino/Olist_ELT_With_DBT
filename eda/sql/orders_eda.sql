-- VALIDACIÓN DE NULOS Y DUPLICADOS POR COLUMNA
SELECT 
    'order_id' AS columna,
    COUNT(*) AS total_registros,
    COUNT(order_id) AS no_nulos,
    COUNT(*) - COUNT(order_id) AS nulos,
    COUNT(order_id) - COUNT(DISTINCT order_id) AS duplicados
FROM raw.orders

UNION ALL

SELECT 
    'customer_id',
    COUNT(*),
    COUNT(customer_id),
    COUNT(*) - COUNT(customer_id),
    COUNT(customer_id) - COUNT(DISTINCT customer_id)
FROM raw.orders

UNION ALL

SELECT 
    'order_status',
    COUNT(*),
    COUNT(order_status),
    COUNT(*) - COUNT(order_status),
    COUNT(order_status) - COUNT(DISTINCT order_status)
FROM raw.orders

UNION ALL

SELECT 
    'order_purchase_timestamp',
    COUNT(*),
    COUNT(order_purchase_timestamp),
    COUNT(*) - COUNT(order_purchase_timestamp),
    COUNT(order_purchase_timestamp) - COUNT(DISTINCT order_purchase_timestamp)
FROM raw.orders

UNION ALL

SELECT 
    'order_approved_at',
    COUNT(*),
    COUNT(order_approved_at),
    COUNT(*) - COUNT(order_approved_at),
    COUNT(order_approved_at) - COUNT(DISTINCT order_approved_at)
FROM raw.orders

UNION ALL

SELECT 
    'order_delivered_carrier_date',
    COUNT(*),
    COUNT(order_delivered_carrier_date),
    COUNT(*) - COUNT(order_delivered_carrier_date),
    COUNT(order_delivered_carrier_date) - COUNT(DISTINCT order_delivered_carrier_date)
FROM raw.orders

UNION ALL

SELECT 
    'order_delivered_customer_date',
    COUNT(*),
    COUNT(order_delivered_customer_date),
    COUNT(*) - COUNT(order_delivered_customer_date),
    COUNT(order_delivered_customer_date) - COUNT(DISTINCT order_delivered_customer_date)
FROM raw.orders

UNION ALL

SELECT 
    'order_estimated_delivery_date',
    COUNT(*),
    COUNT(order_estimated_delivery_date),
    COUNT(*) - COUNT(order_estimated_delivery_date),
    COUNT(order_estimated_delivery_date) - COUNT(DISTINCT order_estimated_delivery_date)
FROM raw.orders;


-- VALIDACIÓN DE FILAS COMPLETAMENTE DUPLICADAS
SELECT 
    order_id,
    customer_id,
    order_status,
    order_purchase_timestamp,
    order_approved_at,
    order_delivered_carrier_date,
    order_delivered_customer_date,
    order_estimated_delivery_date,
    COUNT(*) AS cantidad_repeticiones
FROM raw.orders
GROUP BY 
    order_id,
    customer_id,
    order_status,
    order_purchase_timestamp,
    order_approved_at,
    order_delivered_carrier_date,
    order_delivered_customer_date,
    order_estimated_delivery_date
HAVING COUNT(*) > 1
ORDER BY cantidad_repeticiones DESC;