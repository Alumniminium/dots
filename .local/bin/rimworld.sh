#!/bin/bash

pid=$(xdotool getactivewindow)
pkill picom
pkill sidebar
if [ -t 0 ]; then
    bspc node "$pid" --flag hidden=on
fi

MANGOHUD_CONFIG=vsync=1,wine,engine_version,vulkan_driver,arch,fps,cpu_temp MANGOHUD=1 gamemoderun ~/.steam/steam/steamapps/common/RimWorld/start_RimWorld.sh
picom -bc --experimental-backends

if [ -t 0 ]; then
    bspc node "$pid" --flag hidden=off
fi
screen -dmS sidebar sh -c 'deadd-notification-server'
fg