#!/bin/bash

pid=$(xdotool getactivewindow)
sudo mount /dev/nvme0n1p2 /mnt/win
pkill picom
cpu
gamemoded -r &
if [ -t 0 ]; then
    bspc node "$pid" --flag hidden=on
fi

MANGOHUD_CONFIG=vsync=1,wine,engine_version,vulkan_driver,arch,fps,cpu_temp MANGOHUD=1 /mnt/win/Program\ Files\ \(x86\)/Divinity\ Original\ Sin\ 2\ Definitive\ Edition/DefEd/bin/EoCApp.exe
picom -bc --experimental-backends

if [ -t 0 ]; then
    bspc node "$pid" --flag hidden=off
fi