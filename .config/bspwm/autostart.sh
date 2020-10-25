#!/bin/bash

mkdir "/tmp/yay"
mkdir "/tmp/yay/abs"
sxhkd &> $HOME/sxhkd.log &
xsetroot -cursor_name left_ptr &
/usr/lib/polkit-gnome/polkit-gnome-authentication-agent-1 &
sudo powertop --auto-tune

xrandr --output ${MONITOR} --gamma 0.85
picom --experimental-backends &
vibrantLinux --hidden &
wal --saturate 1 -i ~/.bg &

volnoti &
pulseaudio --start
mpd
sshmount local && mpc add / && mpc shuffle
mpDris2 & # makes playerctl work for mpd

#keynav &
nm-applet &
code &
#chromium &
discord-canary &
#discord &
element-desktop &
#thunderbird &
mailspring &
RestoreSession &