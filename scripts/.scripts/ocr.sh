#!/usr/bin/env bash

# take screenshot
filename=$(date +%s)
flameshot gui -p /tmp/$filename.png

# run tesseract on it
tesseract /tmp/$filename.png /tmp/$filename

# copy to clipboard
xclip -selection clipboard -i /tmp/$filename.txt

# notify
notify-send "OCR" "<b>$(cat /tmp/$filename.txt)</b>"

# clean up
rm /tmp/$filename.png /tmp/$filename.txt
