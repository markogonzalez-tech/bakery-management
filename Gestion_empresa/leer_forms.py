import gspread
from google.oauth2.service_account import Credentials

# Conectamos con Google Sheets
SCOPES = [
    "https://www.googleapis.com/auth/spreadsheets",
    "https://www.googleapis.com/auth/drive"
]

creds = Credentials.from_service_account_file("credentials.json", scopes=SCOPES)
client = gspread.authorize(creds)

# Abrimos el Sheets de respuestas
SHEET_ID = "12FqSkFwZoRxGRqz9--lTWQvwnp0j72us4d8zyyuuIXQ"
sheet = client.open_by_key(SHEET_ID).sheet1

# Cogemos todas las respuestas
respuestas = sheet.get_all_records()

for r in respuestas:
    print("---")
    print("Fecha:", r.get("Fecha de producción"))
    print("Tienda:", r.get("Tienda"))
    print("Foto:", r.get("Foto de la hoja"))
