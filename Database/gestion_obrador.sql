-- ============================================
-- BASE DE DATOS: GESTION OBRADOR
-- ============================================

CREATE DATABASE gestion_obrador;
USE gestion_obrador;


-- 1. TIENDAS
-- Las tiendas a las que se reparte cada dia

CREATE TABLE tiendas (
    id     INT AUTO_INCREMENT PRIMARY KEY,
    nombre VARCHAR(100),
    ciudad VARCHAR(100)
);


-- 2. CATEGORIAS DE PRODUCTO
-- Panaderia, Bolleria, Otros

CREATE TABLE categorias (
    id     INT AUTO_INCREMENT PRIMARY KEY,
    nombre VARCHAR(100)
);


-- 3. PRODUCTOS
-- Todos los panes y bollerias del obrador

CREATE TABLE productos (
    id          INT AUTO_INCREMENT PRIMARY KEY,
    nombre      VARCHAR(150),
    id_categoria INT,
    FOREIGN KEY (id_categoria) REFERENCES categorias(id)
);


-- 4. PRODUCCIONES
-- Lo que se fabrica cada dia en el obrador

CREATE TABLE producciones (
    id       INT AUTO_INCREMENT PRIMARY KEY,
    fecha    DATE,
    id_producto INT,
    cantidad INT,
    FOREIGN KEY (id_producto) REFERENCES productos(id)
);


-- 5. ENVIOS
-- Lo que se manda a cada tienda de lo producido

CREATE TABLE envios (
    id          INT AUTO_INCREMENT PRIMARY KEY,
    fecha       DATE,
    id_producto INT,
    id_tienda   INT,
    cantidad    INT,
    FOREIGN KEY (id_producto) REFERENCES productos(id),
    FOREIGN KEY (id_tienda)   REFERENCES tiendas(id)
);


-- 6. RECEPCIONES
-- Lo que confirma recibir cada tienda

CREATE TABLE recepciones (
    id          INT AUTO_INCREMENT PRIMARY KEY,
    fecha       DATE,
    id_producto INT,
    id_tienda   INT,
    cantidad    INT,
    FOREIGN KEY (id_producto) REFERENCES productos(id),
    FOREIGN KEY (id_tienda)   REFERENCES tiendas(id)
);


-- 7. DEVOLUCIONES
-- Lo que vuelve de la tienda al obrador

CREATE TABLE devoluciones (
    id          INT AUTO_INCREMENT PRIMARY KEY,
    fecha       DATE,
    id_producto INT,
    id_tienda   INT,
    cantidad    INT,
    FOREIGN KEY (id_producto) REFERENCES productos(id),
    FOREIGN KEY (id_tienda)   REFERENCES tiendas(id)
);


-- 8. MERMAS
-- Lo que se tira en la tienda

CREATE TABLE mermas (
    id          INT AUTO_INCREMENT PRIMARY KEY,
    fecha       DATE,
    id_producto INT,
    id_tienda   INT,
    cantidad    INT,
    FOREIGN KEY (id_producto) REFERENCES productos(id),
    FOREIGN KEY (id_tienda)   REFERENCES tiendas(id)
);


-- DATOS: TIENDAS

INSERT INTO tiendas (nombre, ciudad) VALUES
    ("LFM",   "Irun"),
    ("GTX",   "Irun"),
    ("Super", "Irun"),
    ("Noray", "Irun");


-- DATOS: CATEGORIAS

INSERT INTO categorias (nombre) VALUES
    ("Panaderia"),
    ("Bolleria"),
    ("Otros");



-- DATOS: PRODUCTOS (del Excel)

INSERT INTO productos (nombre, id_categoria) VALUES
    -- Panaderia (id_categoria = 1)
    ("Libra",              1),
    ("Baguetina",          1),
    ("Tranera",            1),
    ("Español",            1),
    ("Campaillet",         1),
    ("Semillas",           1),
    ("Maiz",               1),
    ("Barra Baja en Sal",  1),
    ("Hogaza",             1),
    ("Pan Tarde",          1),
    ("Sopako",             1),
    -- Bolleria (id_categoria = 2)
    ("Croissant",                2),
    ("Napolitana",               2),
    ("Pinca de Crema",           2),
    ("Mini Napolitana Crema",    2),
    ("Mini Croissant Unidad",    2),
    ("Croissant Relleno Choco",  2),
    ("Mini Napolitana Choco",    2),
    ("Donuts Normal",            2),
    ("Donuts Choco",             2),
    ("Suizo",                    2),
    ("Bollo Leche",              2),
    ("Bollo Choco",              2),
    ("Cristina",                 2),
    ("Caracola",                 2),
    ("Mini Caracola",            2),
    ("Trenzita Pasas",           2),
    ("Brioch",                   2),
    ("Bomba Pequeña Crema",      2),
    ("Bomba Pequeña Nata",       2),
    ("Bomba Grande Crema",       2),
    ("Bomba Grande Nata",        2),
    ("Croissant Crema",          2),
    ("Croissant Nata",           2),
    -- Otros (id_categoria = 3)
    ("Ocho",                     3),
    ("Abanico",                  3),
    ("Kruntxi",                  3),
    ("Pantxineta",               3),
    ("Pastel Vasco",             3),
    ("Tartaleta de Manzana",     3),
    ("Lacitos",                  3),
    ("Mini Palmerita Hojaldre",  3),
    ("Palmeras",                 3),
    ("Palmeras de Chocolate",    3),
    ("Palmeras Rellenas",        3),
    ("Mini Palmeritas Sabores",  3),
    ("Muffin",                   3),
    ("Pastas",                   3);


-- CONSULTA: ver ventas por tienda y producto
-- ventas = recepcion - devolucion

SELECT
    t.nombre                          AS tienda,
    p.nombre                          AS producto,
    r.cantidad                        AS recibido,
    d.cantidad                        AS devuelto,
    (r.cantidad - d.cantidad)         AS vendido,
    r.fecha
FROM recepciones r
JOIN tiendas  t ON r.id_tienda   = t.id
JOIN productos p ON r.id_producto = p.id
LEFT JOIN devoluciones d
    ON d.id_tienda = r.id_tienda
    AND d.id_producto = r.id_producto
    AND d.fecha = r.fecha;
    
    
SELECT * FROM productos;
SELECT * FROM tiendas;
