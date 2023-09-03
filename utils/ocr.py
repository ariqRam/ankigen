import pytesseract
from PIL import Image

def read(image_path: str):
    result = pytesseract.image_to_string(Image.open(image_path), config='-l jpn')
    print(result)
    return result