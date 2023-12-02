#!/usr/bin/env bash

MON2_CONNECTED=$(xrandr | grep ' connected' | grep 'DP-1' | awk '{print $1}')
[[ ! -z "$MON2_CONNECTED" ]] && xrandr --output eDP-1 --primary --mode 1920x1080 --pos 0x1080 --rotate normal --output HDMI-1 --off --output DP-1 --mode 1920x1080 --pos 0x0 --rotate normal

xinput map-to-output "ELAN2513:00 04F3:2AF1" eDP-1
xinput map-to-output "ELAN2513:00 04F3:2AF1 Stylus Pen (0)" eDP-1

