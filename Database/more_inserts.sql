-- PASO 1: Meter los proveedores
INSERT INTO proveedores (nombre, telefono, email, direccion) VALUES
    ("Distribuciones Garcia", "612345678", "garcia@dist.com",  "Calle Mayor 4, Madrid"),
    ("Proveedor Bebidas SL",  "698765432", "info@bebidas.com", "Av. Industrial 12, Madrid");

use inventario_empresa;
-- PASO 2: Meter las categorias
INSERT INTO categorias (nombre) VALUES
    ("Bebidas"),
    ("Alimentacion"),
    ("Limpieza");

-- PASO 3: Ahora si, meter los productos
INSERT INTO productos (nombre, precio, stock, id_categoria, id_proveedor) VALUES
    ("Agua 1.5L",      0.50, 100, 1, 2),
    ("Coca-Cola 33cl", 1.20,  80, 1, 2),
    ("Pan de molde",   1.50,  30, 2, 1),
    ("Lejia 1L",       1.80,  20, 3, 1);

-- PASO 4: Comprobamos que todo esta bien
SELECT * FROM proveedores;
SELECT * FROM categorias;
SELECT * FROM productos;
