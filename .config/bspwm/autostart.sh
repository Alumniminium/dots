#!/bin/bash

function run {
  if ! pgrep $1 ;
  then
    $@&
  fi
}
sudo /usr/bin/ideapad-cm enable
xrandr --output ${MONITOR} --gamma 0.85
light -S 75
vibrantLinux --hidden &
RestoreSession &
wal --saturate 1 -i ~/.bg &
sudo powertop --auto-tune
xsetroot -cursor_name left_ptr &
DISPLAY=:0 sxhkd &> /home/alu/sxhkd.log &
volnoti &
keynav &
run nm-applet &
picom --experimental-backends &
/usr/lib/polkit-gnome/polkit-gnome-authentication-agent-1 &
/usr/lib/xfce4/notifyd/xfce4-notifyd &
run code &
run chromium &
run discord &
run thunderbird &
run termite &
run sidebar.sh &