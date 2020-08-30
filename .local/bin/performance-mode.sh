#!/bin/bash
control=$1

if [ -z $control ]; then
	control='invalid'
fi

if [ $control = 'extreme' ]; then
	echo '\_SB.PCI0.LPC0.EC0.VPC0.DYTC 0x0012B001' > /proc/acpi/call
elif [ $control = 'intelligent' ]; then
	echo '\_SB.PCI0.LPC0.EC0.VPC0.DYTC 0x000FB001' > /proc/acpi/call
elif [ $control = 'battery' ]; then
	echo '\_SB.PCI0.LPC0.EC0.VPC0.DYTC 0x0013B001' > /proc/acpi/call
else
	echo 'usage: sudo ./performance-mode.sh [extreme|intelligent|battery]'
fi