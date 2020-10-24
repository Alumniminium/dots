#!/bin/bash

function run {
  if ! pgrep $1 ;
  then
    $@&
  fi
}

pulseaudio --start
sshmount local
sxhkd &> $HOME/sxhkd.log &
xsetroot -cursor_name left_ptr &
/usr/lib/polkit-gnome/polkit-gnome-authentication-agent-1 &
/usr/lib/xfce4/notifyd/xfce4-notifyd &
sudo powertop --auto-tune

xrandr --output ${MONITOR} --gamma 0.85
picom --experimental-backends &
vibrantLinux --hidden &
wal --saturate 1 -i ~/.bg &

volnoti &
mpd &
mpDris2 & # makes playerctl work for mpd
mpc add / && mpc shuffle &

keynav &
run nm-applet &
run code &
run chromium &
run discord &
run element-desktop &
run thunderbird &
RestoreSession &