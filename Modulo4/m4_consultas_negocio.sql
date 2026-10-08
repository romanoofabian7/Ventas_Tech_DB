-- =====================================================================
-- m4_consultas_negocio.sql
-- Proyecto RetailPro — Módulo 4
-- Consultas de agregación sobre Ventas_Tech_DB (tabla: ventas)
-- Columnas usadas: id_cliente, id_producto, cantidad, precio_unitario,
-- fecha_venta. Total de cada venta = cantidad * precio_unitario.
-- Motor: SQL Server (T-SQL)
-- =====================================================================

-- =====================================================================
-- Consulta 1 — Resumen ejecutivo mensual
-- Total facturado, cantidad de pedidos y ticket promedio, por mes.
-- =====================================================================
SELECT
    MONTH(fecha_venta)               AS mes,
    COUNT(*)                         AS cantidad_pedidos,
    SUM(cantidad * precio_unitario)  AS total_facturado,
    AVG(cantidad * precio_unitario)  AS ticket_promedio
FROM ventas
GROUP BY MONTH(fecha_venta)
ORDER BY mes;

-- =====================================================================
-- Consulta 2 — Ranking de productos (Top 5 por total facturado)
-- =====================================================================
SELECT TOP 5
    id_producto,
    SUM(cantidad)                    AS unidades_vendidas,
    SUM(cantidad * precio_unitario)  AS total_facturado
FROM ventas
GROUP BY id_producto
ORDER BY total_facturado DESC;

-- =====================================================================
-- Consulta 3 — Clientes recurrentes (más de un pedido)
-- =====================================================================
SELECT
    id_cliente,
    COUNT(*)                         AS cantidad_pedidos,
    SUM(cantidad * precio_unitario)  AS total_gastado
FROM ventas
GROUP BY id_cliente
HAVING COUNT(*) > 1
ORDER BY total_gastado DESC;

-- =====================================================================
-- Consulta 4 — Meses por encima / por debajo del promedio
-- Se calcula primero el total facturado por mes (CTE ventas_mensuales)
-- y se compara cada mes contra el promedio de esos totales mensuales.
-- =====================================================================
WITH ventas_mensuales AS (
    SELECT
        MONTH(fecha_venta)              AS mes,
        SUM(cantidad * precio_unitario) AS total_mes
    FROM ventas
    GROUP BY MONTH(fecha_venta)
)
SELECT
    mes,
    total_mes,
    CASE
        WHEN total_mes > (SELECT AVG(total_mes) FROM ventas_mensuales) THEN 'Por encima'
        WHEN total_mes < (SELECT AVG(total_mes) FROM ventas_mensuales) THEN 'Por debajo'
        ELSE 'En el promedio'
    END AS comparacion_promedio
FROM ventas_mensuales
ORDER BY mes;

-- =====================================================================
-- Hallazgos (revisando los resultados de M3 / Ventas_Tech_DB)
-- =====================================================================
-- 1. El producto 1 (Laptop Pro 15) concentra $3.600 de los $6.444
--    facturados en total: casi el 56% de la facturación, muy por
--    encima del resto del catálogo (el producto 3 lo sigue con $1.350).
--
-- 2. El 100% de los clientes cargados (los 5) es recurrente: cada uno
--    hizo exactamente 2 pedidos en el período. El cliente 1 es el que
--    más gastó en total ($2.640), seguido del cliente 5 ($2.100).
--
-- 3. Todas las ventas cargadas en M3 caen en marzo de 2024, así que la
--    Consulta 1 y la Consulta 4 hoy devuelven un solo mes (y por lo
--    tanto ningún mes queda "por encima" ni "por debajo" del promedio,
--    porque el promedio es ese mismo total). Esta comparación va a
--    volverse útil en cuanto se carguen ventas de más meses.
