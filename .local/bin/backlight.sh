#!/bin/bash

device='/sys/class/backlight/amdgpu_bl0/brightness'
timeout=1000

max=$(cat '/sys/class/backlight/amdgpu_bl0/max_brightness')
cur=$(cat $device)

command=$1
inputValue=$2

if [ $command = "+" ]; then
	if [ -z $inputValue ]; then
		val=$((cur+5))
	else
		val=$((cur+inputValue))
	fi
	if [ $val -gt $max ]; then
		val=$max
	fi
	echo $val | sudo tee $device
	notify-send.py -t $timeout "Brightness" "<b>$val</b>" --hint string:image-path:weather-clear boolean:transient:true --replaces-process "brightness-popup"
fi

if [ $command = '-' ]; then
	if [ -z $inputValue ]; then
		val=$((cur-5))
	else
		val=$((cur-inputValue))
	fi
	if [ 0 -gt $val ]; then
		val=0
	fi
	echo $val | sudo tee $device
	notify-send.py -t $timeout "Brightness" "<b>$val</b>" --hint string:image-path:weather-clear boolean:transient:true --replaces-process "brightness-popup"
fi

if [ $command = '=' ]; then
	if [ -z $inputValue ]; then
		val=$(cat $device)
		notify-send.py -t $timeout "Brightness" "<b>$val</b>" --hint string:image-path:weather-clear boolean:transient:true --replaces-process "brightness-popup"
	else
		echo $inputValue | sudo tee $device
		notify-send.py -t $timeout "Brightness" "<b>$inputValue</b>" --hint string:image-path:weather-clear boolean:transient:true --replaces-process "brightness-popup"
	fi
fi



function printHelp
{
	echo 'Get Brightness: backlight.sh ='
	echo 'Set Brightness: backlight.sh = 255'
	echo 'Increase by 50: backlight.sh + 75'
	echo 'Decrease by 75: backlight.sh - 75'
	echo 'Increase by 5: backlight.sh +'
	echo 'Decrease by 5: backlight.sh -'
}

if [ $command = '-h' ]; then
	printHelp
fi