#!/usr/bin/env bash

## Colorschemes
set $DMENU_SB "#6272A4"
set $DMENU_SF "#F8F8F2"
set $DMENU_NB "#282A36"
set $DMENU_NF "#F8F8F2"
set $DMENU_SHB "#6272A4"
set $DMENU_SHF "#FA485D"
set $DMENU_NHB "#282A36"
set $DMENU_NHF "#FA485D"

SNIPPETS_DIR=~/.snippets

if command -v rofi &> /dev/null
then
    selection=$(ls $SNIPPETS_DIR | rofi -dmenu -i -p "")
else
    selection=$(ls $SNIPPETS_DIR | dmenu -c -fn "FontAwesome" -p "" -i -l 5 -sb '#6272A4' -sf '#F8F8F2' -nb '#282A36' -nf '#F8F8F2' -shb '#6272A4' -shf '#FA485D' -nhb '#282A36' -nhf '#FA485D')
fi

# selection=$(ls ~/pictures/reaction-memes/ | dmenu -c -fn "FontAwesome" -p "" -i -l 5 -sb '#6272A4' -sf '#F8F8F2' -nb '#282A36' -nf '#F8F8F2' -shb '#6272A4' -shf '#FA485D' -nhb '#282A36' -nhf '#FA485D')

selection_full_path=$SNIPPETS_DIR/$selection

if [[ -z $selection ]];
then
    notify-send "dsnippet" "Please select a snippet"
    exit 1
fi


xclip -selection clipboard -i $selection_full_path  && notify-send "dsnippet" "$selection copied to clipboard" && exit 0

notify-send "dsnippet" "failed to copy snippet"
