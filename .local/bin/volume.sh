#!/bin/bash

VOL=$(pamixer --get-volume)

case "$1" in
    "up")
		 VOL=$(($VOL+1))
         pamixer --set-volume $VOL
         ;;
  "down")
		 VOL=$(($VOL-1))
         pamixer --set-volume $VOL
         ;;
  "mute")
         pamixer -t
          ;;
esac

STATE=$(pamixer --get-mute)

# Show notifications
if [[ $STATE = "true" ]]; then
  notify-send.py a --hint boolean:deadd-notification-center:true \
               int:id:3 boolean:state:true type:string:buttons
else
  notify-send.py a --hint boolean:deadd-notification-center:true \
               int:id:3 boolean:state:false type:string:buttons
  notify-send.py -t 1000 Volume "\n <b>$VOL%</b>" --hint string:image-path:audio-volume-high
fi
