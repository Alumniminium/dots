#!/bin/bash

lastPos=0

while true; do

	pos=$(xdotool getmouselocation | cut -d ' ' -f 1 | cut -d ':' -f 2)
	echo "Pos: $pos"
	echo "Last: $lastPos"
	if [ $pos != $lastPos ]; then
		if [ $pos == '1919' ]; then
			kill -s USR1 $(pidof deadd-notification-center)
		fi
	fi
	lastPos=$pos
	sleep 1

done