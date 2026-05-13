# 📊 Reporte Final de Análisis de Negocio - Olist

Este documento presenta las respuestas a las interrogantes estratégicas clave formuladas para el proyecto de analítica de Olist. Los hallazgos se derivan directamente de los modelos de datos finales en la capa de **Marts**, garantizando la consistencia y fiabilidad de la información.

## 1. 📌 Clientes con Mayor Volumen de Ventas
Se ha identificado a los clientes que han generado el mayor gasto acumulado en la plataforma, destacando su contribución al ingreso total.

*   **Cliente Líder:** El identificador `0a0a92112bd4c708ca5fde585afaa872` corresponde al cliente con el mayor gasto individual, alcanzando un total de **R$ 13.664,08**.
*   **Cliente Recurrente Destacado:** El cliente `da122df9eeddfedc1f5349a1a690c` sobresale por su recurrencia, habiendo realizado **2 órdenes** que suman un total de **R$ 7.571,63**.

## 2. 📌 Productos Más Vendidos por Volumen
A continuación, se presenta el ranking de productos basado en el volumen de unidades vendidas, lo que indica la popularidad y demanda de cada artículo.

*   **Producto Principal:** El producto con ID `aca2eb7d00ea1a7b8ebd4e68314663af` es el más vendido, con un total de **520 unidades** desplazadas.
*   **Categoría Dominante por Volumen:** La categoría **Ferramentas Jardim** demuestra un rendimiento excepcional, con múltiples productos dentro del top 5 que, en conjunto, superan las **1.200 unidades** vendidas.

## 3. 📌 Categorías con Mayores Ingresos
Este apartado identifica las categorías de productos que contribuyen en mayor medida al flujo de caja de la plataforma, reflejando su impacto económico.

*   **Beleza Saúde:** Generó ingresos por **R$ 1.412.089,53**.
*   **Relógios Presentes:** Contribuyó con **R$ 1.264.333,12** en ingresos.
*   **Cama Mesa Banho:** Alcanzó **R$ 1.225.209,26** en ingresos.

## 4. 📌 Mes con el Mayor Volumen de Ventas
El análisis temporal, derivado de la capa `intermediate`, revela el período de mayor actividad comercial.

*   **Mes Récord:** **Noviembre de 2017** se posiciona como el mes de mayor facturación, registrando un total de **R$ 1.153.364,20**.

## 5. 📌 Promedio de Ventas Diarias
Este indicador muestra el rendimiento de ventas a nivel diario, especialmente durante los periodos de mayor demanda.

*   **Promedio en Periodo Pico:** Durante el mes de noviembre de 2017, el promedio diario de ventas fue de **R$ 38.445,47**.
*   **Estabilidad en 2018:** En el primer semestre de 2018, el promedio diario de ventas demostró una notable estabilidad, manteniéndose consistentemente por encima de los **R$ 35.000,00**.

## 6. 📌 Tendencias de Compra y Comportamiento del Mercado
Se han identificado las siguientes tendencias y observaciones sobre el comportamiento del mercado:

*   **Crecimiento Sostenido:** Se ha observado una tendencia de crecimiento constante en las ventas desde finales de 2017, la cual se estabilizó en la primera mitad de 2018, con ventas mensuales que superan consistentemente el millón de reales.
*   **Concentración del Gasto:** El análisis revela que el gasto significativo de los consumidores se concentra en categorías relacionadas con "Hogar y Bienestar", tales como "Beleza Saúde" (Salud y Belleza) y "Cama Mesa Banho" (Cama, Mesa y Baño).

---

### ✅ Validación Técnica
*   **Integridad de Datos:** Los datos fueron procesados a partir de un volumen inicial de **99,441 órdenes** en la capa RAW, las cuales fueron enriquecidas y transformadas a lo largo del pipeline.
*   **Calidad:** Se aplicaron **15 pruebas de datos (data tests)** para asegurar que no existieran nulos en ingresos ni duplicados en los IDs de clientes.
*   **Arquitectura:** La segregación en esquemas (`staging`, `intermediate`, `marts`) garantiza que estos resultados sean auditables y fáciles de actualizar.