from database import DatabaseConnector
import os
from dotenv import load_dotenv

load_dotenv()

CONNECTION_STRING = os.getenv('DB_CONNECTION_STRING')


def convert_to_binary(file_path):
    with open(file_path, 'rb') as file:
        binary_data = file.read()
    return binary_data


def upload_binary_file_to_database(binary_data, cursor, table_name, file_name):
    query = f"""
        Insert into {table_name}( FileName, FileData )
        Values(?, ?)
        Go
    """, (file_name, binary_data)
    try:
        cursor.execute(query)
    except Exception as e:
        raise Exception('Error executing query :\n', query, e)
    return "Added successfully to: (?)", table_name




