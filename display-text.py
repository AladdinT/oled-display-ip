import Adafruit_SSD1306
from PIL import Image,ImageDraw,ImageFont
from sys import argv
from os import path

#### Parse args ####
if len(argv) > 1:
    mytext = bytes(argv[1], "utf-8").decode("unicode_escape")
    print(argv)
else:
    mytext = "Hello world"
    
#### set font type ####
if path.exists("/usr/share/fonts/truetype/freefont/FreeSerifBold.ttf"):
    font = ImageFont.truetype("/usr/share/fonts/truetype/freefont/FreeSansBold.ttf", 14 )
else:
    font = ImageFont.load_default()    
#### Create image ####
img = Image.new('1', (128, 64), "black")
draw = ImageDraw.Draw(img)
draw.text((5,5), mytext , 'white', font)
# img.save("hi.png", "PNG")

#### Display Image ####
oled = Adafruit_SSD1306.SSD1306_128_64(rst=None)
oled.begin()
oled.clear()
oled.display()
oled.image(img)
oled.display()
