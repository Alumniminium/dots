#!/bin/bash
control=$1

usage="usage: sudo ./performance-mode.sh [status|extreme|intelligent|battery]"

if [ -z $control ]; then
	control=' '
	echo "$usage"
	exit
fi

if [ $control = 'extreme' ]; then
	echo '\_SB.PCI0.LPC0.EC0.VPC0.DYTC 0x0012B001' | sudo tee /proc/acpi/call
	sudo cpupower frequency-set -g performance
	sudo ryzenadj -a 23000 -b 23000 -c 23000
elif [ $control = 'intelligent' ]; then
	echo '\_SB.PCI0.LPC0.EC0.VPC0.DYTC 0x000FB001' | sudo tee /proc/acpi/call
    sudo cpupower frequency-set -g schedutil
	sudo ryzenadj -a 15000 -b 15000 -c 15000
elif [ $control = 'battery' ]; then
	echo '\_SB.PCI0.LPC0.EC0.VPC0.DYTC 0x0013B001' | sudo tee /proc/acpi/call
	sudo cpupower frequency-set -g powersave
	sudo ryzenadj -a 10000 -b 10000 -c 10000
elif [ $control = 'ultralow' ]; then
	echo '\_SB.PCI0.LPC0.EC0.VPC0.DYTC 0x0013B001' | sudo tee /proc/acpi/call
	sudo cpupower frequency-set -g powersave
	sudo ryzenadj -a 2000 -b 2000 -c 2000
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
		sudo cpupower frequency-set -g powersave
		sudo ryzenadj -a 2000 -b 2000 -c 2000
	else
		echo '\_SB.PCI0.LPC0.EC0.VPC0.DYTC 0x000FB001' | sudo tee /proc/acpi/call
		sudo cpupower frequency-set -g schedutil
		sudo ryzenadj -a 15000 -b 15000 -c 15000
	fi
else
	echo "$usage"
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
