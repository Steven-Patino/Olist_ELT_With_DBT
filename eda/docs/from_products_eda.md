# Análisis EDA de `raw.products` - ¡Vamos con el catálogo de productos!

Hola, aquí charlamos sobre la tabla de productos. Del diccionario, es el catálogo maestro con `product_id`, categorías, descripciones y atributos físicos como peso y dimensiones. Vamos a las preguntas clave.

## ¿Qué problemas encuentras?
- Pequeños: `product_category_name`, `product_name_lenght`, `product_description_lenght` tienen 610 nulos (alrededor del 1.8%), y hay 2 registros con nulos en dimensiones físicas (`product_weight_g`, etc.). No hay duplicados de filas, y `product_id` es único.

## ¿Qué columnas necesitan limpieza?
- `product_category_name`: Nulos podrían convertirse a 'Sin Categoria' y normalizar a Camel Case.
- Columnas de longitud (`product_name_lenght`, etc.): Vienen como `float8`, pero deberían ser `integer`.
- Dimensiones físicas: De `float8` a `numeric(10,2)` para precisión.

## ¿Qué tipos de datos deberían cambiar?
- `product_name_lenght`, `product_description_lenght`, `product_photos_qty`: De `float8` a `integer`.
- `product_weight_g`, `product_length_cm`, `product_height_cm`, `product_width_cm`: De `float8` a `numeric(10,2)`.

## ¿Qué información podría generar errores analíticos?
- Los nulos en categorías podrían afectar agrupaciones por producto. Dimensiones incompletas podrían causar errores en cálculos de envío o logística. Asegúrate de manejar nulos explícitamente para no perder productos en análisis.

### Identidad primaria
- `product_id` tiene 0 duplicados y 0 nulos.
- Esto confirma que `product_id` es la Primary Key absoluta de la tabla `raw.products`.

### Calidad de categorización
- `product_category_name` presenta 610 valores nulos.
- `product_name_lenght` presenta 610 valores nulos.
- `product_description_lenght` presenta 610 valores nulos.
- Esto indica que aproximadamente el 1.8% del catálogo no tiene categoría o metadatos textuales completos en la fuente.

### Atributos físicos
- Existen 2 registros con valores nulos en las dimensiones de peso y tamaño (`product_weight_g`, `product_length_cm`, `product_height_cm`, `product_width_cm`).
- Esto sugiere que el dataset tiene muy pocos productos sin atributos físicos completos, pero sí es algo a tener en cuenta para cálculos de envío y logística.

### Integridad de filas
- No existen filas completamente duplicadas en el dataset.
- La validación de filas completas consolidó que no hay registros repetidos en `raw.products`.

### Formatos técnicos
- Según los resultados de EDA, los nombres y categorías son `text`.
- Las métricas físicas y los conteos de caracteres (`product_name_lenght`, `product_description_lenght`, `product_weight_g`, `product_length_cm`, `product_height_cm`, `product_width_cm`) ingresaron como `float8`.
- Esta clasificación técnica indica que el raw carga texto para los campos descriptivos y numéricos en formato de coma flotante para las dimensiones y longitudes.

## Conclusión
La tabla `raw.products` es sólida en su clave primaria y no tiene filas duplicadas. Sin embargo, hay una pequeña proporción de productos con metadatos incompletos en categorías y descripciones, y un par de registros con dimensiones físicas incompletas. El pipeline debe conservar esta información y manejar los nulos de forma explícita, especialmente en la etapa de staging donde se pueden normalizar los tipos y validar los atributos faltantes.
