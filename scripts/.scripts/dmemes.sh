#!/bin/bash

# list files in a dir pipe into dmenu
# take selection from user
# copy to clipboard
# ???
# profit

## Colorschemes
set $DMENU_SB "#6272A4"
set $DMENU_SF "#F8F8F2"
set $DMENU_NB "#282A36"
set $DMENU_NF "#F8F8F2"
set $DMENU_SHB "#6272A4"
set $DMENU_SHF "#FA485D"
set $DMENU_NHB "#282A36"
set $DMENU_NHF "#FA485D"

if command -v rofi &> /dev/null
then
    selection=$(ls ~/pictures/reaction-memes/ | rofi -dmenu -i -p "")
else
    selection=$(ls ~/pictures/reaction-memes/ | dmenu -c -fn "FontAwesome" -p "" -i -l 5 -sb '#6272A4' -sf '#F8F8F2' -nb '#282A36' -nf '#F8F8F2' -shb '#6272A4' -shf '#FA485D' -nhb '#282A36' -nhf '#FA485D')
fi

# selection=$(ls ~/pictures/reaction-memes/ | dmenu -c -fn "FontAwesome" -p "" -i -l 5 -sb '#6272A4' -sf '#F8F8F2' -nb '#282A36' -nf '#F8F8F2' -shb '#6272A4' -shf '#FA485D' -nhb '#282A36' -nhf '#FA485D')

selection_full_path=~/pictures/reaction-memes/$selection

if [[ -z $selection ]];
then
    notify-send "dmemes" "Please select a picture"
    exit 1
fi

file_type_raw=$(echo $(identify $selection_full_path | awk '{print $2}'))

file_type=""
case "$file_type_raw" in
    "JPG") file_type="image/jpg"
    ;;
    "JPEG") file_type="image/jpeg"
    ;;
    "PNG") file_type="image/png"
    ;;
    *) file_type="image/jpg"
    ;;
esac

xclip -selection clipboard -t "$file_type" -i "$selection_full_path" && notify-send "dmemes" "$selection copied to clipboard" && exit 0

notify-send "dmemes" "failed to copy image"



