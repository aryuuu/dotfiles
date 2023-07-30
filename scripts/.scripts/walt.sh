#!/usr/bin/env bash

# script for wallpaper and theme
# select one picture from ~/pictures/wallpaper/
# set as wallpaper and set theme using wal

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
    selection=$(ls ~/pictures/wallpaper/ | rofi -dmenu -i -p "")
else
    selection=$(ls ~/pictures/wallpaper/ | dmenu -c -fn "FontAwesome" -p "" -i -l 5 -sb '#6272A4' -sf '#F8F8F2' -nb '#282A36' -nf '#F8F8F2' -shb '#6272A4' -shf '#FA485D' -nhb '#282A36' -nhf '#FA485D')
fi

# selection=$(ls ~/pictures/wallpaper/ | dmenu -c -fn "FontAwesome" -p "" -i -l 5 -sb '#6272A4' -sf '#F8F8F2' -nb '#282A36' -nf '#F8F8F2' -shb '#6272A4' -shf '#FA485D' -nhb '#282A36' -nhf '#FA485D')

if [[ -z $selection ]];
then
    notify-send "dmenu walt" "Please select a wallpaper"
    exit 1
fi

echo ~/pictures/wallpaper/$selection > ~/.scripts/background/bgpath

i3-msg restart
# wal -s -e -t -i ~/pictures/wallpaper/$selection


