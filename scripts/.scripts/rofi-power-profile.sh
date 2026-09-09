#!/usr/bin/env bash

current=$(powerprofilesctl get)

options="󰓅 performance\n󰾅 balanced\n󰾆 power-saver"

selected=$(echo -e "$options" | rofi -dmenu -i -p " " | awk '{print $2}')

[ -z "$selected" ] && exit 0

powerprofilesctl set "$selected"
