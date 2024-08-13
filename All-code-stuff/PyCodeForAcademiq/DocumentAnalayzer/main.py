import os
import easyocr
import fitz
from PIL import Image

# opening docs
doc1 = fitz.open('text1.pdf')
doc2 = fitz.open('text2.pdf')


# merging 2 pdf's
def merge_docs(pdf_paths_arr, new_file_name):
    if len(pdf_paths_arr) < 2:
        return pdf_paths_arr
    merged_doc = fitz.open()
    for doc in range(len(pdf_paths_arr)):
        merged_doc.insert_pdf(doc)
    merged_doc.save(new_file_name)
    return merged_doc


# extract text
def extract_text_from_doc(doc):
    text = ''
    for page_num in range(doc.page_count):
        page = doc.load_page(page_num)
        text += page.get_text() + '\n'
    return text


def find_coordinates(doc_path, text):
    doc = fitz.open(doc_path)
    text_instances = set()
    page_number = 0
    for page_num in range(doc.page_count):
        page = doc.load_page(page_num)

        text_instances.add(page.search_for(text))
        page_number = page_num
    return text_instances, page_number


# add highlight:
def add_highlight_annot(doc_path, page, coordinates):
    file_name = get_file_name(doc_path)
    try:
        doc = fitz.open(doc_path)
        _page = doc.load_page(page)
    except fitz.FileDataError:
        raise Exception(f"Couldn't load file: {file_name}.")
    rect = fitz.Rect(coordinates)
    try:
        highlight = _page.add_highlight_annot(rect)
        highlight.update()
    except Exception as e:
        raise Exception(f'Highlight of {file_name}: {e}')
    doc.save(doc_path)
    return "Highlighted document saved successfully."


def get_file_name(doc_path):
    doc = fitz.open(doc_path)
    full_path = doc.name
    file_name = os.path.basename(full_path)
    name = os.path.splitext(file_name)[0]
    return name


def check_for_images(path):
    if not path:
        raise fitz.FileNotFoundError
    doc = fitz.open(path)
    for page_num in range(doc.page_count):
        page = doc.load_page(page_num)
        images = page.get_images()
    if images:
        return True
    return False


def extract_images(path, page_number, save_path=''):
    if not path:
        raise fitz.FileNotFoundError("No file path provided.")

    doc = fitz.open(path)
    # get file name with no extension (for naming image)
    doc_name = get_file_name(doc)
    page = doc.load_page(page_number)
    images = page.get_images(full=True)

    if not images:
        raise (FileExistsError, f'No images in page: {page_number}')

    saves_images = []
    for image_index, image in enumerate(images):
        xref = image[image_index]
        base_image = doc.extract_image(xref)
        image_bytes = base_image["image"]
        image_ext = base_image["ext"]
        image_name = f"{doc_name}(page {page_number}).{image_ext}"

        if save_path:
            if not os.path.exists(save_path):
                os.makedirs(save_path)
            image_name = os.path.join(save_path, image_name)

        with open(image_name, "wb") as img_file:
            img_file.write(image_bytes)

        saves_images.append(image_name)

    return saves_images


def initialize_easyocr(lang):
    reader = easyocr.Reader([lang])
    return reader


def get_image_dimensions(path):
    with Image.open(path) as img:
        width, height = img.size
    return width, height


def extract_text_from_image(path, language):
    if not path:
        raise Exception('No file path provided.')
    reader = initialize_easyocr(language)
    results = reader.readtext(path)
    extracted_text = ''
    coordinates = []
    for result in results:
        coor, text, confidence = result
        extracted_text += text + ' '
        coordinates.append(coor)
    return extracted_text.strip(), coordinates

def create_pdf_from_image(image_path, output_path, coordinates):
    if not image_path:
        raise Exception('No file path provided.')

    width, height = get_image_dimensions(image_path)

    doc = fitz.open()
    page = doc.load_page(0)
    




    text, coordinates = extract_text_from_image('Extracted_Images/text_ex.png', 'en')

print(text)
print(coordinates)
