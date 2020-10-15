#!/bin/bash
control=$1

usage='usage: sudo ./performance-mode.sh [status|extreme|intelligent|battery]'

if [ -z $control ]; then
	control=' '
	echo $usage
	exit
fi

if [ $control = 'extreme' ]; then
	echo '\_SB.PCI0.LPC0.EC0.VPC0.DYTC 0x0012B001' | sudo tee /proc/acpi/call
elif [ $control = 'intelligent' ]; then
	echo '\_SB.PCI0.LPC0.EC0.VPC0.DYTC 0x000FB001' | sudo tee /proc/acpi/call
elif [ $control = 'battery' ]; then
	echo '\_SB.PCI0.LPC0.EC0.VPC0.DYTC 0x0013B001' | sudo tee /proc/acpi/call
elif [ $control = 'status' ]; then
	echo '\_SB.PCI0.LPC0.EC0.SPMO' | sudo tee /proc/acpi/call
	state=$(sudo cat /proc/acpi/call | cut -d '' -f1)
	if [ $state = "0x0" ]; then
		echo "[intelligent] Intelligent Cooling"
	elif [ $state = "0x1" ]; then
		echo "[extreme] Extreme Performance"
	else
		echo "[battery] Battery Saving"
	fi
elif [ $control = 'toggle' ]; then
	echo '\_SB.PCI0.LPC0.EC0.SPMO' | sudo tee /proc/acpi/call
	state=$(sudo cat /proc/acpi/call | cut -d '' -f1)
	if [ $state = "0x0" ]; then
		echo '\_SB.PCI0.LPC0.EC0.VPC0.DYTC 0x0013B001' | sudo tee /proc/acpi/call
	else
		echo '\_SB.PCI0.LPC0.EC0.VPC0.DYTC 0x000FB001' | sudo tee /proc/acpi/call
	fi
else
	echo $usage
fi


echo '\_SB.PCI0.LPC0.EC0.SPMO' | sudo tee /proc/acpi/call
state=$(sudo cat /proc/acpi/call | cut -d '' -f1)
if [ $state = "0x0" ]; then
	notify-send.py a --hint boolean:deadd-notification-center:true int:id:7 boolean:state:false type:string:buttons
elif [ $state = "0x2" ]; then
	notify-send.py a --hint boolean:deadd-notification-center:true int:id:7 boolean:state:true type:string:buttons
else
	echo "fuk"
fi