# La siguiente consulta busca el total de registros, la cantidad de registros no nulos, la cantidad de registros nulos y la cantidad de registros duplicados 
# para cada una de las columnas customer_zip_code_prefix, customer_state, customer_city, customer_id y customer_unique_id en la tabla raw.customers. El resultado se muestra en una sola tabla con una fila por cada columna analizada.
SELECT 
    'customer_zip_code_prefix' AS columna,
    COUNT(*) AS total_registros,
    COUNT(customer_zip_code_prefix) AS no_nulos,
    COUNT(*) - COUNT(customer_zip_code_prefix) AS nulos,
    COUNT(customer_zip_code_prefix) - COUNT(DISTINCT customer_zip_code_prefix) AS duplicados
FROM raw.customers

UNION ALL

SELECT 
    'customer_state',
    COUNT(*),
    COUNT(customer_state),
    COUNT(*) - COUNT(customer_state),
    COUNT(customer_state) - COUNT(DISTINCT customer_state)
FROM raw.customers

UNION ALL

SELECT 
    'customer_city',
    COUNT(*),
    COUNT(customer_city),
    COUNT(*) - COUNT(customer_city),
    COUNT(customer_city) - COUNT(DISTINCT customer_city)
FROM raw.customers

UNION ALL

SELECT 
    'customer_id',
    COUNT(*),
    COUNT(customer_id),
    COUNT(*) - COUNT(customer_id),
    COUNT(customer_id) - COUNT(DISTINCT customer_id)
FROM raw.customers

UNION ALL

SELECT 
    'customer_unique_id',
    COUNT(*),
    COUNT(customer_unique_id),
    COUNT(*) - COUNT(customer_unique_id),
    COUNT(customer_unique_id) - COUNT(DISTINCT customer_unique_id)
FROM raw.customers;

# La sigiente consulta busca si hay registros duplicados en la tabla de clientes, considerando las columnas customer_zip_code_prefix, customer_state, customer_city, customer_id y customer_unique_id. Si hay registros que se repiten más de una vez, se mostrarán en el resultado junto con la cantidad de veces que se repiten.
SELECT 
    *,
    COUNT(*) AS cantidad_repeticiones
FROM raw.customers
GROUP BY 
    customer_zip_code_prefix,
    customer_state,
    customer_city,
    customer_id,
    customer_unique_id
HAVING COUNT(*) > 1;