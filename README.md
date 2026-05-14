# Bakery Management System

A web-based internal management system for a bakery business, 
built during an internship. Manages IT inventory, daily production, 
store distribution and sales tracking.

## Tech Stack

- Python + Flask
- MySQL
- HTML + CSS

## Features

- IT equipment and incident tracking
- Daily production form per store
- Reception, returns and waste tracking
- Automatic sales calculation (received - returned = sold)

## Project Structure

gestion_empresa/
├── app.py
├── templates/
│   ├── index.html
│   ├── obrador.html
│   ├── produccion.html
│   └── resumen.html
└── static/
    └── style.css

## Database

Two databases:
- inventario_empresa — IT equipment and incidents
- gestion_obrador — products, stores, production cycle

## Setup

1. Install dependencies
pip install flask mysql-connector-python

2. Configure your MySQL connection in app.py

3. Run the app
python app.py

4. Open your browser at http://127.0.0.1:5000

## Author

Built as part of an internship project — 2026
Marko.
