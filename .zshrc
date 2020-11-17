#!/bin/bash

[ -n "$DISPLAY" ]  && command -v xdo >/dev/null 2>&1 && xdo id > /tmp/term-wid-"$$"
trap "( rm -f /tmp/term-wid-"$$" )" EXIT HUP

export TERM=xterm-256color
export ZSH="${HOME}/.oh-my-zsh"
ZSH_THEME="lambda-mod"
source $ZSH/oh-my-zsh.sh
(cat ~/.cache/wal/sequences &)

alias yt='f() { mpv $1    ytdl-format="bestvideo[height<=?1080][vcodec!=vp9]+bestaudio/best" };f'
alias chmox='chmod'
alias cls='clear && ls'
alias ncdu='ncdu --exclude="/mnt" --exclude="/storage"'
alias upack='dtrx'
alias ls='exa --icons -l --ignore-glob="*~" --group-directories-first'
alias mv='amv -g'
alias dfc='dfc -WwT -p /dev,alumni,root'
alias yay='yay --nopgpfetch --mflags --skippgpcheck'
alias trash='rmtrash'
alias rm='echo "use trash"; rm -i'
alias micro='echo "nope, u gonna use vim"; sleep 3; vim'
alias curl='curl --no-progress-meter'

alias ytdla="youtube-dl -f 'bestaudio[ext=m4a]'"
alias ytdlv="youtube-dl -f 'bestvideo[height<=?1080][vcodec!=vp9]+bestaudio/best'"

#THE WELCOME MESSAGE
zshstartup.sh