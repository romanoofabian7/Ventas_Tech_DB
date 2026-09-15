-- =====================================================================
-- m5_consultas_joins.sql
-- Proyecto RetailPro — Módulo 5
-- JOINs y UNION ALL sobre el esquema de Ventas_Tech_DB (M3)
-- Motor: SQL Server (T-SQL)
-- =====================================================================

-- =====================================================================
-- Datos adicionales para poder probar las Consultas 2 y 3
-- En el dataset original de M3, los 5 clientes ya habían comprado
-- y los 6 productos ya tenían ventas registradas, así que un LEFT JOIN
-- buscando "sin ventas" hubiera devuelto 0 filas. Se agrega un cliente
-- y un producto sin movimiento para que las consultas tengan sentido.
-- =====================================================================
INSERT INTO clientes (id_cliente, nombre, email, ciudad, fecha_registro)
VALUES (6, 'Sofía Medina', 'sofia@mail.com', 'Salta', '2024-04-01');

INSERT INTO productos (id_producto, nombre_producto, id_categoria, precio, stock, activo)
VALUES (7, 'Webcam HD', 2, 45.00, 25, 1);

-- =====================================================================
-- Consulta 1 — Vista base del proyecto (INNER JOIN)
-- Cruza ventas con clientes, productos y categorías para obtener, en
-- una sola fila, toda la información necesaria para Power BI: fecha,
-- cliente (con ciudad como dimensión geográfica), producto (con
-- categoría como dimensión de filtro), cantidad, precio unitario y
-- total de la venta.
-- =====================================================================
SELECT
    v.fecha_venta,
    v.id_cliente,
    c.nombre            AS nombre_cliente,
    c.ciudad,
    p.nombre_producto,
    cat.nombre_categoria,
    v.cantidad,
    v.precio_unitario,
    (v.cantidad * v.precio_unitario) AS total_venta
FROM ventas v
INNER JOIN clientes   c   ON v.id_cliente   = c.id_cliente
INNER JOIN productos  p   ON v.id_producto  = p.id_producto
INNER JOIN categorias cat ON p.id_categoria = cat.id_categoria
ORDER BY v.fecha_venta;

-- =====================================================================
-- Consulta 2 — Clientes sin ventas (LEFT JOIN)
-- =====================================================================
SELECT
    c.nombre,
    c.email,
    c.fecha_registro
FROM clientes c
LEFT JOIN ventas v ON c.id_cliente = v.id_cliente
WHERE v.id_venta IS NULL;

-- =====================================================================
-- Consulta 3 — Productos sin ventas (LEFT JOIN)
-- =====================================================================
SELECT
    p.nombre_producto,
    cat.nombre_categoria,
    p.precio
FROM productos p
INNER JOIN categorias cat ON p.id_categoria = cat.id_categoria
LEFT JOIN ventas v ON p.id_producto = v.id_producto
WHERE v.id_venta IS NULL;

-- =====================================================================
-- Consulta 4 — Consolidado por canal (UNION ALL)
-- No existe columna "canal" en el esquema, así que se genera un valor
-- literal por SELECT. Se usa la fecha de venta como criterio de corte
-- (antes / después del 10 de marzo) para simular dos orígenes de venta,
-- ya que todo el dataset de M3 cae en un único mes. Se cierra con un
-- GROUP BY externo para totalizar por origen. Se usa UNION ALL (no
-- UNION) para no perder ventas que coincidan en todos sus valores.
-- =====================================================================
SELECT
    periodo,
    SUM(total)  AS total_facturado,
    COUNT(*)    AS cantidad_pedidos
FROM (
    SELECT fecha_venta, (cantidad * precio_unitario) AS total, 'Primera quincena' AS periodo
    FROM ventas
    WHERE fecha_venta < '2024-03-10'

    UNION ALL

    SELECT fecha_venta, (cantidad * precio_unitario) AS total, 'Segunda quincena' AS periodo
    FROM ventas
    WHERE fecha_venta >= '2024-03-10'
) AS consolidado
GROUP BY periodo;

-- =====================================================================
-- Hallazgos
-- =====================================================================
-- 1. Sofía Medina (cliente 6) es la única persona registrada que
--    todavía no compró nada: candidata directa para una campaña de
--    reactivación desde CRM.
-- 2. La Webcam HD (producto 7) es el único artículo del catálogo sin
--    ninguna venta registrada: candidato a revisar en el área de
--    producto (¿falta de visibilidad, precio, o directamente baja
--    rotación esperada?).
-- 3. La "Segunda quincena" (10 al 15 de marzo) generó más pedidos que
--    la primera (6 vs. 4), pero un total facturado casi idéntico
--    ($3.214 vs. $3.230): la primera quincena tuvo menos operaciones
--    pero de mayor ticket promedio, empujadas por la venta de la
--    Laptop Pro 15 del día 5.
