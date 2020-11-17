#!/bin/bash

echo 'on' | sudo tee '/sys/bus/usb/devices/1-1.4/power/control'
echo 'on' | sudo tee '/sys/bus/usb/devices/1-1.3/power/control'
#echo 'on' | sudo tee '/sys/bus/pci/devices/0000:01:00.0/power/control'
