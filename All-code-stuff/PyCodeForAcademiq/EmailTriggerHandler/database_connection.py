import pyodbc
from dotenv import load_dotenv
import os


class DatabaseConnection:
    def __init__(self):
        # Configuration
        load_dotenv()
        self.server = os.getenv("SQL_SERVER")
        self.database = os.getenv("SQL_DATABASE")
        self.username = os.getenv("SQL_USERNAME")
        self.password = os.getenv("SQL_PASSWORD")

        # Database connection
        self.conn = None
        self.cursor = None

    def connect(self):
        try:
            self.conn = pyodbc.connect(
                f'DRIVER={{SQL Server}};SERVER={self.server};DATABASE={self.database};UID={self.username};PWD={self.password};TrustServerCertificate=True'
            )
            self.cursor = self.conn.cursor()
            print("Database connection established successfully!")
        except Exception as e:
            print(f"Error connecting to SQL Server: {e}")

    def close(self):
        try:
            if self.cursor:
                self.cursor.close()
            if self.conn:
                self.conn.close()
            print("Database connection closed successfully!")
        except Exception as e:
            print(f"Error closing database connection: {e}")
