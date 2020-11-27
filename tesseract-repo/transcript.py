#!/usr/bin/env python
import os
import pytesseract
import re
import sys

from PIL import Image

if sys.argv[1]:
    language_arg = sys.argv[1]
else:
    raise ValueError('No language supplied')

def do_ocr(lang)
    if lang[:3] == 'spa':
        path = '/path/to/image/'
        name_files = ['image1.jpeg', 'image2.jpeg', 'image3.jpeg', 'image4.jpeg']            
    else:
        path = '/path/to/image'
        name_files = ['image1.jpeg', 'image2.jpeg', 'image3.jpeg', 'image4.jpeg']  

    image_files = []
    for filename in name_files:
        print(f'\n\n{filename}\n\n')
        image_files.append(path + filename)

    print(f'Running Tesseract OCR to {lang} language\n')
    for image_file in image_files:    
        image = Image.open(image_file)
        detected_text =  pytesseract.image_to_string(image, lang=lang, config='--psm 6 --dpi 300')
        split_and_strip(detected_text, lang[:3])

def split_and_strip(detected_text, lang):
    f = open(f"./transcripted_files/{lang[:3]}/text.txt", "w")
    for line in detected_text.split('\n'):
        line.strip()
        if len(line):
            f.write(line.upper())
            f.write('\n')
    f.close()


do_ocr(language_arg)