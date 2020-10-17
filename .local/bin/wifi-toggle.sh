#!/bin/bash
input=$1

if [ "$input" = "status" ]; then
    state=$(rfkill -no TYPE,SOFT | grep wlan | head -n1 | cut -d ' ' -f 7)
    if [ "$state" == "" ]; then
        notify-send.py a --hint boolean:deadd-notification-center:false int:id:0 boolean:state:false type:string:buttons > /dev/null
    else
        notify-send.py a --hint boolean:deadd-notification-center:false int:id:0 boolean:state:true type:string:buttons > /dev/null
    fi

elif [ "$input" = "toggle" ]; then
    state=$(rfkill -no TYPE,SOFT | grep wlan | head -n1 | cut -d ' ' -f 7)
    if [ "$state" == "" ]; then
        rfkill unblock wlan
        notify-send.py a --hint boolean:deadd-notification-center:false int:id:0 boolean:state:true type:string:buttons > /dev/null
    else
        rfkill block wlan
        notify-send.py a --hint boolean:deadd-notification-center:false int:id:0 boolean:state:false type:string:buttons > /dev/null
    fi

elif [ "$input" = "disable" ]; then
        rfkill block wlan
        notify-send.py a --hint boolean:deadd-notification-center:false int:id:0 boolean:state:false type:string:buttons > /dev/null

elif [ "$input" = "enable" ]; then
        rfkill unblock wlan
        notify-send.py a --hint boolean:deadd-notification-center:false int:id:0 boolean:state:true type:string:buttons > /dev/null

else
    echo "usage: ./wifi-toggle.sh [status|toggle|enable|disable]"
fi