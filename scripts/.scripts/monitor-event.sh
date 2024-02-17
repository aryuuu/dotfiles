#!/usr/bin/env bash

# Get out of town if something errors
set -e

DP_STATUS=$(< /sys/class/drm/card1-DP-1/status)

if [ "connected" == "$DP_STATUS" ]; then
    /usr/bin/bash ~/.scripts/vmon.sh
    /usr/bin/notify-send --urgency=low -t 5000 "Graphics Update" "DP plugged in"
else 
    /usr/bin/bash ~/.scripts/smon.sh
	/usr/bin/notify-send --urgency=low -t 5000 "Graphics Update" "External monitor disconnected"	
	exit
fi
