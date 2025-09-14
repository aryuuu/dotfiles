#!/usr/bin/env bash

# set -o xtrace

shopt -s nullglob globstar

typeit=0
if [[ $1 == "--type" ]]; then
	typeit=1
	shift
fi

_otp() {
	if [[ -n $WAYLAND_DISPLAY ]]; then
		dmenu="rofi -dmenu"
		# xdotool="ydotool type --file -"
		xdotool="xdotool type --clearmodifiers --file -"
	elif [[ -n $DISPLAY ]]; then
		dmenu="rofi -dmenu"
		xdotool="xdotool type --clearmodifiers --file -"
	else
		echo "Error: No Wayland or X11 display detected" >&2
		exit 1
	fi

	prefix=${PASSWORD_STORE_DIR-~/.password-store/otp}
	password_files=( "$prefix"/**/*.gpg )
	password_files=( "${password_files[@]#"$prefix"/}" )
	password_files=( "${password_files[@]%.gpg}" )

	password=$(printf 'otp/%s\n' "${password_files[@]}" | $dmenu "$@")

	[[ -n $password ]] || exit

	if [[ $typeit -eq 0 ]]; then
		echo $password
		pass otp -c "$password" 2>/dev/null
	else
		pass otp "$password" | { IFS= read -r pass; printf %s "$pass"; } | $xdotool
	fi
}

_password() {
	if [[ -n $WAYLAND_DISPLAY ]]; then
		dmenu="rofi -dmenu"
		# xdotool="ydotool type --file -"
		xdotool="xdotool type --clearmodifiers --file -"
	elif [[ -n $DISPLAY ]]; then
		dmenu="rofi -dmenu"
		xdotool="xdotool type --clearmodifiers --file -"
	else
		echo "Error: No Wayland or X11 display detected" >&2
		exit 1
	fi

	prefix=${PASSWORD_STORE_DIR-~/.password-store}
	password_files=( "$prefix"/**/*.gpg )
	password_files=( "${password_files[@]#"$prefix"/}" )
	password_files=( "${password_files[@]%.gpg}" )

	password=$(printf '%s\n' "${password_files[@]}" | $dmenu "$@")

	[[ -n $password ]] || exit

	if [[ $typeit -eq 0 ]]; then
		pass show -c "$password" 2>/dev/null
	else
		pass show "$password" | { IFS= read -r pass; printf %s "$pass"; } | $xdotool
	fi
}

# rofi -modi "pass:_pass(),otp:_otp(),combi" -show combi -combi-modi "pass,otp"

# Determine which mode was selected
mode="$1"

# Execute the appropriate function based on the selected mode
case "$mode" in
    custom1)
        _pass
        ;;
    custom2)
        _otp
        ;;
    *)
        # Launch Rofi in combi mode with the inline scripts
        rofi -modi "custom1:$0 custom1,custom2:$0 custom2" -show combi -combi-modi "custom1,custom2"
        ;;
esac

