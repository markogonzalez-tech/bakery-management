CREATE TABLE incidencias (
id INT AUTO_INCREMENT PRIMARY KEY,
dispositivo VARCHAR (100),
problema VARCHAR (255),
solucion VARCHAR (255),
fecha DATE,
estado VARCHAR(50)
);
INSERT INTO incidencias (
dispositivo,
problema,
solucion,
fecha,
estado
)
VALUES (
"IMPRESORA-CAJA",
"No imprimia correctamente al usar diferentes PCs",
"Reinicio de impresora y revision de cable USB",
"2025-05-09",
"Resuelto"
);

INSERT INTO incidencias (
dispositivo,
problema,
solucion,
fecha,
estado
)
VALUES (
"ROUTER-PRINCIPAL",
"Sin conexión a Internet",
"Reinicio del router",
"2025-05-09",
"Resuelto"
);

select*from equipos
Where estado = "Activo";
select*from incidencias
Where estado = "Resuelto";
