#!/bin/bash

# This script requires dnsutils aka bind to fetch the WAN IP address

# Shows the connections names
# nmcli connection show --active | grep 'ethernet' | awk '{ print $1 }' FS='  '
# nmcli connection show --active | grep 'wifi' | awk '{ print $1 }' FS='  '

# Show ethernet interface name
# nmcli connection show --active | grep 'ethernet' | awk '{ print $6 }' FS=' '

# Show wifi interface name
# nmcli connection show --active | grep 'wifi' | awk '{ print $4 }' FS=' '

function ShowInfo {
	if [[ ! -z "$(networkctl status | grep -ohE '(online|partial)')" ]]; then
		wan="$(drill ch txt whoami.cloudflare @1.1.1.1 | grep -e "^whoami" | awk '{ print $5 }' | tr -d '"' )"
		connection="$(networkctl status | grep Address | awk '{ print $4 }'): $(networkctl status | grep Address | awk '{ print $2 }') / $wan"
	else
		connection="No active connection."
	fi
	notify-send -i "network-idle" "$connection" -r 123
}

function IconUpdate() {
	if [[ ! -z "$(networkctl status | grep -ohE '(online|partial)')" ]]; then
		icon="󰈀"
	else
		icon="󰲜"
	fi
	printf "%s" "$icon"
}

if [ "$1" = "ShowInfo" ]; then
	ShowInfo
else
	IconUpdate	
fi
