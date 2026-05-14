-- ============================================
-- BASE DE DATOS: INVENTARIO DE LA EMPRESA
-- ============================================


-- 1. CREAMOS LA BASE DE DATOS Y LA USAMOS

CREATE DATABASE inventario_empresa;
USE inventario_empresa;


-- 2. TABLA DE EQUIPOS
-- Aquí guardamos todos los dispositivos de la oficina

CREATE TABLE equipos (
    id               INT AUTO_INCREMENT PRIMARY KEY,
    nombre_equipo    VARCHAR(100),
    tipo             VARCHAR(50),
    marca            VARCHAR(50),
    modelo           VARCHAR(50),
    ip               VARCHAR(50),
    ubicacion        VARCHAR(100),
    usuario_asignado VARCHAR(100),
    estado           VARCHAR(50)
);


-- 3. TABLA DE INCIDENCIAS
-- Aquí apuntamos cada problema que pasa con un equipo
-- id_equipo conecta cada incidencia con su equipo de la tabla de arriba

CREATE TABLE incidencias (
    id          INT AUTO_INCREMENT PRIMARY KEY,
    id_equipo   INT,
    dispositivo VARCHAR(100),
    problema    VARCHAR(255),
    solucion    VARCHAR(255),
    fecha       DATE,
    estado      VARCHAR(50),
    FOREIGN KEY (id_equipo) REFERENCES equipos(id)
);


-- 4. METEMOS LOS EQUIPOS DE LA OFICINA
-- ============================================
INSERT INTO equipos (nombre_equipo, tipo, marca, modelo, ip, ubicacion, usuario_asignado, estado)
VALUES
    ("DESKTOP-3SRVGEP",  "Portatil",  "HP",      "EliteBook", "192.168.1.10", "Oficina", "Administracion", "Activo"),
    ("IMPRESORA-BROTHER","Impresora", "Brother", "",           "192.168.0.50", "Oficina", "Administracion", "Activo"),
    ("ADMIN-PC",         "PC",        "",        "",           "192.168.0.60", "Oficina", "Administracion", "Activo"),
    ("OFICINA-NEW",      "PC",        "",        "",           "192.168.0.2",  "Oficina", "Administracion", "Activo"),
    ("ROUTER-PRINCIPAL", "Router",    "",        "",           "192.168.0.1",  "Oficina", "Red",            "Activo");
INSERT INTO equipos (nombre_equipo, tipo, marca, modelo, ip, ubicacion, usuario_asignado, estado)
VALUES
    ("Galaxy Tab A7", "Tablet",    "Galaxy",        "Galaxy Tab A7",           "192.168.0.76",  "Oficina", "Red",            "Activo");

-- 5. METEMOS LAS INCIDENCIAS QUE HAN PASADO
-- id_equipo=2 es la impresora, id_equipo=5 es el router (segun el orden de arriba)

INSERT INTO incidencias (id_equipo, dispositivo, problema, solucion, fecha, estado)
VALUES
    (2, "IMPRESORA-BROTHER", "No imprimia correctamente al usar diferentes PCs", "Reinicio y revision cable USB", "2025-05-09", "Resuelto"),
    (5, "ROUTER-PRINCIPAL",  "Sin conexion a Internet",                          "Reinicio del router",           "2025-05-09", "Resuelto");


-- 6. CONSULTAS BASICAS PARA VER LOS DATOS
-- Ver todos los equipos que estan en uso

SELECT * FROM equipos WHERE estado = "Activo";

-- Ver las incidencias que ya se han solucionado
SELECT * FROM incidencias WHERE estado = "Resuelto";


-- 7. CONSULTA: VER EQUIPO + SU INCIDENCIA JUNTOS
-- Esto une las dos tablas y muestra todo de una vez

SELECT
    e.nombre_equipo,
    e.ubicacion,
    i.problema,
    i.solucion,
    i.fecha,
    i.estado
FROM equipos e
JOIN incidencias i ON e.id = i.id_equipo;






USE gestion_obrador;
SELECT * FROM recepciones;
SELECT * FROM devoluciones;
SELECT * FROM mermas;
