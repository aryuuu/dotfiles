#!/usr/bin/env bash

timestamp=$(date +%F-%H-%M-%S)
raw_filename=/home/fatt/Videos/recordings/recording-$timestamp-raw.mp4
clean_filename=/home/fatt/Videos/recordings/recording-$timestamp.mp4

pgrep wf-recorder | pkill wf-recorder && exit 0 || wf-recorder -g "$(slurp -o)" -F format=rgb24 -x rgb24 -p qp=0 -p crf=0 -p preset=veryslow -p tune=animation -c libx264rgb -f $raw_filename

ffmpeg -i $raw_filename -c:v libx264 -c:a copy -qp 0 -vf format=yuv444p $clean_filename

rm $raw_filename

notify-send "Recording saved to $clean_filename"
