#!/bin/bash

# terminate alreadt running bar instances
killall -q polybar

# wait until the processes have been shut down
while pgrep -u $UID -x polybar >/dev/null; do sleep 1; done

# launch polybar, using default config location ~/.config/polybar/config
if type "xrandr"; then
	for m in $(xrandr --query | grep " connected" | cut -d" " -f1); do
		MONITOR=$m polybar --reload fattbar &
	done
else 
	polybar fattbar &
fi

echo "Polybar launched..."

