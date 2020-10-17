#!/bin/bash

export PATH="/usr/local/sbin:/usr/bin/core_perl:/usr/local/bin:/usr/bin:$(ruby -e 'puts Gem.user_dir')/bin"
export PATH="${PATH}:${HOME}/.local/bin/"
export PATH="$PATH:${HOME}/.dotnet/tools"
export PATH="$PATH:${HOME}/.cargo/bin"

export BSPWM_SOCKET="/tmp/bspwm-socket"
export BROWSER=/usr/bin/chromium
export DOTNET_CLI_TELEMETRY_OPTOUT=1
export EDITOR=/usr/bin/micro
export MONITOR=$(xrandr | grep -w 'connected' | cut -d' ' -f 1)
export TERMINAL=/usr/bin/termite
export PANEL_FIFO="/tmp/panel-fifo"
export PANEL_FIFO PANEL_HEIGHT PANEL_FONT_FAMILY
export XDG_CONFIG_HOME="$HOME/.config"
export XDG_CONFIG_DIRS=/usr/etc/xdg:/etc/xdg

# Set MONITOR to first connected display output
# fix java applications not rendering
export _JAVA_AWT_WM_NONREPARENTING=1
[[ -z $DISPLAY && $XDG_VTNR -eq 1 ]] && exec startx -- -keeptty -nolisten tcp > ~/.xorg.log 2>&1