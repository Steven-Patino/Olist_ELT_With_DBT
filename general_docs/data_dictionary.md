# 📖 Diccionario de Datos - Proyecto ShopWave (ELT)

Este documento sirve como un diccionario de datos exhaustivo, detallando la estructura y el contenido de las tablas en la capa **RAW** del pipeline de datos del proyecto ShopWave. La información se deriva del dataset de e-commerce brasileño Olist y es fundamental para comprender el origen y la naturaleza de los datos antes de su transformación.

---

## 🛒 Tabla: `order_items`
Esta tabla registra el detalle de cada producto incluido en un pedido. Es importante destacar que un único pedido puede tener múltiples entradas en esta tabla si contiene varios artículos.

| Columna | Tipo RAW | Descripción | Impacto en el Negocio | Transformación Sugerida |
| :--- | :--- | :--- | :--- | :--- |
| `order_id` | `text` | Identificador único de la orden de compra. | Crucial para vincular con la tabla de órdenes y analizar ventas. | Clave Primaria (PK) |
| `order_item_id` | `int8` | Número secuencial que identifica cada artículo dentro de una misma orden. | Permite cuantificar el volumen de ítems por pedido. | Parte de la Clave Primaria Compuesta |
| `product_id` | `text` | Identificador único del producto vendido. | Esencial para el análisis de inventario y rendimiento de SKU. | Clave Foránea (FK) a la tabla de productos |
| `shipping_limit_date` | `text` | Fecha límite establecida para que el vendedor entregue el producto al socio logístico. | Métrica clave para el cumplimiento de los Acuerdos de Nivel de Servicio (SLA). | Convertir a `TIMESTAMP` |
| `price` | `float8` | Precio unitario del producto en la moneda local. | Componente fundamental para el cálculo de ingresos brutos. | Convertir a `NUMERIC(10,2)` para mayor precisión financiera |
| `freight_value` | `float8` | Costo de envío asignado a este artículo específico. | Importante para el análisis de costos logísticos y márgenes de beneficio. | Convertir a `NUMERIC(10,2)` para mayor precisión financiera |

---

## 👥 Tabla: `customers`
Esta tabla almacena la información demográfica y de identificación de los clientes. Es una fuente de datos fundamental para comprender el comportamiento de compra individual y recurrente.

| Columna | Tipo RAW | Descripción | Impacto en el Negocio | Transformación Sugerida |
| :--- | :--- | :--- | :--- | :--- |
| `customer_id` | `text` | Identificador único generado para cada orden específica. | Utilizado para establecer la relación con la tabla `orders`. | Mantener como llave de unión. |
| `customer_unique_id` | `text` | Identificador único y permanente de un cliente (persona física o jurídica). | Esencial para el análisis de la recurrencia de compra y el valor de vida del cliente (LTV). | Mantener; clave para métricas de recurrencia. |
| `customer_zip_code_prefix` | `int8` | Los primeros 5 dígitos del código postal del cliente. | Permite la segmentación geográfica a nivel de prefijo postal. | Convertir a `VARCHAR(10)` para preservar ceros iniciales. |
| `customer_city` | `text` | Nombre de la ciudad de residencia del cliente. | Útil para análisis geográficos y de mercado. | Aplicar `initcap()` y `trim()` en Staging para estandarización. |
| `customer_state` | `text` | Sigla de dos letras que identifica el estado federativo (ej., SP para São Paulo). | Fundamental para análisis geográficos a nivel estatal. | Mantener en `upper()` para estandarización. |

---

## 📦 Tabla: `orders`
Esta es la tabla central del sistema, que rastrea el ciclo de vida completo de cada pedido, desde el momento de la compra hasta la entrega final al cliente.

| Columna | Tipo RAW | Descripción | Impacto en el Negocio | Transformación Sugerida |
| :--- | :--- | :--- | :--- | :--- |
| `order_id` | `text` | Identificador único de la orden de compra. | Clave primaria para la tabla de hechos de órdenes. | Clave Primaria (PK) |
| `customer_id` | `text` | Identificador del cliente asociado a esta orden. | Clave foránea para unir con la tabla `customers`. | Clave Foránea (FK) |
| `order_status` | `text` | Estado actual de la orden (ej., 'delivered', 'shipped', 'canceled'). | Fundamental para filtrar y analizar el ciclo de vida de las órdenes. | Mantener como `text`. |
| `order_purchase_timestamp` | `text` | Fecha y hora exactas en que se realizó la compra. | Base para análisis temporal de ventas. | Convertir a `TIMESTAMP`. |
| `order_approved_at` | `text` | Fecha y hora de aprobación del pago de la orden. | Puede contener valores nulos si el pago no fue aprobado. | Convertir a `TIMESTAMP`. |
| `order_delivered_carrier_date` | `text` | Fecha y hora en que el pedido fue entregado a la empresa de logística. | Métrica de eficiencia logística. | Convertir a `TIMESTAMP`. |
| `order_delivered_customer_date` | `text` | Fecha y hora real de entrega del pedido al cliente. | Métrica clave de cumplimiento de entrega. | Convertir a `TIMESTAMP`. |
| `order_estimated_delivery_date`| `text` | Fecha de entrega estimada o prometida al cliente. | Permite calcular desviaciones y retrasos en la entrega. | Convertir a `TIMESTAMP`. |

---

## 📦 Tabla: `products`
Esta tabla representa el catálogo maestro de todos los productos disponibles y vendidos en la plataforma.

| Columna | Tipo RAW | Descripción | Impacto en el Negocio | Transformación Sugerida |
| :--- | :--- | :--- | :--- | :--- |
| `product_id` | `text` | Identificador único del producto. | Clave primaria para la tabla de dimensiones de productos. | Clave Primaria (PK) |
| `product_category_name` | `text` | Nombre de la categoría principal del producto en portugués. | Fundamental para el análisis de ventas por categoría. | Normalizar a Camel Case; convertir nulos a 'Sin Categoria'. |
| `product_name_lenght` | `float8` | Longitud del nombre del producto en caracteres. | Puede ser útil para análisis de contenido y SEO. | Convertir a `INTEGER`. |
| `product_description_lenght`| `float8` | Longitud de la descripción del producto en caracteres. | Indicador de detalle del producto. | Convertir a `INTEGER`. |
| `product_photos_qty` | `float8` | Cantidad de fotos publicadas para el producto. | Puede correlacionarse con la tasa de conversión. | Convertir a `INTEGER`. |
| `product_weight_g` | `float8` | Peso del producto en gramos. | Relevante para la logística y cálculo de fletes. | Convertir a `NUMERIC(10,2)`. |
| `product_length_cm` | `float8` | Longitud del producto en centímetros. | Dimensiones físicas para logística. | Convertir a `NUMERIC(10,2)`. |
| `product_height_cm` | `float8` | Altura del producto en centímetros. | Dimensiones físicas para logística. | Convertir a `NUMERIC(10,2)`. |
| `product_width_cm` | `float8` | Ancho del producto en centímetros. | Dimensiones físicas para logística. | Convertir a `NUMERIC(10,2)`. |

--- 