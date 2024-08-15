import os
import fitz
import pyodbc
from dotenv import load_dotenv
from pdf_tools import PDFManager
from database import DatabaseConnector
from image_tools import ImageProcessor


def main():
    # working with pdf files
    doc_with_image = PDFManager('text1.pdf')
    doc_text = PDFManager('text2.pdf')
    extracted_text = doc_text.extract_text()
    print(f"Extracted text from PDF: \n", extracted_text)
    doc_with_image.merge_docs(doc_text, 'merged-docs')
    extracted_text_from_merged = doc_with_image.extract_text()
    print(f"Extracted text from merged PDF: \n", extracted_text_from_merged)



if __name__ == main():
    main()

# load_dotenv()
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
#
#
#
#
# # add highlight:
# def add_highlight_annot(doc_path, page, coordinates):
#     file_name = get_file_name(doc_path)
#     try:
#         doc = fitz.open(doc_path)
#         _page = doc.load_page(page)
#     except fitz.FileDataError:
#         raise Exception(f"Couldn't load file: {file_name}.")
#     rect = fitz.Rect(coordinates)
#     try:
#         highlight = _page.add_highlight_annot(rect)
#         highlight.update()
#     except Exception as e:
#         raise Exception(f'Highlight of {file_name}: {e}')
#     doc.save(doc_path)
#     return "Highlighted document saved successfully."
#
#
#
#
# def check_for_images(path):
#     if not path:
#         raise fitz.FileNotFoundError
#     doc = fitz.open(path)
#     for page_num in range(doc.page_count):
#         page = doc.load_page(page_num)
#         images = page.get_images()
#     if images:
#         return True
#     return False
#
#
# def extract_images(path, page_number, save_path=''):
#     if not path:
#         raise fitz.FileNotFoundError("No file path provided.")
#
#     doc = fitz.open(path)
#     # get file name with no extension (for naming image)
#     doc_name = get_file_name(doc)
#     page = doc.load_page(page_number)
#     images = page.get_images(full=True)
#
#     if not images:
#         raise (FileExistsError, f'No images in page: {page_number}')
#
#     saves_images = []
#     for image_index, image in enumerate(images):
#         xref = image[image_index]
#         base_image = doc.extract_image(xref)
#         image_bytes = base_image["image"]
#         image_ext = base_image["ext"]
#         image_name = f"{doc_name}(page {page_number}).{image_ext}"
#
#         if save_path:
#             if not os.path.exists(save_path):
#                 os.makedirs(save_path)
#             image_name = os.path.join(save_path, image_name)
#
#         with open(image_name, "wb") as img_file:
#             img_file.write(image_bytes)
#
#         saves_images.append(image_name)
#
#     return saves_images
#
#
# def initialize_easyocr(lang):
#     reader = easyocr.Reader([lang])
#     return reader
#
#
# def get_image_dimensions(path):
#     with Image.open(path) as img:
#         width, height = img.size
#     return width, height
#
#
# def extract_text_from_image(path, language):
#     if not path:
#         raise Exception('No file path provided.')
#     reader = initialize_easyocr(language)
#     results = reader.readtext(path)
#     extracted_text = ''
#     coordinates = list()
#     for result in results:
#         coor, text, confidence = result
#         extracted_text += text + '\n'
#         coordinates.append(coor)
#     text_result = list(extracted_text.splitlines())
#     return text_result, coordinates
#
#
# def get_rect(coordinates):
#     rects=[]
#     for c in coordinates:
#         x0 = min(point[0] for point in c)
#         y0 = min(point[1] for point in c)
#         x1 = max(point[0] for point in c)
#         y1 = max(point[1] for point in c)
#         rects.append(fitz.Rect(x0,y0,x1,y1))
#     return rects
#
#
# # extracting text from image and placing it in a new pdf in the size of the image (TODO)
#
# # def create_pdf_from_image(image_path, output_path):
# #     if not image_path:
# #         raise Exception('No file path provided.')
# #
# #     # get image size to size pdf
# #     width, height = get_image_dimensions(image_path)
# #
# #     doc = fitz.open()
# #     page = doc.new_page(0, width=595, height=842)
# #     image_name = get_file_name(image_path)
# #     text, coordinates = extract_text_from_image(image_path, 'en')
# #     rects = get_rect(coordinates)
# #     print(text)
# #     print(rects)
# #     for rect, t in zip(rects, text):
# #         page.insert_textbox(rect, t, fontsize=12, color=(0,0,0))
# #     doc.save(output_path)
# #     return f"{image_name} saved successfully."
# #
# #
# # print(create_pdf_from_image('Extracted_Images/linux.png', 'Extracted_Images/just.pdf'))
#
# # connection_string = (
# #     "DRIVER={ODBC Driver 17 for SQL Server};"
# #     "SERVER=User_Management.mssql.somee.com;"
# #     "DATABASE=User_Management;"
# #     "UID=SergBir_SQLLogin_1;"
# #     "PWD=Saadia26071996"
# # )
#
# def connect_to_mssql_database(connection_string):
#     try:
#         connection = pyodbc.connect(connection_string)
#         print("Connected successfully to MSSQL database.")
#     except pyodbc.Error as e:
#         print("Error: ", e)
#     return None
#
#
# con = pyodbc.connect(connection_string)
# cursor = con.cursor()
# sql = """
#     SELECT Id, username, Email
#     FROM Users
# """
# cursor.execute(sql)
# for row in cursor.fetchall():
#     print(f"{row.Id}, {row.username}, {row.Email}")
#
#
