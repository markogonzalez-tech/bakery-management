-- ============================================
-- TABLA DE PROVEEDORES
-- De quién compramos cada producto

CREATE TABLE proveedores (
    id       INT AUTO_INCREMENT PRIMARY KEY,
    nombre   VARCHAR(100),
    telefono VARCHAR(20),
    email    VARCHAR(100),
    direccion VARCHAR(200)
);


-- ============================================
-- TABLA DE CATEGORIAS
-- Para organizar los productos por tipo

CREATE TABLE categorias (
    id     INT AUTO_INCREMENT PRIMARY KEY,
    nombre VARCHAR(100)
);


-- ============================================
-- TABLA DE PRODUCTOS
-- El inventario real del negocio

CREATE TABLE productos (
    id           INT AUTO_INCREMENT PRIMARY KEY,
    nombre       VARCHAR(150),
    precio       DECIMAL(10,2),
    stock        INT DEFAULT 0,
    id_categoria INT,
    id_proveedor INT,
    FOREIGN KEY (id_categoria) REFERENCES categorias(id),
    FOREIGN KEY (id_proveedor) REFERENCES proveedores(id)
);


-- ============================================
-- TABLA DE CLIENTES
-- Gente que compra o consume en el negocio

CREATE TABLE clientes (
    id       INT AUTO_INCREMENT PRIMARY KEY,
    nombre   VARCHAR(100),
    telefono VARCHAR(20),
    email    VARCHAR(100),
    tipo     VARCHAR(50)   -- "particular" o "empresa"
);


-- ============================================
-- DATOS DE EJEMPLO para probar que funciona

INSERT INTO categorias (nombre) VALUES
    (""),
    (""),
    ("");

INSERT INTO proveedores (nombre, telefono, email, direccion) VALUES
    ("marko", "666666666", "markogonzalezansa@gmail.com", "", "");

INSERT INTO proveedores (nombre, telefono, email, direccion) VALUES
    ("Distribuciones Garcia", "612345678", "garcia@dist.com",  "Calle Mayor 4, Madrid"),
    ("Proveedor Bebidas SL",  "698765432", "info@bebidas.com", "Av. Industrial 12, Madrid");
INSERT INTO clientes (nombre, telefono, email, tipo) VALUES
    ("Marko Gonzalez",      "666666666", "markogonzalezansa@gmail.com",    "particular"),
    ("Empresa algo SL", "x", "Empresa@empresa.com",  "empresa");


-- ============================================
-- CONSULTA PARA VERLO TODO JUNTO
-- Producto + su categoria + su proveedor

SELECT
    p.nombre        AS producto,
    p.precio,
    p.stock,
    c.nombre        AS categoria,
    pr.nombre       AS proveedor
FROM productos p
JOIN categorias c  ON p.id_categoria = c.id
JOIN proveedores pr ON p.id_proveedor = pr.id;


