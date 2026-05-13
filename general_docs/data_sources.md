# 🌐 Fuentes de Datos

## Fuente Oficial
Los datos utilizados en este proyecto provienen del dataset de e-commerce brasileño Olist, disponible públicamente en Kaggle.

**Enlace a la fuente:**
*   [https://www.kaggle.com/datasets/olistbr/brazilian-ecommerce](https://www.kaggle.com/datasets/olistbr/brazilian-ecommerce)

## Cobertura Usada en Este Proyecto
Para este trabajo, nos enfocaremos en cuatro datasets principales que son cruciales para el análisis de ventas y comportamiento del cliente.

| Dataset | Descripción |
| :--- | :--- |
| `olist_orders_dataset.csv` | Información de los pedidos realizados. |
| `olist_order_items_dataset.csv` | Detalles de los ítems en cada pedido. |
| `olist_customers_dataset.csv` | Datos de los clientes. |
| `olist_products_dataset.csv` | Catálogo de productos. |

## Ubicación Local
Los archivos CSV descargados deben ubicarse en la siguiente estructura de carpetas dentro del proyecto:

`./data/{nombre_archivo}.csv`

Por ejemplo: `./data/olist_orders_dataset.csv`

## Notas Importantes
*   Los archivos de datos raw no se versionan directamente en el repositorio debido a su tamaño.
*   Es recomendable registrar la fecha de descarga de los datos para futuras referencias, ya que la fuente puede actualizarse.
```
<!--
[PROMPT_SUGGESTION]¿Puedes ahora crear la documentación para la carpeta `docs` que no tenga contenido, como `faq.md` o `glossary.md`?[/PROMPT_SUGGESTION]
[PROMPT_SUGGESTION]Revisa los archivos de EDA restantes (`from_sellers_eda.md`, `from_geolocation_eda.md`, etc.) y aplica el mismo formato de semáforo que usaste en `from_orders_eda.md`.[/PROMPT_SUGGESTION]
