import pandas as pd
from sqlalchemy import create_engine, text
import os
from dotenv import load_dotenv

# Carga las variables del archivo .env
load_dotenv()

# Recupera las credenciales
DB_USER = os.getenv("DB_USER")
DB_PASS = os.getenv("DB_PASS")
DB_HOST = os.getenv("DB_HOST")
DB_PORT = os.getenv("DB_PORT")
DB_NAME = os.getenv("DB_NAME")

# Construye la URL de conexión
connection_string = f"postgresql://{DB_USER}:{DB_PASS}@{DB_HOST}:{DB_PORT}/{DB_NAME}"
engine = create_engine(connection_string)


def load_csv_to_raw(file_path, table_name):
    try:
        print(f"🚀 Iniciando carga: {file_path} -> raw.{table_name}")

        # Crear la tabla vacía en raw con el esquema inferido del CSV
        df_empty = pd.read_csv(file_path, nrows=0)
        df_empty.to_sql(
            name=table_name,
            con=engine,
            schema="raw",
            if_exists="replace",
            index=False,
        )

        # Utiliza COPY para cargar el CSV en PostgreSQL
        raw_conn = engine.raw_connection()
        with raw_conn:
            with raw_conn.cursor() as cur, open(file_path, "r", encoding="utf-8") as csv_file:
                copy_sql = f"COPY raw.{table_name} FROM STDIN WITH CSV HEADER DELIMITER ','"
                cur.copy_expert(copy_sql, csv_file)

        print(f"✅ Éxito: {table_name} cargado.\n")
    except Exception as e:
        print(f"❌ Error cargando {table_name}: {e}")


if __name__ == "__main__":
    # Ajusta esta ruta a donde tengas tus CSVs
    # Si seguiste mi consejo, sería una carpeta 'data' en la raíz
    data_path = "data"

    files = {
        "olist_orders_dataset.csv": "orders",
        "olist_order_items_dataset.csv": "order_items",
        "olist_customers_dataset.csv": "customers",
        "olist_products_dataset.csv": "products",
    }

    for file_name, table_name in files.items():
        full_path = os.path.join(data_path, file_name)
        if os.path.exists(full_path):
            load_csv_to_raw(full_path, table_name)
        else:
            print(f"⚠️ Archivo omitido (no encontrado): {full_path}")