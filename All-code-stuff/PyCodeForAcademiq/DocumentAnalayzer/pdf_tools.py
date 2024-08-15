import fitz
import os

image_extensions = ['.jpg', '.jpeg', '.png', '.gif', '.bmp', '.tiff', '.tif', '.webp', '.svg']


def get_rect(coordinates):
    rects = []
    for c in coordinates:
        x0 = min(point[0] for point in c)
        y0 = min(point[1] for point in c)
        x1 = max(point[0] for point in c)
        y1 = max(point[1] for point in c)
        rects.append(fitz.Rect(x0, y0, x1, y1))
    return rects


class PDFManager:
    def __init__(self, pdf_path=None):
        self.doc = fitz.open(pdf_path) if pdf_path else None
        self.pdf_path = pdf_path

    def extract_text(self):
        if not self.doc:
            raise Exception("No document loaded for text extraction.")
        text = ''
        for page_num in range(self.doc.page_count):
            page = self.doc.load_page(page_num)
            text += page.get_text() + '\n'
        return text

    def merge_docs(self, other_pdf_path, new_file_name):
        if not self.doc:
            raise Exception('To merge, upload 2 or more files.')
        if not other_pdf_path:
            raise Exception('To merge, upload 2 or more files(1).')
        doc = fitz.open(other_pdf_path)
        self.doc.insert_pdf(doc)
        return None

    def find_coordinates(self, text):
        if not self.doc or not text:
            raise Exception('Document not loaded or text not provided.')
        text_instances = set()
        page_number = 0
        for page_num in range(self.doc.page_count):
            page = self.doc.load_page(page_num)
            instances = page.search_for(text)
            if instances:
                text_instances.update(instances)
                page_number = page_num
        return text_instances, page_number

    def get_file_name(self):
        full_path = self.doc.name
        file_name = os.path.basename(full_path)
        name = os.path.splitext(file_name)[0]
        return name

    def annotate_pdf(self, page, coordinates):
        if not self:
            raise Exception('No file to annotate.')
        file_name = self.get_file_name()
        try:
            _page = self.doc.load_page(page)
        except fitz.FileDataError:
            raise Exception(f"Couldn't load file: {file_name}.")
        rect = get_rect(coordinates)
        try:
            highlight = _page.add_highlight_annot(rect)
            highlight.update()
        except Exception as e:
            raise Exception(f'Highlight of {file_name}: {e}')
        self.doc.save(self.pdf_path)
        return "Highlighted document saved successfully."

    def check_for_images(self):
        if not self:
            raise fitz.FileNotFoundError
        for page_num in range(self.doc.page_count):
            page = self.doc.load_page(page_num)
            images = page.get_images()
        if images:
            return True
        return False

    def extract_images(self, page_number, extension, save_path):
        if not save_path:
            save_path = self.pdf_path
        if self.check_for_images():
            raise Exception('No images found on page.')
        if extension.lower() not in image_extensions:
            raise Exception(f'{extension} is not a valid image file extension.')
        doc_name = self.get_file_name()
        page = self.doc.load_page(page_number)
        images = page.get_images(full=True)

        saved_images = []
        for image_index, image in enumerate(images):
            xref = image[image_index]
            base_image = self.doc.extract_image(xref)
            image_bytes = base_image["image"]
            image_ext = base_image[f'{extension.lower()}']
            image_name = f"{doc_name} - page {page_number}.{image_ext}"

            if save_path:
                if not os.path.exists(save_path):
                    os.makedirs(save_path)
                image_name = os.path.join(save_path, image_name)

            with open(image_name, "wb") as img_file:
                img_file.write(image_bytes)

            saved_images.append(image_name)

        return saved_images

