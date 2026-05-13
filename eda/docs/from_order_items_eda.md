# Análisis EDA de `raw.order_items` - ¡Hablemos de los detalles de pedidos!

Hola, aquí vamos con la tabla de ítems de pedidos. Según el diccionario, incluye `order_id`, `order_item_id`, `product_id`, fechas de envío, precios y fletes. Vamos directo a las preguntas clave.

## ¿Qué problemas encuentras?
- Nada malo realmente: cero nulos en las columnas clave, y la estructura de muchos-a-muchos es natural (un pedido puede tener varios productos, un producto en varios pedidos). Los "duplicados" en `order_id` y `product_id` son esperados, no errores.

## ¿Qué columnas necesitan limpieza?
- `shipping_limit_date`: Viene como `text`, pero necesita convertirse a `timestamp` para manejar fechas correctamente.
- `price` y `freight_value`: Están como `float8`, pero para finanzas, mejor `numeric(10,2)` para evitar imprecisiones.

## ¿Qué tipos de datos deberían cambiar?
- `shipping_limit_date`: De `text` a `timestamp`.
- `price` y `freight_value`: De `float8` a `numeric(10,2)` para cálculos precisos de ingresos y márgenes.

## ¿Qué información podría generar errores analíticos?
- Si no usas la PK compuesta (`order_id + order_item_id`), podrías contar ítems mal. También, fechas como `text` podrían causar problemas en cálculos de tiempo o SLA de cumplimiento.

## Hallazgos principales
- Las columnas analizadas en `raw.order_items` no tienen valores nulos.
- Los resultados muestran una estructura de muchos a muchos natural del negocio.
- `order_id` se repite porque cada orden puede contener varios productos.
- `product_id` se repite porque un mismo producto puede venderse en muchas órdenes.
- `order_item_id` se repite por diseño: es un secuencial por orden y no un identificador global único.

## Interpretación técnica
1. Integridad de los datos
- Cero nulos en las columnas analizadas es una señal positiva para la capa raw.
- La ingesta desde el CSV fue completa y no se perdió información crítica como `price`, `freight_value` o `order_id`.

2. Duplicados como relación de negocio
- `order_id` con 13,984 duplicados indica que muchas órdenes tienen más de un ítem.
- `product_id` con 79,699 duplicados muestra que hay productos vendidos muchas veces.
- `order_item_id` con 112,629 duplicados no es un problema, sino un comportamiento esperado: el `order_item_id` se reinicia por cada orden, de modo que hay muchos ítems #1, #2, #3, etc., en distintos pedidos.

## Impacto en `stg_order_items.sql`
- No se requiere limpieza de nulos en `raw.order_items`; puedes aplicar casteos seguros sobre los valores existentes.
- La llave primaria de la tabla de staging no es una sola columna, sino la combinación lógica de `order_id + order_item_id`.
- No conviene validar duplicados por columnas individuales, porque la naturaleza del dataset requiere estas repeticiones para modelar correctamente la relación orden-producto.

## Ajustes de tipo recomendados
- `shipping_limit_date` debe convertirse a `timestamp` para que las fechas se manejen correctamente.
- `price` y `freight_value` deben convertirse a `numeric` en lugar de `float8` para evitar imprecisiones en cálculos financieros.

## Conclusión
Este resultado es muy positivo para tu pipeline: tienes un raw limpio de nulos y una estructura de datos consistente con el negocio. Mantener la definición técnica correcta en la capa RAW y aplicar los casteos adecuados en la capa de staging es clave para que dbt genere un modelo confiable.
