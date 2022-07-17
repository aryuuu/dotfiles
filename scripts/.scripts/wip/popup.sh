#!/bin/bash

todofile="/home/fatt/.todo"
doingfile="/home/fatt/.doing"

if [[ ! -s "$todofile" ]]; then
    notify-send "no task found"
elif [[ ! -s "$doingfile" ]]; then
    notify-send "pick a task"
else
    echo "test"
    notify-send "Working on" "$(cat $doingfile)"
fi

