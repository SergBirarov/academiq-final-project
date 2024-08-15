import pyodbc
import os
from dotenv import load_dotenv

load_dotenv()

# server = os.getenv('DB_SERVER')
# database = os.getenv('DB_DATABASE')
# username = os.getenv('DB_USERNAME')
# password = os.getenv('DB_PASSWORD')
#
# connection_string = (
#     f"DRIVER={{ODBC Driver 17 for SQL Server}};"
#     f"SERVER={server};"
#     f"DATABASE={database};"
#     f"UID={username};"
#     f"PWD={password}"
# )

class DatabaseConnector:
    def __init__(self, connection_string):
        self.connection_string = connection_string
        self.connection = None

    def connect(self):
        try:
            self.connection = pyodbc.connect(self.connection_string)
        except pyodbc.Error as e:
            raise Exception(e)
        return self.connection

    def execute_query(self, query):
        if not query:
            raise Exception('No valid query acquired.')
        cursor = self.connection.cursor()
        cursor.execute(query)
        return cursor.fetchall()

    def close_connection(self):
        if self.connection:
            self.connection.close()










