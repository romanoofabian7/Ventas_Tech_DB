Pipeline ETL — TechStore

Limpieza y preparación

Se importaron las hojas clientes, productos, ventas y categorias de Pipeline_ETL_Dataset.xlsx. Se eliminaron las filas completamente vacías y los registros duplicados por id_cliente e id_producto.

Las consultas se renombraron como Dim_Clientes, Dim_Productos, Dim_Categorias y Fact_Ventas. Se asignaron tipos de datos adecuados a identificadores, fechas, importes y campos de texto.

Tratamiento de valores faltantes

En Dim_Clientes, se conservó el email faltante como null porque no había información para reconstruirlo. La ciudad faltante se reemplazó por Sin dato, preservando el registro del cliente.

En Dim_Productos, el precio faltante del SSD Externo 1TB se completó con 130, valor unitario observado en sus cinco ventas. Es una imputación basada en las transacciones disponibles.

La categoría faltante de Laptop Gaming Pro se reemplazó por Sin Categoría, porque el dataset no confirma su clasificación.

Combinación y validación

Se combinó Fact_Ventas con Dim_Productos por id_producto mediante una combinación externa izquierda. Se conservaron las ventas y se agregaron nombre_producto y categoria.

Conteos finales: 11 clientes, 12 productos, 50 ventas y 4 categorías. La deduplicación y la combinación están documentadas con comentarios en lenguaje M.
