#!/bin/bash
control=$1

usage='usage: sudo ./performance-mode.sh [extreme|intelligent|battery]'
str_sudoreqired='this script requires root (try sudo)'

if [ $(whoami) != 'root' ]; then
	echo $str_sudoreqired
	exit
fi

if [ -z $control ]; then
	control=' '
	echo $usage
	exit
fi

if [ $control = 'extreme' ]; then
	echo '\_SB.PCI0.LPC0.EC0.VPC0.DYTC 0x0012B001' > /proc/acpi/call
elif [ $control = 'intelligent' ]; then
	echo '\_SB.PCI0.LPC0.EC0.VPC0.DYTC 0x000FB001' > /proc/acpi/call
elif [ $control = 'battery' ]; then
	echo '\_SB.PCI0.LPC0.EC0.VPC0.DYTC 0x0013B001' > /proc/acpi/call
else
	echo $usage
fi