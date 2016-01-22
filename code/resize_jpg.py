# Script for re-sizing/shrinking photos

import PIL
from PIL import Image
import os
os.chdir('/home/joebrew/Documents/joebrew.github.io/img/team')

basewidth = 150

for number in range(4)[1:]:
    img = Image.open(str(number) + '.jpg')
    wpercent = (basewidth / float(img.size[0]))
    hsize = int((float(img.size[1]) * float(wpercent)))
    img = img.resize((basewidth, hsize), PIL.Image.ANTIALIAS)
    img.save(str(number) + '_resized.jpg')



img = Image.open('3.jpg')
wpercent = (basewidth / float(img.size[0]))
hsize = int((float(img.size[1]) * float(wpercent)))
img = img.resize((basewidth, hsize), PIL.Image.ANTIALIAS)
img.save('3_resized.jpg')