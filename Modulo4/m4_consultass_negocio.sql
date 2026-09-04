USE Ventas_Tech_DB;
GO

/* =========================================================
   M4 - CONSULTAS SQL DE NEGOCIO
   Proyecto: RetailPro / Ventas_Tech_DB
   ========================================================= */

/* =========================================================
   CONSULTA 1 — RESUMEN EJECUTIVO MENSUAL
   Total facturado, cantidad de pedidos y ticket promedio,
   agrupados por mes.

   Nota: para SQL Server se utiliza MONTH() en lugar de
   EXTRACT(MONTH FROM ...).
   ========================================================= */

SELECT
    MONTH(fecha_venta) AS mes,
    SUM(cantidad * precio_unitario) AS total_facturado,
    COUNT(*) AS cantidad_pedidos,
    AVG(cantidad * precio_unitario) AS ticket_promedio
FROM ventas
GROUP BY MONTH(fecha_venta)
ORDER BY MONTH(fecha_venta);


/* =========================================================
   CONSULTA 2 — RANKING DE PRODUCTOS
   Top 5 de productos por total facturado.
   ========================================================= */

SELECT TOP 5
    id_producto,
    SUM(cantidad) AS unidades_vendidas,
    SUM(cantidad * precio_unitario) AS total_facturado
FROM ventas
GROUP BY id_producto
ORDER BY total_facturado DESC;


/* =========================================================
   CONSULTA 3 — CLIENTES RECURRENTES
   Clientes que realizaron más de un pedido.
   ========================================================= */

SELECT
    id_cliente,
    COUNT(*) AS cantidad_pedidos,
    SUM(cantidad * precio_unitario) AS total_gastado
FROM ventas
GROUP BY id_cliente
HAVING COUNT(*) > 1
ORDER BY total_gastado DESC;


/* =========================================================
   CONSULTA 4 — MESES POR ENCIMA / POR DEBAJO DEL PROMEDIO
   Compara la facturación mensual con el promedio mensual general.
   ========================================================= */

WITH facturacion_mensual AS (
    SELECT
        MONTH(fecha_venta) AS mes,
        SUM(cantidad * precio_unitario) AS total_facturado
    FROM ventas
    GROUP BY MONTH(fecha_venta)
),
promedio_mensual AS (
    SELECT AVG(total_facturado) AS promedio_general
    FROM facturacion_mensual
)
SELECT
    fm.mes,
    fm.total_facturado,
    CASE
        WHEN fm.total_facturado > pm.promedio_general THEN 'Por encima'
        ELSE 'Por debajo'
    END AS comparacion_promedio
FROM facturacion_mensual fm
CROSS JOIN promedio_mensual pm
ORDER BY fm.mes;


/* =========================================================
   BLOQUE DE CIERRE — HALLAZGOS
   Basados en los datos de Ventas_Tech_DB proporcionados
   para la práctica.
   =========================================================

   1. Todas las ventas registradas corresponden a marzo de 2024.

   2. El producto 1 es el producto con mayor facturación total,
      con $3.600 y 3 unidades vendidas.

   3. Los 5 clientes son recurrentes, ya que cada uno realizó
      2 pedidos durante el período analizado.
*/
