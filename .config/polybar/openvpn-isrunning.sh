#!/bin/sh

if pgrep -x "openvpn" > /dev/null 
then
    echo "%{F#08fee4}%{F-}" # return a green lock icon (openvpn is running)
else
    echo "%{F#ff5b77}%{F-}" # return a red lock icon (openvpn isnt running)
fi
