clear
export DOTNET_CLI_TELEMETRY_OPTOUT=1
export PATH="${PATH}:${HOME}/.local/bin/"
export PATH="$PATH:/home/alu/.dotnet/tools"
export PATH="$PATH:/home/alu/.cargo/bin"
export ZSH="/home/alu/.oh-my-zsh"
export TERM=xterm-256color
ZSH_THEME="lambda-mod"
source ~/.zshfunctions
plugins=()
source $ZSH/oh-my-zsh.sh
(cat ~/.cache/wal/sequences &)
alias yt='f() { mpv $1    ytdl-format="bestvideo[height<=?1080][vcodec!=vp9]+bestaudio/best" };f'
alias chmox='chmod'
alias cls='clear && ls'
alias ncdu='ncdu --exclude="/mnt" --exclude="/storage"'
alias upack='dtrx'
alias ls='exa -l --ignore-glob="*~" --group-directories-first'
alias mv='amv -g'
alias dfc='dfc -WwT -p /dev,alumni,root'
alias yay='yay --nopgpfetch --mflags --skippgpcheck'
alias xclip="xclip -selection c"
alias trash='rmtrash'
alias rm='echo "use trash"; rm -i'
alias micro='echo "nope, u gonna use vim"; sleep 3; vim'