#!/bin/sh
# Select a tmux(1) session to attach to and optionally pass further
# options by appending to the selection in dmenu(1)

exec tmux attach -t |
	$(tmux list-sessions -F \#S 2> /dev/null |
		dmenu -p Session: -l 10)
