import os
import pandas as pd
from sqlalchemy import create_engine

# Database configuration
DB_CONFIG = {
    'dbname': 'olist_data',
    'user': 'postgres',
    'password': 'Password',
    'host': 'localhost',
    'port': 5432
}

# Path to your CSV files
CSV_DIR = '/Users/sushmitha/Documents/projects/olist_dbt_project/Eom-data'  # replace with the path where your CSVs are located

# Create a connection string for PostgreSQL
engine = create_engine(f"postgresql+psycopg2://{DB_CONFIG['user']}:{DB_CONFIG['password']}@{DB_CONFIG['host']}:{DB_CONFIG['port']}/{DB_CONFIG['dbname']}")

# Function to load a CSV file into PostgreSQL
def load_csv_to_postgres(file_path, table_name):
    # Read CSV file
    df = pd.read_csv(file_path)

    # Write to PostgreSQL
    df.to_sql(table_name, engine, schema='olist_analytics', if_exists='replace', index=False)
    print(f"Loaded {file_path} into table {table_name}")

# Iterate over each CSV file in the directory and load it to PostgreSQL
for file_name in os.listdir(CSV_DIR):
    if file_name.endswith('.csv'):
        file_path = os.path.join(CSV_DIR, file_name)
        table_name = os.path.splitext(file_name)[0]  # Use the file name as table name without the .csv extension
        load_csv_to_postgres(file_path, table_name)
        print(table_name)
