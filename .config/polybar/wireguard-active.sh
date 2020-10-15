#!/bin/sh
wg=$(nmcli con show --active | grep wireguard)
if [ -z "$wg" ]; then
    echo "%{F#ff5b77}%{F-}" # return a red lock icon (openvpn isnt running)
else
    echo "%{F#08fee4}%{F-}" # return a green lock icon (openvpn is running)
fi
