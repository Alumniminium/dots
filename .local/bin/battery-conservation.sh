#!/bin/bash
control=$1

usage='usage: sudo ./battery-conservation.sh [enable|disable]'

if [ $(whoami) != 'root' ]; then
	echo 'this script requires root (try sudo)'
	exit
fi

if [ -z $control ]; then
	control='invalid input'
	echo $usage
	exit
fi

if [ $control = 'enable' ]; then
	echo '\_SB.PCI0.LPC0.EC0.VPC0.SBMC 0x03' > /proc/acpi/call
elif [ $control = 'disable' ]; then
	echo '\_SB.PCI0.LPC0.EC0.VPC0.SBMC 0x05' > /proc/acpi/call
else
	echo $usage
fi