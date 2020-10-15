#!/bin/bash

ssid=$(nmcli con show --active | grep -i wifi | cut -d ' ' -f 1)

if [ "$ssid" = "" ]; then
    rfkill unblock wlan
    notify-send.py a --hint boolean:deadd-notification-center:false int:id:0 boolean:state:true type:string:buttons
else
    rfkill block wlan
    notify-send.py a --hint boolean:deadd-notification-center:false int:id:0 boolean:state:false type:string:buttons
fi
