#!/usr/bin/env bash

xrandr --output eDP-1 --primary --mode 1920x1080 --pos 0x0 --rotate normal --output HDMI-1 --off --output DP-1 --off && i3-msg restart && notify-send "i3" "single monitor display"

xinput map-to-output "ELAN2513:00 04F3:2AF1" eDP-1
