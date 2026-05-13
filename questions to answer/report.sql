-- 1. Top clientes con mayores ventas
SELECT customer_unique_id, total_revenue, total_orders
FROM marts.mart_sales_by_customer
ORDER BY total_revenue DESC LIMIT 5;

-- 2. Productos más vendidos
SELECT product_id, product_category_name, units_sold
FROM marts.mart_sales_by_product
ORDER BY units_sold DESC LIMIT 5;

-- 3. Categorías con mayores ingresos
SELECT product_category_name, total_revenue
FROM marts.mart_sales_by_category
ORDER BY total_revenue DESC LIMIT 5;

-- 4. Análisis Temporal (Mes con más ventas y Promedio diario)
SELECT 
    DATE_TRUNC('month', purchase_date) as mes,
    SUM(total_item_value) as ventas_mensuales,
    ROUND(SUM(total_item_value) / 30, 2) as promedio_diario
FROM intermediate.int_order_items_details
WHERE order_status = 'delivered'
GROUP BY 1 ORDER BY ventas_mensuales DESC LIMIT 5;