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
export XDG_CONFIG_HOME="$HOME/.config"
export XDG_CONFIG_DIRS=/usr/etc/xdg:/etc/xdg
export MGFXC_WINE_PATH=/home/alu/.winemonogame

# fix java applications not rendering
export _JAVA_AWT_WM_NONREPARENTING=1export MANGOHUD=1
export MANGOHUD=1
export MANGOHUD=1
export MANGOHUD=1
export ENABLE_VKBASALT=1
