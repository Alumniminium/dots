#!/bin/bash
control=$1

usage='usage: sudo ./battery-conservation.sh [status|enable|disable]'

if [ -z $control ]; then
	control='invalid input'
	echo $usage
	exit
fi

if [ $control = 'enable' ]; then
	echo '\_SB.PCI0.LPC0.EC0.VPC0.SBMC 0x03' | sudo tee /proc/acpi/call
elif [ $control = 'disable' ]; then
	echo '\_SB.PCI0.LPC0.EC0.VPC0.SBMC 0x05' | sudo tee /proc/acpi/call
elif [ $control = 'status' ]; then
	echo '\_SB.PCI0.LPC0.EC0.BTSM' | sudo tee /proc/acpi/call
	state=$(sudo cat /proc/acpi/call | cut -d '' -f1)
	if [ $state = '0x1' ]; then
		echo 'enabled'
	else
		echo 'disabled'
	fi
elif [ $control = 'toggle' ]; then

	echo '\_SB.PCI0.LPC0.EC0.BTSM' | sudo tee /proc/acpi/call
	state=$(sudo cat /proc/acpi/call | cut -d '' -f1)

	if [ $state = "0x1" ]; then
		echo '\_SB.PCI0.LPC0.EC0.VPC0.SBMC 0x05' | sudo tee /proc/acpi/call
	else
		echo '\_SB.PCI0.LPC0.EC0.VPC0.SBMC 0x03' | sudo tee /proc/acpi/call
	fi

else
	echo $usage
fi


echo '\_SB.PCI0.LPC0.EC0.BTSM' | sudo tee /proc/acpi/call
state=$(sudo cat /proc/acpi/call | cut -d '' -f1)

if [ $state = "0x1" ]; then
	notify-send.py a --hint boolean:deadd-notification-center:true int:id:6 boolean:state:true type:string:buttons
else
	notify-send.py a --hint boolean:deadd-notification-center:true int:id:6 boolean:state:false type:string:buttons
fi