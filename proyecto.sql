-- ============================================================
-- PROYECTO FINAL - DATA ANALYST
-- CHECKPOINT: SCRIPT SQL DE INGENIERÍA DE DATOS
-- Modelo: Ventas de Tecnología
-- SQL SERVER
-- ============================================================

IF DB_ID('Ventas_Tech_DB') IS NULL
BEGIN
    CREATE DATABASE Ventas_Tech_DB;
END;
GO

USE Ventas_Tech_DB;
GO

-- ============================================================
-- 1. DROP TABLES
-- ============================================================

DROP TABLE IF EXISTS Ventas;
DROP TABLE IF EXISTS Productos;
DROP TABLE IF EXISTS Clientes;
DROP TABLE IF EXISTS Categorias;
GO

-- ============================================================
-- 2. CREATE TABLES
-- ============================================================

CREATE TABLE Categorias (
    CategoriaID INT IDENTITY(1,1) PRIMARY KEY,
    Nombre VARCHAR(100) NOT NULL
);
GO

CREATE TABLE Productos (
    ProductoID INT IDENTITY(1,1) PRIMARY KEY,
    Nombre VARCHAR(150) NOT NULL,
    Precio DECIMAL(10,2) NOT NULL,
    CategoriaID INT NOT NULL,

    CONSTRAINT FK_Productos_Categorias
        FOREIGN KEY (CategoriaID)
        REFERENCES Categorias(CategoriaID),

    CONSTRAINT CK_Productos_Precio
        CHECK (Precio > 0)
);
GO

CREATE TABLE Clientes (
    ClienteID INT IDENTITY(1,1) PRIMARY KEY,
    Nombre VARCHAR(150) NOT NULL,
    Email VARCHAR(150) NOT NULL UNIQUE,
    Ciudad VARCHAR(100) NOT NULL
);
GO

CREATE TABLE Ventas (
    ID_Venta INT IDENTITY(1,1) PRIMARY KEY,
    Fecha DATE NOT NULL,
    ClienteID INT NOT NULL,
    ProductoID INT NOT NULL,
    Cantidad INT NOT NULL,

    CONSTRAINT FK_Ventas_Clientes
        FOREIGN KEY (ClienteID)
        REFERENCES Clientes(ClienteID),

    CONSTRAINT FK_Ventas_Productos
        FOREIGN KEY (ProductoID)
        REFERENCES Productos(ProductoID),

    CONSTRAINT CK_Ventas_Cantidad
        CHECK (Cantidad > 0)
);
GO

-- ============================================================
-- 3. INSERT DATA
-- ============================================================

INSERT INTO Categorias (Nombre)
VALUES
    ('Computación'),
    ('Celulares'),
    ('Accesorios'),
    ('Gaming');
GO

INSERT INTO Productos (Nombre, Precio, CategoriaID)
VALUES
    ('Notebook Lenovo IdeaPad', 850000.00, 1),
    ('Notebook HP 15', 920000.00, 1),
    ('iPhone 15', 1250000.00, 2),
    ('Samsung Galaxy S24', 1100000.00, 2),
    ('Mouse Logitech G203', 55000.00, 3),
    ('Teclado Redragon Kumara', 85000.00, 3),
    ('Auriculares HyperX Cloud II', 145000.00, 4),
    ('Monitor Samsung 24 pulgadas', 280000.00, 4);
GO

INSERT INTO Clientes (Nombre, Email, Ciudad)
VALUES
    ('Juan Perez', 'juan.perez@email.com', 'Buenos Aires'),
    ('Maria Gonzalez', 'maria.gonzalez@email.com', 'La Plata'),
    ('Carlos Rodriguez', 'carlos.rodriguez@email.com', 'Quilmes'),
    ('Laura Fernandez', 'laura.fernandez@email.com', 'Avellaneda');
GO

INSERT INTO Ventas (Fecha, ClienteID, ProductoID, Cantidad)
VALUES
    ('2026-01-05', 1, 1, 1),
    ('2026-01-08', 2, 5, 2),
    ('2026-01-12', 3, 3, 1),
    ('2026-01-15', 1, 6, 1),
    ('2026-01-20', 4, 7, 2),
    ('2026-02-03', 2, 4, 1),
    ('2026-02-10', 3, 8, 1),
    ('2026-02-18', 1, 5, 3),
    ('2026-03-02', 4, 2, 1),
    ('2026-03-15', 2, 7, 1);
GO

-- ============================================================
-- 4. VERIFICACIÓN
-- ============================================================

SELECT * FROM Categorias;
SELECT * FROM Productos;
SELECT * FROM Clientes;
SELECT * FROM Ventas;
GO

-- ============================================================
-- 5. CONSULTA FINAL CON JOIN
-- ============================================================

SELECT
    V.ID_Venta,
    V.Fecha,
    C.Nombre AS Cliente,
    C.Ciudad,
    P.Nombre AS Producto,
    Cat.Nombre AS Categoria,
    P.Precio,
    V.Cantidad,
    (P.Precio * V.Cantidad) AS Total_Venta
FROM Ventas V
INNER JOIN Clientes C
    ON V.ClienteID = C.ClienteID
INNER JOIN Productos P
    ON V.ProductoID = P.ProductoID
INNER JOIN Categorias Cat
    ON P.CategoriaID = Cat.CategoriaID
ORDER BY V.Fecha;
GO
