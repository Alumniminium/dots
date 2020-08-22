#!/bin/sh

HOST=89.163.230.146

if ! ping=$(ping -n -c 1 -W 5 $HOST); then
    echo "# ping failed"
else
    rtt=$(echo "$ping" | sed -rn 's/.*time=([0-9]{1,})\.?[0-9]{0,} ms.*/\1/p')

    if [ "$rtt" -lt 50 ]; then
        echo "%{F#08fee4}$rtt ms"
    elif [ "$rtt" -lt 100 ]; then
        echo "%{F#00c1de}$rtt ms"
    elif [ "$rtt" -lt 200 ]; then
		echo "%{F#e000a2}$rtt ms"
    else
        echo "%{F#ff5b77}$rtt ms"    
    fi
fi
