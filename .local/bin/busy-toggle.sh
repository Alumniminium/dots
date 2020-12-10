#!/bin/bash

cacheFile="/tmp/deadd_busy"
state="1"

if [ -f $cacheFile ]; then
	state="$(cat $cacheFile)"
	echo "[$state]"
else
	echo "0" | sudo tee $cacheFile > /dev/null
	state=$(cat $cacheFile)
fi

if [ $state = "1" ]; then
	notify-send.py a --hint boolean:deadd-notification-center:true int:id:7 boolean:state:false type:string:buttons > /dev/null
	notify-send.py a --hint boolean:deadd-notification-center:true string:type:unpausePopups > /dev/null
	echo "0" | sudo tee $cacheFile
else
	notify-send.py a --hint boolean:deadd-notification-center:true int:id:7 boolean:state:true type:string:buttons > /dev/null
	notify-send.py a --hint boolean:deadd-notification-center:true string:type:pausePopups > /dev/null
	echo "1" | sudo tee $cacheFile
fi