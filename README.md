# Bakery Management System

Internal web management system for a bakery business, built during an internship.
Handles IT inventory, daily production tracking, store distribution and sales.

## Tech Stack

- Python 3 + Flask
- MySQL (Railway - cloud hosted)
- Google Forms + Google Sheets API
- HTML + CSS
- Deployed on Render

## Features

- IT equipment and incident tracking
- Daily production form per store
- Reception, returns and waste tracking
- Automatic sales calculation (received - returned = sold)
- Google Form integration for production sheet photos
- User manual page for all staff

## Business Flow

Production → Store distribution → Reception → Returns → Sales = Reception - Returns

## Project Structure

bakery-management/
├── Gestion_empresa/
│   ├── app.py
│   ├── leer_forms.py
│   ├── requirements.txt
│   ├── Procfile
│   ├── static/
│   │   └── style.css
│   └── templates/
│       ├── index.html
│       ├── obrador.html
│       ├── produccion.html
│       ├── resumen.html
│       ├── fotos.html
│       └── ayuda.html
└── Database/
    └── SQL scripts

## Pages

| Route | Description |
|-------|-------------|
| `/` | Office IT equipment list |
| `/obrador` | Products and stores |
| `/produccion` | Daily production form |
| `/resumen` | Sales summary |
| `/fotos` | Production sheet photos |
| `/ayuda` | Staff user manual |

## Setup

1. Install dependencies

pip install -r requirements.txt

2. Set environment variables

GOOGLE_CREDENTIALS = your Google service account JSON

3. Run locally

python app.py

4. Open browser at http://127.0.0.1:5000

## Database

Hosted on Railway (MySQL). Contains:
- equipos — IT equipment
- incidencias — IT incidents
- tiendas — stores
- productos — bakery products
- categorias — product categories
- recepciones — store receptions
- devoluciones — store returns
- mermas — waste tracking

## Deployment

Deployed on Render. Auto-deploys on push to main branch.

## Author

Built as part of an internship — 2026
Marko
