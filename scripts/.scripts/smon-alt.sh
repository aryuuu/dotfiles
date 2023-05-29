#!/bin/sh
xrandr --output eDP-1 --off --output HDMI-1 --off --output DP-1 --primary --mode 1920x1080 --pos 1920x0 --rotate normal && i3-msg restart && notify-send "i3" "single external display"

