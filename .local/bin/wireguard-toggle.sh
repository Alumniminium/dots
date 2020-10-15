#!/bin/bash
connection=$(nmcli con show --active | grep -i trbl-wg | cut -d ' ' -f 1)

if [ "$connection" = "trbl-wg" ]; then
    sudo nmcli connection down trbl-wg  
    sleep 2
    echo "# Hello from wireguard-toggle.sh!" | sudo tee /etc/resolv.conf
    echo "nameserver 91.239.100.100 # anycast.censurfridns.dk" | sudo tee -a /etc/resolv.conf
    echo "nameserver 89.233.43.71 # unicast.censurfridns.dk" | sudo tee -a /etc/resolv.conf
    notify-send.py "WireGuard" "Disconnected!\nWi-Fi: .fsociety\nIP: $(curl --no-progress-meter wtfismyip.com/text)\n$(cat /etc/resolv.conf)" --hint string:image-path:channel-insecure-symbolic  
    notify-send.py a --hint boolean:deadd-notification-center:true int:id:1 boolean:state:false type:string:buttons
else
    sudo nmcli connection up trbl-wg
    notify-send.py "WireGuard" "Connected\nIP: $(curl --no-progress-meter wtfismyip.com/text)" --hint string:image-path:channel-secure-symbolic
    notify-send.py a --hint boolean:deadd-notification-center:true int:id:1 boolean:state:true type:string:buttons
fi

# todo send notification from network manager hook to update icon
