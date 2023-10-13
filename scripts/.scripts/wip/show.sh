#!/usr/bin/env bash

todofile="/home/fatt/.todo"
doingfile="/home/fatt/.doing"

if [[ ! -s "$todofile" ]]; then
    echo "[no task found]"
elif [[ ! -s "$doingfile" ]]; then
    echo  "[pick a task]"
else
    cat $doingfile
fi

