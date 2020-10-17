#!/bin/bash

input=$1

if [ "$input" = "toggle" ]; then
    state=$(rfkill -no TYPE,SOFT | grep bluetooth | head -n1 | cut -d ' ' -f 2)
    if [ "$state" = "unblocked" ]; then
        rfkill block bluetooth
        notify-send.py "Bluetooth" "Disabled" --hint string:image-path:bluetooth-disabled
        notify-send.py a --hint boolean:deadd-notification-center:false int:id:2 boolean:state:false type:string:buttons
    else
        rfkill unblock bluetooth
        notify-send.py "Bluetooth" "Enabled" --hint string:image-path:bluetooth-active
        notify-send.py a --hint boolean:deadd-notification-center:false int:id:2 boolean:state:true type:string:buttons
    fi
    
elif [ "$input" = "status" ]; then
    state=$(rfkill -no TYPE,SOFT | grep bluetooth | head -n1 | cut -d ' ' -f 2)
    if [ "$state" = "unblocked" ]; then
        notify-send.py a --hint boolean:deadd-notification-center:false int:id:2 boolean:state:true type:string:buttons
    else
        notify-send.py a --hint boolean:deadd-notification-center:false int:id:2 boolean:state:false type:string:buttons
    fi

elif [ "$input" = "enable" ]; then
    rfkill unblock bluetooth
    notify-send.py "Bluetooth" "Enabled" --hint string:image-path:bluetooth-active
    notify-send.py a --hint boolean:deadd-notification-center:false int:id:2 boolean:state:true type:string:buttons
    
elif [ "$input" = "disable" ]; then
    rfkill block bluetooth
    notify-send.py "Bluetooth" "Disabled" --hint string:image-path:bluetooth-disabled
    notify-send.py a --hint boolean:deadd-notification-center:false int:id:2 boolean:state:false type:string:buttons
    
else
    echo "usage: bluetooth-toggle.sh [status|toggle|enable|disable]"
fi