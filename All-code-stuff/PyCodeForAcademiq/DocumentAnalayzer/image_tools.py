import easyocr
from PIL import Image


class ImageProcessor:
    def __init__(self, path, lang='en'):
        self.path = path
        self.reader = easyocr.Reader([lang])

    def get_dimensions(self):
        with Image.open(self.path) as img:
            width, height = img.size
        return width, height

    def extract_text(self, language):
        if not self:
            raise Exception('No image provided.')
        results = self.reader.readtext(self.path)
        extracted_text = ''
        coordinates = list()
        for result in results:
            coor, text, confidence = result
            extracted_text += text + '\n'
            coordinates.append(coor)
        text_result = list(extracted_text.splitlines())
        return text_result, coordinates

