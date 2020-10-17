#!/bin/bash

lastPos=0

$HOME/.local/bin/battery-conservation.sh status
$HOME/.local/bin/rapid-charge.sh status
$HOME/.local/bin/performance-mode.sh status
$HOME/.local/bin/bluetooth-toggle.sh status
$HOME/.local/bin/wireguard-toggle.sh status
$HOME/.local/bin/wifi-toggle.sh status

while true; do

	pos=$(xdotool getmouselocation | cut -d ' ' -f 1 | cut -d ':' -f 2)
	if [ $pos != $lastPos ]; then
		if [ $pos == '1919' ]; then
			kill -s USR1 $(pidof deadd-notification-center)
		fi
	fi
	lastPos=$pos	
	sleep 1

done