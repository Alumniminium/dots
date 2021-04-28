#!/bin/bash

WIREGUARD_CONNECTION="trbl"
NAMESERVER1="80.80.80.80"
NAMESERVER2="80.80.81.81"

do=$1

if [ "$do" = "status" ]; then

    connection=$(nmcli con show --active | grep -i $WIREGUARD_CONNECTION | cut -d ' ' -f 1)

    if [ "$connection" = "$WIREGUARD_CONNECTION" ]; then
        notify-send.py a --hint boolean:deadd-notification-center:true int:id:1 boolean:state:false type:string:buttons >/dev/null
    else
        notify-send.py a --hint boolean:deadd-notification-center:true int:id:1 boolean:state:false type:string:buttons >/dev/null
    fi

elif [ "$do" = "toggle" ]; then

    connection=$(nmcli con show --active | grep -i $WIREGUARD_CONNECTION | cut -d ' ' -f 1)

    if [ "$connection" = "$WIREGUARD_CONNECTION" ]; then
        sudo nmcli connection down $WIREGUARD_CONNECTION
        sleep 2
        echo "# Hello from wireguard-toggle.sh!" | sudo tee /etc/resolv.conf
        echo "nameserver $NAMESERVER1" | sudo tee -a /etc/resolv.conf
        echo "nameserver $NAMESERVER2" | sudo tee -a /etc/resolv.conf
        notify-send.py "WireGuard" "Disconnected!\nWi-Fi: $(nmcli con show --active | grep -i wifi | cut -d ' ' -f 1)\nIP: $(curl --no-progress-meter wtfismyip.com/text)" --hint string:image-path:channel-insecure-symbolic >/dev/null
        notify-send.py a --hint boolean:deadd-notification-center:true int:id:1 boolean:state:false type:string:buttons >/dev/null
    else
        sudo nmcli connection up $WIREGUARD_CONNECTION
        notify-send.py "WireGuard" "Connected\nIP: $(curl --no-progress-meter wtfismyip.com/text)" --hint string:image-path:channel-secure-symbolic >/dev/null
        notify-send.py a --hint boolean:deadd-notification-center:true int:id:1 boolean:state:true type:string:buttons >/dev/null
    fi

elif [ "$do" = "disable" ]; then

    sudo nmcli connection down $WIREGUARD_CONNECTION
    sleep 2
    echo "# Hello from wireguard-toggle.sh!" | sudo tee /etc/resolv.conf
    echo "nameserver 91.239.100.100 # anycast.censurfridns.dk" | sudo tee -a /etc/resolv.conf
    echo "nameserver 89.233.43.71 # unicast.censurfridns.dk" | sudo tee -a /etc/resolv.conf
    notify-send.py "WireGuard" "Disconnected!\nWi-Fi: .fsociety\nIP: $(curl --no-progress-meter wtfismyip.com/text)\n$(cat /etc/resolv.conf)" --hint string:image-path:channel-insecure-symbolic >/dev/null
    notify-send.py a --hint boolean:deadd-notification-center:true int:id:1 boolean:state:false type:string:buttons >/dev/null

elif [ "$do" = "enable" ]; then

    sudo nmcli connection up $WIREGUARD_CONNECTION
    notify-send.py "WireGuard" "Connected\nIP: $(curl --no-progress-meter wtfismyip.com/text)" --hint string:image-path:channel-secure-symbolic >/dev/null
    notify-send.py a --hint boolean:deadd-notification-center:true int:id:1 boolean:state:true type:string:buttons >/dev/null

else
    echo "usage: ./wireguard-toggle.sh [status|toggle|enable|disable]"
fi
