﻿# Análisis Exploratorio de Datos (EDA) de `raw.orders`

Este documento presenta los hallazgos técnicos del Análisis Exploratorio de Datos (EDA) realizado sobre la tabla `raw.orders`. El objetivo es identificar características clave, posibles problemas de calidad de datos y proponer recomendaciones para la capa de staging y el pipeline de datos. La tabla `orders` es fundamental, ya que rastrea el ciclo de vida de cada pedido desde su compra hasta la entrega, incluyendo identificadores, estados y marcas de tiempo.

## 1. Problemas Identificados
-   **Integridad de `order_id`**: No se encontraron problemas críticos; `order_id` es único y no existen filas duplicadas.
-   **Valores Nulos en Fechas**: Se observan valores nulos en columnas de fechas de flujo (`order_approved_at`, `order_delivered_carrier_date`, `order_delivered_customer_date`). Estos nulos son consistentes con la lógica de negocio, representando órdenes que no han completado ciertas etapas (ej., no aprobadas o no entregadas).

## 2. Columnas que Requieren Limpieza o Transformación
-   **Columnas de Fecha (`order_purchase_timestamp`, `order_approved_at`, etc.)**: Actualmente almacenadas como tipo `text`. Requieren conversión a tipo `timestamp` para permitir cálculos temporales precisos.
-   **`order_status`**: Aunque su tipo de dato es adecuado (`text`), es crucial considerar filtros por estados específicos (ej., 'delivered') para análisis que solo involucren órdenes completadas.

## 3. Cambios de Tipo de Datos Sugeridos
-   Todas las columnas que representan fechas y horas deben ser convertidas de `text` a `timestamp`. Esta transformación es esencial para habilitar el cálculo de métricas temporales como el tiempo de entrega (lead time) o la detección de retrasos.

## 4. Potenciales Fuentes de Errores Analíticos
-   La presencia de valores nulos en las columnas de fecha puede distorsionar los Indicadores Clave de Rendimiento (KPIs) si no se gestionan adecuadamente. Por ejemplo, incluir órdenes no entregadas en el cálculo del tiempo promedio de entrega podría llevar a conclusiones erróneas. Se recomienda utilizar la columna `order_status` para filtrar y considerar únicamente las órdenes con estado 'delivered' en análisis de rendimiento de entrega.

## Hallazgos principales
### 🚦 Resumen de Calidad
- **PK Integrity**: ✅ 100% Única (`order_id`)
- **Duplicates**: ✅ 0 filas duplicadas
- **Nulls**: ⚠️ Presentes en fechas de flujo (Esperado por lógica de negocio)
- **Tipos de Datos**: ⚠️ Fechas como `text` (Requiere casting)

### 5.1. Integridad y Calidad de Identificadores
-   **`order_id`**: Se verificaron 0 duplicados entre 99,441 registros, confirmando su fiabilidad como clave primaria atómica.
-   **`customer_id`**: No se encontraron duplicados, lo que asegura que cada orden está asociada de manera única a un `customer_id` en esta tabla.
-   **Duplicidad de Filas**: Se confirmó la ausencia de filas repetidas, lo que indica una carga de datos limpia en la capa RAW.

### 5.2. Flujo de Negocio y Valores Nulos
-   **`order_approved_at`**: Se identificaron 160 valores nulos, que corresponden a órdenes que no completaron el proceso de aprobación de pago.
-   **`order_delivered_carrier_date`**: Se encontraron 1,783 nulos, indicando pedidos que no fueron entregados a la transportista.
-   **`order_delivered_customer_date`**: Se observaron 2,965 nulos, reflejando pedidos cancelados, en tránsito o con incidencias en la entrega final al cliente.

### 5.3. Estructura Técnica de la Capa RAW
-   Las columnas de fecha y hora (`timestamp`) se cargaron inicialmente como tipo `text` en la base de datos.
-   La columna `order_status` no presenta valores nulos, lo que garantiza consistencia para la segmentación y el análisis del estado operativo de las órdenes.

## 6. Conclusiones y Recomendaciones para el Pipeline
-   **Casting Obligatorio**: En la capa de staging, es imperativo convertir las cinco columnas de fecha de `text` a `timestamp`. Esto es fundamental para permitir cálculos de intervalos de tiempo y la derivación de métricas temporales precisas.
-   **Manejo de Nulos**: Los valores nulos en las columnas de fecha no deben ser eliminados ni imputados con valores artificiales. Representan estados genuinos del negocio (órdenes no aprobadas, no entregadas o inconclusas) y deben ser tratados como tal en la lógica de negocio.
-   **Lógica de Negocio en Marts**: Para el cálculo de KPIs específicos, como el tiempo de entrega (Lead Time), se recomienda filtrar los registros para incluir únicamente aquellos con `order_status = 'delivered'`. Los nulos identificados en el EDA servirán como un criterio natural de exclusión para pedidos incompletos, evitando sesgos en las métricas.
-   **Conectividad**: La integridad y unicidad de `customer_id` garantizan que las operaciones de `JOIN` con la tabla `customers` en la capa Intermediate serán limpias y no resultarán en la duplicación o explosión de registros.

## 7. Resumen General
El Análisis Exploratorio de Datos de la tabla `raw.orders` revela una fuente de datos técnicamente robusta. Se confirman identificadores limpios, ausencia de duplicados de filas y una interpretación coherente de los valores nulos como reflejo de la lógica de negocio. Estos hallazgos proporcionan una base sólida para la construcción de un pipeline dbt eficiente y una capa de staging confiable.
