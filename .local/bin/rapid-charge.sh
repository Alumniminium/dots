#!/bin/bash
control=$1

#if [ $(whoami) != 'root' ]; then
#	echo 'this script requires root (try sudo)'
#	exit
#fi

if [ -z $control ]; then
	control='invalid'
fi

if [ $control = 'enable' ]; then

	echo '\_SB.PCI0.LPC0.EC0.VPC0.SBMC 0x07' | sudo tee /proc/acpi/call
	notify-send.py a --hint boolean:deadd-notification-center:true int:id:5 boolean:state:true type:string:buttons

elif [ $control = 'disable' ]; then

	echo '\_SB.PCI0.LPC0.EC0.VPC0.SBMC 0x08' | sudo tee /proc/acpi/call
	notify-send.py a --hint boolean:deadd-notification-center:true int:id:5 boolean:state:false type:string:buttons

elif [ $control = 'status' ]; then

	echo '\_SB.PCI0.LPC0.EC0.QCHO' | sudo tee /proc/acpi/call
	state=$(sudo cat /proc/acpi/call | cut -d '' -f1)

	if [ $state = "0x1" ]; then
		echo 'enabled'
	else
		echo 'disabled'
	fi

elif [ $control = 'toggle' ]; then

	echo '\_SB.PCI0.LPC0.EC0.QCHO' | sudo tee /proc/acpi/call
	state=$(sudo cat /proc/acpi/call | cut -d '' -f1)

	if [ $state = "0x1" ]; then
		echo '\_SB.PCI0.LPC0.EC0.VPC0.SBMC 0x08' | sudo tee /proc/acpi/call
		notify-send.py a --hint boolean:deadd-notification-center:true int:id:5 boolean:state:false type:string:buttons
	else
		echo '\_SB.PCI0.LPC0.EC0.VPC0.SBMC 0x07' | sudo tee /proc/acpi/call
		notify-send.py a --hint boolean:deadd-notification-center:true int:id:5 boolean:state:true type:string:buttons
	fi

else
	echo 'usage: sudo ./rapid-charge.sh [status|enable|disable|toggle]'
fi
