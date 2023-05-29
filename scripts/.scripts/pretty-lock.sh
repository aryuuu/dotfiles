#!/usr/bin/env bash
#
# script is stolen from https://michaelabrahamsen.com/posts/custom-lockscreen-i3lock/

lighticon="$HOME/images/lock-icon-light.png"
darkicon="$HOME/images/lock-icon-dark.png"
icon="/usr/share/i3lock-fancy-multimonitor/icons/lock.png"
tmpbg='/tmp/screen.png'

# take a screenshot
scrot "$tmpbg"

# set a threshold value to determine if we should use the light icon or dark
# icon
VALUE="60" #brightness value to compare to

# determine the color of the screenshot
# thanks to [i3lock-fancy](https://github.com/meskarune/i3lock-fancy) for the
# idea of getting the background color to change the icons
COLOR=$(convert "$tmpbg" -gravity center -crop 100x100+0+0 +repage -colorspace hsb \
    -resize 1x1 txt:- | awk -F '[%$]' 'NR==2{gsub(",",""); printf "%.0f\n", $(NF-1)}');

# change the color ring colors to leave the middle of the feedback ring
# transparent and the outside to use either dark or light colors based on the 
# screenshot
if [ "$COLOR" -gt "$VALUE" ]; then #light background, use dark icon
    # icon="$darkicon"
    PARAM=(--inside-color=00000000 --ring-color=0000003e \
        --line-color=00000000 --keyhl-color=ffffff80 --ringver-color=ffffff00 \
        --separator-color=22222260 --insidever-color=ffffff1c \
        --ringwrong-color=ffffff55 --insidewrong-color=ffffff1c)
else # dark background so use the light icon
    # icon="$lighticon"
    PARAM=(--inside-color=ffffff00 --ring-color=ffffff3e \
        --line-color=ffffff00 --keyhl-color=00000080 --ringver-color=00000000 \
        --separator-color=22222260 --insidever-color=0000001c \
        --ringwrong-color=00000055 --insidewrong-color=0000001c)
fi

# blur the screenshot by resizing and scaling back up
convert "$tmpbg" -filter Gaussian -thumbnail 20% -sample 500% "$tmpbg"

# overlay the icon onto the screenshot
convert "$tmpbg" "$icon" -gravity center -composite "$tmpbg"

# lock the screen with the color parameters
i3lock "${PARAM[@]}" -i "$tmpbg"

