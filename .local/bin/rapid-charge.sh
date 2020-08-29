#!/bin/bash
control=$1

if [ -z $control ]; then
	control='invalid'
fi

if [ $control = 'enable' ]; then
	echo '\_SB.PCI0.LPC0.EC0.VPC0.SBMC 0x07' > /proc/acpi/call
elif [ $control = 'disable' ]; then
	echo '\_SB.PCI0.LPC0.EC0.VPC0.SBMC 0x08' > /proc/acpi/call
else
	echo 'usage: sudo ./rapid-charge.sh [enable|disable]'
fi