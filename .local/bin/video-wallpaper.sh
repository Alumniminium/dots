#!/bin/bash

# requires:
# yay -S xwinwrap-git mpv youtube-dl

xwinwrap -s -b -st -sp -fs -ni -nf -fdt -- mpv -wid WID --ytdl-format="bestvideo[height<=?1080]+bestaudio/best" $1
