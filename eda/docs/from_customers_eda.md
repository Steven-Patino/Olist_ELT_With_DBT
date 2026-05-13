# Análisis EDA de `raw.customers` - ¡Vamos a desglosarlo!

Oye, aquí vamos a charlar sobre lo que encontré en la tabla de clientes. Basándome en el diccionario de datos, esta tabla tiene info demográfica clave como `customer_id`, `customer_unique_id`, código postal, ciudad y estado. Vamos a responder las preguntas clave de una vez.

## ¿Qué problemas encuentras?
- Nada grave, la verdad. No hay nulos en las columnas principales, y `customer_id` es único por fila, lo cual está bien. Pero `customer_unique_id` se repite, lo que es normal porque un cliente puede hacer varios pedidos. No es un error, es parte del negocio.

## ¿Qué columnas necesitan limpieza?
- `customer_zip_code_prefix`: Viene como `int8`, pero debería ser `VARCHAR(10)` para no perder ceros al inicio (como en códigos postales).
- `customer_city`: Podría necesitar `initcap()` y `trim()` para estandarizar mayúsculas y quitar espacios extra.
- `customer_state`: Mantener en `upper()` para consistencia, ya que son siglas como SP o RJ.

## ¿Qué tipos de datos deberían cambiar?
- `customer_zip_code_prefix`: De `int8` a `VARCHAR(10)` para preservar el formato postal.
- Las demás están bien como `text`, pero en staging podríamos aplicar las limpiezas mencionadas.

## ¿Qué información podría generar errores analíticos?
- Si no manejas bien `customer_unique_id` vs `customer_id`, podrías inflar métricas de clientes únicos. Recuerda: `customer_id` es por orden, `customer_unique_id` por persona real. Mezclarlos podría llevar a errores en análisis de recurrencia o LTV (valor de vida del cliente).

## Hallazgos principales (detalles técnicos)
- La consulta muestra que no hay registros repetidos en `raw.customers` cuando se consideran las columnas analizadas.
- No hay valores nulos en `customer_zip_code_prefix`, `customer_state`, `customer_city`, `customer_id` ni `customer_unique_id`.
- `customer_id` es único en la tabla `raw.customers`.
- `customer_unique_id` sí presenta valores repetidos.
- Todas las demás columnas analizadas (código postal, estado y ciudad) también tienen valores repetidos, lo cual es normal en este contexto.

## Interpretación
- `customer_id` es la clave por orden de la tabla de clientes: cada pedido recibe un `customer_id` distinto.
- `customer_unique_id` es el identificador real del cliente, por lo que un mismo cliente puede aparecer varias veces si hizo múltiples pedidos.
- Los duplicados en `customer_unique_id` no son un error de calidad de datos, sino una característica del negocio que refleja clientes recurrentes.

## Conclusión y recomendación
- No es prudente borrar `customer_unique_id` solo porque tenga valores repetidos.
- Mantener `customer_unique_id` es vital para análisis de negocio como retención, frecuencia de compra, valor de vida del cliente (LTV) y comportamiento agregado por cliente.
- En la arquitectura ELT/DBT, conviene conservar ambas columnas en la capa de staging:
  - `customer_id` para unir con la tabla de órdenes.
  - `customer_unique_id` para análisis de cliente único y métricas de negocio.
- La diferencia clave es:
  1. `customer_id`: identificador por orden.
  2. `customer_unique_id`: identificador por cliente.

## Nota final
Esta es una de las dudas más comunes con el dataset de Olist. Tener clientes con múltiples pedidos y el mismo `customer_unique_id` es esperado, y es precisamente lo que permite pasar de análisis por orden a análisis por cliente.
