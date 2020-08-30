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
RestoreSession &
wal --saturate 1 -i ~/.bg &
sudo powertop --auto-tune
xsetroot -cursor_name left_ptr &
sxhkd &
volnoti &
keynav &
run nm-applet &
picom --experimental-backends &
/usr/lib/polkit-gnome/polkit-gnome-authentication-agent-1 &
run code &
run chromium &
run discord &
run thunderbird &
