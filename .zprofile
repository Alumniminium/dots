export PATH="/usr/local/sbin:/usr/bin/core_perl:/usr/local/bin:/usr/bin:$(ruby -e 'puts Gem.user_dir')/bin"
export PANEL_FIFO="/tmp/panel-fifo"
export XDG_CONFIG_HOME="$HOME/.config"
export BSPWM_SOCKET="/tmp/bspwm-socket"
export XDG_CONFIG_DIRS=/usr/etc/xdg:/etc/xdg
export PANEL_FIFO PANEL_HEIGHT PANEL_FONT_FAMILY
export BROWSER=/usr/bin/chromium
export EDITOR=/usr/bin/micro
export TERMINAL=/usr/bin/termite

# Set MONITOR to first connected display output
export MONITOR=$(xrandr | grep -w 'connected' | cut -d' ' -f 1)
# fix java applications not rendering
export _JAVA_AWT_WM_NONREPARENTING=1
[[ -z $DISPLAY && $XDG_VTNR -eq 1 ]] && exec startx -- -keeptty -nolisten tcp > ~/.xorg.log 2>&1