-- VALIDACIÓN DE NULOS Y DUPLICADOS POR COLUMNA
SELECT 
    'product_id' AS columna,
    COUNT(*) AS total_registros,
    COUNT(product_id) AS no_nulos,
    COUNT(*) - COUNT(product_id) AS nulos,
    COUNT(product_id) - COUNT(DISTINCT product_id) AS duplicados
FROM raw.products

UNION ALL

SELECT 
    'product_category_name',
    COUNT(*),
    COUNT(product_category_name),
    COUNT(*) - COUNT(product_category_name),
    COUNT(product_category_name) - COUNT(DISTINCT product_category_name)
FROM raw.products

UNION ALL

SELECT 
    'product_name_lenght',
    COUNT(*),
    COUNT(product_name_lenght),
    COUNT(*) - COUNT(product_name_lenght),
    COUNT(product_name_lenght) - COUNT(DISTINCT product_name_lenght)
FROM raw.products

UNION ALL

SELECT 
    'product_description_lenght',
    COUNT(*),
    COUNT(product_description_lenght),
    COUNT(*) - COUNT(product_description_lenght),
    COUNT(product_description_lenght) - COUNT(DISTINCT product_description_lenght)
FROM raw.products

UNION ALL

SELECT 
    'product_photos_qty',
    COUNT(*),
    COUNT(product_photos_qty),
    COUNT(*) - COUNT(product_photos_qty),
    COUNT(product_photos_qty) - COUNT(DISTINCT product_photos_qty)
FROM raw.products

UNION ALL

SELECT 
    'product_weight_g',
    COUNT(*),
    COUNT(product_weight_g),
    COUNT(*) - COUNT(product_weight_g),
    COUNT(product_weight_g) - COUNT(DISTINCT product_weight_g)
FROM raw.products

UNION ALL

SELECT 
    'product_length_cm',
    COUNT(*),
    COUNT(product_length_cm),
    COUNT(*) - COUNT(product_length_cm),
    COUNT(product_length_cm) - COUNT(DISTINCT product_length_cm)
FROM raw.products

UNION ALL

SELECT 
    'product_height_cm',
    COUNT(*),
    COUNT(product_height_cm),
    COUNT(*) - COUNT(product_height_cm),
    COUNT(product_height_cm) - COUNT(DISTINCT product_height_cm)
FROM raw.products

UNION ALL

SELECT 
    'product_width_cm',
    COUNT(*),
    COUNT(product_width_cm),
    COUNT(*) - COUNT(product_width_cm),
    COUNT(product_width_cm) - COUNT(DISTINCT product_width_cm)
FROM raw.products;


-- VALIDACIÓN DE FILAS COMPLETAMENTE DUPLICADAS
SELECT 
    product_id,
    product_category_name,
    product_name_lenght,
    product_description_lenght,
    product_photos_qty,
    product_weight_g,
    product_length_cm,
    product_height_cm,
    product_width_cm,
    COUNT(*) AS cantidad_repeticiones
FROM raw.products
GROUP BY 
    product_id,
    product_category_name,
    product_name_lenght,
    product_description_lenght,
    product_photos_qty,
    product_weight_g,
    product_length_cm,
    product_height_cm,
    product_width_cm
HAVING COUNT(*) > 1
ORDER BY cantidad_repeticiones DESC;