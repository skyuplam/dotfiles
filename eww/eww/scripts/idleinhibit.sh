#!/bin/bash

# Swayidle toggle
function toggle {
	if pgrep "swayidle" > /dev/null
	then
		pkill swayidle
		notify-send -r 5556 -u normal "  Swayidle Inactive"
	else
		systemd-cat --identifier=swayidle swayidle -w \
			timeout 300 '~/.config/hypr/sway-lock.sh' \
			timeout 600 'hyprctl dispatch dpms off' \
			resume 'hyprctl dispatch dpms on' \
			before-sleep '~/.config/hypr/sway-lock.sh'
		notify-send -r 5556 -u normal "  Swayidle Active"
	fi
}

case $1 in
	toggle)
		toggle
		;;
	*)
		if pgrep "swayidle" > /dev/null
		then
			icon=""
		else
			icon=""
		fi
		printf "%s" "$icon "
		;;
esac

