# Ventas Tech DB

Proyecto de análisis de ventas de RetailPro con SQL Server, scripts T-SQL y Power BI. El repositorio reúne el esquema y datos de ejemplo, consultas de negocio, JOINs y documentación del flujo ETL.

## Contenido del repositorio

| Ruta | Descripción |
| --- | --- |
| `proyecto.sql` | Crea `Ventas_Tech_DB`, define las tablas `Categorias`, `Productos`, `Clientes` y `Ventas`, carga datos de ejemplo y ejecuta consultas de verificación y un JOIN. |
| `Modulo4/m4_consultas_negocio.sql` | Versión corregida de las consultas M4: resumen mensual, ranking de productos, clientes recurrentes y comparación con el promedio mensual. |
| `Modulo4/README.md` | Documentación específica de las consultas de M4. |
| `m5_consultas_joins.sql` | Versión corregida de M5: `INNER JOIN`, `LEFT JOIN` y `UNION ALL`. |
| `Pipeline_ETL/Pipeline_ETL_Romano_Fabian.pbix` | Archivo de Power BI del flujo ETL. |
| `Pipeline_ETL/README.md` | Notas del tratamiento de datos realizado en Power Query. |

## Herramientas

- Microsoft SQL Server y T-SQL.
- SQL Server Management Studio (SSMS) para ejecutar y revisar consultas.
- Power BI Desktop para abrir el archivo `.pbix`.

## Preparar y ejecutar la base de ejemplo

1. Abrí `proyecto.sql` en SSMS y conectate a una instancia de SQL Server.
2. Ejecutá el script completo. Crea la base `Ventas_Tech_DB` si no existe y luego elimina y vuelve a crear las tablas `Ventas`, `Productos`, `Clientes` y `Categorias` antes de cargar los datos de ejemplo.
3. Revisá las tablas y el JOIN de validación al final del script.

**Atención:** al volver a ejecutar `proyecto.sql`, las tablas mencionadas se eliminan y se recrean. No lo ejecutes sobre datos que quieras conservar.

## Ejecutar M4 y M5

Los scripts corregidos de M4 y M5 están preparados para el esquema con tablas `ventas`, `clientes`, `productos` y `categorias`, y columnas como `fecha_venta`, `id_cliente`, `id_producto` y `precio_unitario`.

El esquema que crea actualmente `proyecto.sql` usa nombres distintos, como `Ventas`, `Clientes`, `Productos`, `Fecha`, `ClienteID`, `ProductoID` y `Cantidad`; el precio está en `Productos.Precio`. Por eso, M4 y M5 no se ejecutan directamente sobre la base creada por `proyecto.sql`. Usalos con la versión del esquema para la que fueron corregidos o alineá las tablas y columnas antes de ejecutarlos.

M5 incluye inserciones de un cliente y un producto de prueba. Si volvés a ejecutar esas inserciones sobre la misma base, pueden fallar por claves duplicadas; revisalas antes de repetir la ejecución.

## Datos de Power BI

El repositorio incluye el archivo `.pbix` y sus notas de ETL. El archivo Excel de origen mencionado en esas notas no está incluido, por lo que puede ser necesario volver a vincular la fuente al abrir el proyecto en otra computadora.
