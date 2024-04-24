#!/usr/bin/env bash

# Setup constants
NL=$'\n'
FILE=~/.rofi-checklist
EMPTY=
EMPTY_RAW="- [ ]"
FILLED=
FILLED_RAW="- [x]"
CLEAR=" Clear all"
clear="${CLEAR}${NL}"
CLEAR_COMPLETED=" Clear completed"
RESET_COMPLETED=" Reset completed"
completed="${CLEAR_COMPLETED}${NL}${RESET_COMPLETED}${NL}"
selected_row=2

# Load configuration file
source ~/.config/rofi-checklist.conf &> /dev/null

# Read checklist file
touch $FILE
list_raw=`cat $FILE`
IFS=$'\n' # split by newlines instead of spaces
list_raw_array=($list_raw)

# Format checklist for display in rofi
list=$list_raw
list=${list//"$EMPTY_RAW"/"$EMPTY"} # empty checkboxes
list=${list//"$FILLED_RAW"/"$FILLED"} # filled checkboxes

# Don't show clear all option if task list is empty
[[ -z $list ]] && { clear=""; selected_row=$(($selected_row - 1)); }

# Don't show clear completed option if there are no completed tasks
count=${#list_raw_array[*]}
i=0
completed_tasks="n"
while [ $i -lt $count ]; do
	# %q escapes string, otherwise there are issues with square brackets
	if [[ ${list_raw_array[$i]} = `printf "%q" "$FILLED_RAW"`* ]]; then
		completed_tasks="y"
		break
	fi
	i=$(($i + 1))
done
[[ $completed_tasks = "n" ]] && { completed=""; selected_row=$(($selected_row - 2)); }

# Check for rofi/dmenu
exe_exists() {
	command -v "$1" >/dev/null
}
if [[ -n $1 ]]; then
	menu=$1
elif exe_exists rofi; then
	menu=rofi
elif exe_exists dmenu; then
	menu=dmenu
else
	echo "Please install either rofi or dmenu"; exit 1
fi
case $menu in
	rofi)
		exe_exists rofi || { echo "rofi isn't installed"; exit 1; }
		command="rofi -dmenu"; options="-selected-row $selected_row" ;;
	dmenu)
		exe_exists dmenu || { echo "dmenu isn't installed"; exit 1; }
		command=dmenu; options="-l 10" ;;
	*)
		echo "Please install either rofi or dmenu"; exit 1 ;;
esac

# Run rofi/dmenu, replace display checkmarks with raw syntax
selection=`printf "%s%s%s" "$clear" "$completed" "$list" | eval "$command -i $options -p \" Task:\""`
selection=${selection//"$EMPTY"/"$EMPTY_RAW"}
selection=${selection//"$FILLED"/"$FILLED_RAW"}

# Selection logic
case $selection in
	$CLEAR) list_raw="" ;;
	$CLEAR_COMPLETED)
		list_raw_array=($list_raw)
		count=${#list_raw_array[*]}
		i=0
		while [ $i -lt $count ]
		do
			if [[ ${list_raw_array[$i]} = `printf "%q" "$FILLED_RAW"`* ]]; then
				unset 'list_raw_array[$i]'
			fi
			i=$(($i + 1))
		done
		list_raw="${list_raw_array[*]}" ;;
	$RESET_COMPLETED)
		list_raw=${list_raw//"$FILLED_RAW"/"$EMPTY_RAW"} ;;
	`printf "%q" "$FILLED_RAW"`*)
		replace="${selection}${NL}"
		list_raw=${list_raw//"$replace"/""}
		list_raw=${list_raw//"$selection"/""} ;;
	`printf "%q" "$EMPTY_RAW"`*)
		selection_filled=${selection//"$EMPTY_RAW"/"$FILLED_RAW"}
		list_raw=${list_raw//"$selection"/"$selection_filled"} ;;
	*)
		if [[ -n $selection ]]; then
			[[ -n $list_raw ]] && list_raw="${list_raw}${NL}"
			list_raw=`printf "%s%s %s\n" "$list_raw" "$EMPTY_RAW" "$selection"`
		else
			exit	
		fi ;;
esac

printf "%s\n" "$list_raw" >| $FILE

rofi-checklist
