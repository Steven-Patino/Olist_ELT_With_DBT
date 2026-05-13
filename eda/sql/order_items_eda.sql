SELECT 
    'order_id' AS columna,
    COUNT(*) AS total_registros,
    COUNT(order_id) AS no_nulos,
    COUNT(*) - COUNT(order_id) AS nulos,
    COUNT(order_id) - COUNT(DISTINCT order_id) AS duplicados
FROM raw.order_items

UNION ALL

SELECT 
    'order_item_id',
    COUNT(*),
    COUNT(order_item_id),
    COUNT(*) - COUNT(order_item_id),
    COUNT(order_item_id) - COUNT(DISTINCT order_item_id)
FROM raw.order_items

UNION ALL

SELECT 
    'product_id',
    COUNT(*),
    COUNT(product_id),
    COUNT(*) - COUNT(product_id),
    COUNT(product_id) - COUNT(DISTINCT product_id)
FROM raw.order_items

UNION ALL

SELECT 
    'seller_id',
    COUNT(*),
    COUNT(seller_id),
    COUNT(*) - COUNT(seller_id),
    COUNT(seller_id) - COUNT(DISTINCT seller_id)
FROM raw.order_items

UNION ALL

SELECT 
    'shipping_limit_date',
    COUNT(*),
    COUNT(shipping_limit_date),
    COUNT(*) - COUNT(shipping_limit_date),
    COUNT(shipping_limit_date) - COUNT(DISTINCT shipping_limit_date)
FROM raw.order_items

UNION ALL

SELECT 
    'price',
    COUNT(*),
    COUNT(price),
    COUNT(*) - COUNT(price),
    COUNT(price) - COUNT(DISTINCT price)
FROM raw.order_items

UNION ALL

SELECT 
    'freight_value',
    COUNT(*),
    COUNT(freight_value),
    COUNT(*) - COUNT(freight_value),
    COUNT(freight_value) - COUNT(DISTINCT freight_value)
FROM raw.order_items;