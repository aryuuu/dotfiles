#!/usr/bin/bash
# choose pulseaudio sink via rofi or dmenu
# changes default sink and moves all streams to that sink

# sink=$(ponymix -t sink list|awk '/^sink/ {s=$1" "$2;getline;gsub(/^ +/,"",$0);print s" "$0}'|rofi -dmenu -p 'pulseaudio sink:' -location 6 -width 100|grep -Po '[0-9]+(?=:)') &&
# alternate version using dmenu:
## Colorschemes
DMENU_SB="#6272A4"
DMENU_SF="#F8F8F2"
DMENU_NB="#282A36"
DMENU_NF="#F8F8F2"
DMENU_SHB="#6272A4"
DMENU_SHF="#FA485D"
DMENU_NHB="#282A36"
DMENU_NHF="#FA485D"

sink=$(ponymix -t sink list|awk '/^sink/ {s=$1" "$2;getline;gsub(/^ +/,"",$0);print s" "$0}'|dmenu -c -i -fn "FontAwesome" -p  -l 5 -sb $DMENU_SB -sf $DMENU_SF -nb $DMENU_NB -nf $DMENU_NF -shb $DMENU_SHB -shf $DMENU_SHF -nhb $DMENU_NHB -nhf $DMENU_NHF |grep -Po '[0-9]+(?=:)') &&

ponymix set-default -d $sink &&
for input in $(ponymix list -t sink-input|grep -Po '[0-9]+(?=:)');do
	echo "$input -> $sink"
	ponymix -t sink-input -d $input move $sink
done

