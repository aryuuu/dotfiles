#!/bin/bash

# terminate alreadt running bar instances
killall -q polybar

# wait until the processes have been shut down
while pgrep -u $UID -x polybar >/dev/null; do sleep 1; done

# launch polybar, using default config location ~/.config/polybar/config
if type "xrandr"; then

	for m in $(xrandr --query | grep " connected" | cut -d" " -f1); do
		# MONITOR=$m polybar --reload top &
		MONITOR=$m polybar --reload bottom &
		# MONITOR=$m polybar --reload tray &
	done

    BUILT_IN=$(xrandr --query | grep " connected" | grep "primary" | cut -d" " -f1)
    EXTERNAL=$(xrandr --query | grep " connected" | grep -v "primary" | cut -d" " -f1)

    if [[ ! -z "$EXTERNAL" ]]; then
        MONITOR=$EXTERNAL polybar --reload top &
        sleep 1
    fi

    MONITOR=$BUILT_IN polybar --reload top &

else 
	polybar top & 
	polybar bottom &
	# polybar tray & 
fi

echo "Polybar launched..."

