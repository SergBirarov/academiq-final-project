import os
from dotenv import load_dotenv
from pdf_tools import PDFManager
from database import DatabaseConnector
from image_tools import ImageProcessor
from mongodb import MongoDBManager

load_dotenv()


def main():
    # db = DatabaseConnector(os.getenv('DB_CONNECTION_STRING'))
    # connection = db.connect()
    # cursor = connection.cursor()
    # query = """
    #     Create Table PDF_Files (
    #         Id INT PRIMARY KEY IDENTITY(1,1),
    #         FileName NVARCHAR(255),
    #         FileData VARBINARY(MAX),
    #         UploadDate DATETIME DEFAULT GETDATE()
    #     );
    # """
    # cursor = DatabaseConnector.execute_query(db, query)

    db = MongoDBManager(database_name='pdf_file_storage', collection='storage')
    doc = PDFManager('text1.pdf')
    binary_data = doc.convert_to_binary()
    document = {"name": "Pdf1", "data": f"{binary_data}"}
    res = db.insert_one(document)
    print(res)





if __name__ == main():
    main()
