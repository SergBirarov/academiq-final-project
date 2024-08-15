import fitz
import os

image_extensions = ['jpg', 'jpeg', 'png', 'gif', '.bmp', '.tiff', '.tif', '.webp', '.svg']


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

    def merge_docs(self, other_pdf_path, save_directory=None):
        if not self.doc:
            raise Exception('To merge, upload 2 or more files.')
        if not other_pdf_path:
            raise Exception('To merge, upload 2 or more files(1).')

        other_doc = fitz.open(other_pdf_path)

        self.doc.insert_pdf(other_doc)
        file_name = f"{self.get_file_name()}_merged.pdf"

        if save_directory:
            new_file_name = os.path.join(save_directory, file_name)
        else:
            new_file_name = file_name
        try:
            self.doc.save(new_file_name)
        except Exception as e:
            raise Exception(f'Error saving the merged document: {e}')
        return f"Merged document saved successfully at {save_directory}." \
            if save_directory \
            else "Merged document saved in the current directory."

    def find_coordinates(self, text):
        if not self.doc or not text:
            raise Exception('Document not loaded or text not provided.')
        for page_num in range(self.doc.page_count):
            page = self.doc.load_page(page_num)
            instance = page.search_for(text)
            if instance:
                return instance[0], page_num
        raise Exception(f'Text "{text}" not found in the document.')

    def get_file_name(self):
        full_path = self.doc.name
        file_name = os.path.basename(full_path)
        name = os.path.splitext(file_name)[0]
        return name

    def annotate_pdf(self, text):
        if not self:
            raise Exception('No file to annotate.')
        file_name = self.get_file_name()
        try:
            rect, page_num = self.find_coordinates(text)
            _page = self.doc.load_page(page_num)
        except fitz.FileDataError:
            raise Exception(f"Couldn't load file: {file_name}.")

        try:
            highlight = _page.add_highlight_annot(rect)
            highlight.update()
        except Exception as e:
            raise Exception(f'Highlight of {file_name}: {e}')

        self.doc.saveIncr()
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

    def extract_images(self, page_number, save_path=None):
        if self.check_for_images():
            raise Exception('No images found on page.')

        doc_name = self.get_file_name()
        page = self.doc.load_page(page_number)
        images = page.get_images(full=True)

        saved_images = []
        for image_index, image in enumerate(images):
            xref = image[image_index]
            base_image = self.doc.extract_image(xref)
            image_bytes = base_image["image"]
            image_ext = base_image["ext"]
            image_name = f"{doc_name} - page {page_number} - image{image_index + 1}.{image_ext}"

            if save_path:
                if not os.path.exists(save_path):
                    os.makedirs(save_path)

            image_path = os.path.join(os.path.dirname(self.pdf_path), image_name)

            with open(image_path, "wb") as img_file:
                img_file.write(image_bytes)

            saved_images.append(image_path)

        return f"Images saved at {img_file}" if saved_images else "No images were saved."

    def convert_to_binary(self):
        with open(self.pdf_path, 'rb') as file:
            binary_data = file.read()
        return binary_data