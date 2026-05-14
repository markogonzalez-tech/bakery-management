from flask import Flask, render_template, request, redirect
from datetime import date
import mysql.connector

app = Flask(__name__)

def conectar_inventario():
    return mysql.connector.connect(
        host="localhost",
        user="root",
        password="1234",
        database="inventario_empresa"
    )

def conectar_obrador():
    return mysql.connector.connect(
        host="localhost",
        user="root",
        password="1234",
        database="gestion_obrador"
    )

@app.route("/")
def inicio():
    conn = conectar_inventario()
    cursor = conn.cursor(dictionary=True)
    cursor.execute("SELECT * FROM equipos")
    equipos = cursor.fetchall()
    conn.close()
    return render_template("index.html", equipos=equipos)

@app.route("/obrador")
def obrador():
    conn = conectar_obrador()
    cursor = conn.cursor(dictionary=True)
    cursor.execute("SELECT p.nombre, c.nombre AS categoria FROM productos p JOIN categorias c ON p.id_categoria = c.id ORDER BY c.nombre, p.nombre")
    productos = cursor.fetchall()
    cursor.execute("SELECT * FROM tiendas")
    tiendas = cursor.fetchall()
    conn.close()
    return render_template("obrador.html", productos=productos, tiendas=tiendas)

@app.route("/produccion")
def produccion():
    conn = conectar_obrador()
    cursor = conn.cursor(dictionary=True)
    cursor.execute("SELECT * FROM tiendas")
    tiendas = cursor.fetchall()
    cursor.execute("""
        SELECT p.id, p.nombre, c.nombre AS categoria 
        FROM productos p 
        JOIN categorias c ON p.id_categoria = c.id 
        ORDER BY c.id, p.nombre
    """)
    productos = cursor.fetchall()
    conn.close()
    hoy = date.today().strftime("%Y-%m-%d")
    return render_template("produccion.html", tiendas=tiendas, productos=productos, now=hoy)

@app.route("/guardar_produccion", methods=["POST"])
def guardar_produccion():
    conn = conectar_obrador()
    cursor = conn.cursor(dictionary=True)

    id_tienda  = request.form["id_tienda"]
    fecha      = request.form["fecha"]

    cursor.execute("SELECT id FROM productos")
    productos = cursor.fetchall()

    for producto in productos:
        pid        = producto["id"]
        recepcion  = request.form.get(f"recepcion_{pid}", 0)
        devolucion = request.form.get(f"devolucion_{pid}", 0)
        merma      = request.form.get(f"merma_{pid}", 0)

        if int(recepcion) > 0:
            cursor.execute("""
                INSERT INTO recepciones (fecha, id_producto, id_tienda, cantidad)
                VALUES (%s, %s, %s, %s)
            """, (fecha, pid, id_tienda, recepcion))

        if int(devolucion) > 0:
            cursor.execute("""
                INSERT INTO devoluciones (fecha, id_producto, id_tienda, cantidad)
                VALUES (%s, %s, %s, %s)
            """, (fecha, pid, id_tienda, devolucion))

        if int(merma) > 0:
            cursor.execute("""
                INSERT INTO mermas (fecha, id_producto, id_tienda, cantidad)
                VALUES (%s, %s, %s, %s)
            """, (fecha, pid, id_tienda, merma))

    conn.commit()
    conn.close()
    return redirect("/produccion")
# Cuando le das a "Guardar producción" en la web:

# Coge la tienda y la fecha que elegiste arriba
# Recorre todos los productos uno por uno
# Por cada producto mira los números que pusiste:

# Si pusiste algo en Recepción → lo guarda en la tabla recepciones
# Si pusiste algo en Devolución → lo guarda en la tabla devoluciones
# Si pusiste algo en Merma → lo guarda en la tabla mermas


# Si un número es 0 no guarda nada — para no llenar la base de datos de ceros
# Cuando termina te manda de vuelta a la página de producción

@app.route("/resumen")
def resumen():
    conn = conectar_obrador()
    cursor = conn.cursor(dictionary=True)
    cursor.execute("""
        SELECT
            t.nombre                    AS tienda,
            p.nombre                    AS producto,
            c.nombre                    AS categoria,
            r.fecha,
            r.cantidad                  AS recibido,
            COALESCE(d.cantidad, 0)     AS devuelto,
            COALESCE(m.cantidad, 0)     AS merma,
            (r.cantidad - COALESCE(d.cantidad, 0)) AS vendido
        FROM recepciones r
        JOIN tiendas   t ON r.id_tienda   = t.id
        JOIN productos p ON r.id_producto = p.id
        JOIN categorias c ON p.id_categoria = c.id
        LEFT JOIN devoluciones d
            ON d.id_tienda   = r.id_tienda
            AND d.id_producto = r.id_producto
            AND d.fecha       = r.fecha
        LEFT JOIN mermas m
            ON m.id_tienda   = r.id_tienda
            AND m.id_producto = r.id_producto
            AND m.fecha       = r.fecha
        ORDER BY r.fecha DESC, t.nombre, c.id, p.nombre
    """)
    datos = cursor.fetchall()
    conn.close()
    return render_template("resumen.html", datos=datos)

# Va a la base de datos y une todas las tablas para mostrarte en una sola tabla:

# De recepciones → lo que llegó a cada tienda
# De devoluciones → lo que volvió al obrador
# De mermas → lo que se tiró
# Y calcula solo vendido = recibido - devuelto


if __name__ == "__main__":
    app.run(debug=True)
