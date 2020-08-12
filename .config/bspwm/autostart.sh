#!/bin/bash
/usr/lib/polkit-gnome/polkit-gnome-authentication-agent-1 &
/usr/lib/xfce4/notifyd/xfce4-notifyd &

# enable battery conservation on ideapads (charge up to 60%)
/usr/bin/ideapad-cm enable
# reduce gamma to make colors pop more (helps alot if you have a shitty screen with shit contrast)
xrandr --output $MONITOR --gamma 0.85
# (re)starts polybar on the given monitor
RestoreSession $MONITOR &
# set the display to max brightness
light -S 100
# generate colortheme and set wallpaper
#wal --saturate 1 -i ~/.bg &
wal --saturate 1 -i ~/Backgrounds/woa.jpg &

xsetroot -cursor_name left_ptr &
# start hotkey daemon
sxhkd &
# volume indicator overlay 
volnoti &
# move mouse with keyboard
keynav &
# network manager tray icon
nm-applet &
# compositor, vsync, transparency, blur
picom -bc --experimental-backends &

# start apps I use everytime I boot
sleep 3 && code &
chromium &
discord &
thunderbird &
