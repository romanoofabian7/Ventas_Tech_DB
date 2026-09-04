# Módulo 4 — Consultas SQL de negocio

## Proyecto
**RetailPro — Ventas_Tech_DB**

## Objetivo
Esta pre-entrega contiene las consultas SQL solicitadas para extraer métricas clave del negocio a partir de la tabla `ventas` de la base de datos `Ventas_Tech_DB`.

Las consultas trabajan únicamente con los campos de `ventas` y utilizan los IDs de cliente y producto, tal como indica la consigna. Los nombres descriptivos se incorporarán mediante `JOIN` en el Módulo 5.

## Archivo incluido

- `m4_consultas_negocio.sql`

El archivo contiene:

1. **Resumen ejecutivo mensual**
   - Total facturado.
   - Cantidad de pedidos.
   - Ticket promedio.

2. **Ranking de productos**
   - Top 5 de productos.
   - Unidades vendidas.
   - Total facturado.

3. **Clientes recurrentes**
   - Clientes con más de un pedido.
   - Cantidad de pedidos.
   - Total gastado.

4. **Meses por encima o por debajo del promedio**
   - Facturación mensual.
   - Comparación con el promedio mensual general mediante `CASE WHEN`.

5. **Bloque de cierre**
   - Tres hallazgos concretos obtenidos a partir de los datos.

## Compatibilidad

El proyecto se ejecuta sobre **Microsoft SQL Server / SQL Server Management Studio (SSMS)**.

La consigna menciona `EXTRACT(MONTH FROM fecha_venta)` y `LIMIT`, pero esas expresiones corresponden a otros dialectos SQL. Para mantener la consulta ejecutable en SQL Server se utiliza:

- `MONTH(fecha_venta)` para obtener el mes.
- `TOP 5` para limitar el ranking a cinco resultados.

## Requisitos

- Microsoft SQL Server.
- SQL Server Management Studio (SSMS).
- Base de datos `Ventas_Tech_DB` creada y con la tabla `ventas` cargada.

## Cómo ejecutar

1. Abrir SQL Server Management Studio.
2. Conectarse al servidor.
3. Abrir `m4_consultas_negocio.sql`.
4. Verificar que exista la base `Ventas_Tech_DB`.
5. Ejecutar el script completo.
6. Revisar los resultados de las cuatro consultas.

## Estructura del proyecto

```text
RetailPro/
└── Modulo4/
    ├── m4_consultas_negocio.sql
    └── README.md
```

## Hallazgos

Con los datos utilizados en la práctica:

- Todas las ventas registradas corresponden a marzo de 2024.
- El producto 1 presenta la mayor facturación total, con $3.600.
- Los 5 clientes son recurrentes, ya que cada uno realizó 2 pedidos.

## Autor

**Fabián Vargas**
