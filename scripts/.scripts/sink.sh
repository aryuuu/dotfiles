#!/usr/bin/bash
# choose pulseaudio sink via rofi or dmenu
# changes default sink and moves all streams to that sink

# sink=$(ponymix -t sink list|awk '/^sink/ {s=$1" "$2;getline;gsub(/^ +/,"",$0);print s" "$0}'|rofi -dmenu -p 'pulseaudio sink:' -location 6 -width 100|grep -Po '[0-9]+(?=:)') &&
# alternate version using dmenu:
sink=$(ponymix -t sink list|awk '/^sink/ {s=$1" "$2;getline;gsub(/^ +/,"",$0);print s" "$0}'|dmenu -i -fn "FontAwesome" -p  -l 5 -sb '#6272A4' -sf '#F8F8F2' -nb '#282A36' -nf '#F8F8F2' |grep -Po '[0-9]+(?=:)') &&

ponymix set-default -d $sink &&
for input in $(ponymix list -t sink-input|grep -Po '[0-9]+(?=:)');do
	echo "$input -> $sink"
	ponymix -t sink-input -d $input move $sink
done

