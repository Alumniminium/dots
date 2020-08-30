clear
export DOTNET_CLI_TELEMETRY_OPTOUT=1
export PATH="${PATH}:${HOME}/.local/bin/"
export PATH="$PATH:${HOME}/.dotnet/tools"
export PATH="$PATH:${HOME}/.cargo/bin"
export ZSH="${HOME}/.oh-my-zsh"
export TERM=xterm-256color
ZSH_THEME="lambda-mod"
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
alias trash='rmtrash'
alias rm='echo "use trash"; rm -i'
alias micro='echo "nope, u gonna use vim"; sleep 3; vim'

#THE WELCOME MESSAGE

clear

echo "\x1B[01;91m"
echo "████████╗██████╗ ██████╗ ██╗        ██╗  ██╗███████╗██████╗    ███████╗████████╗"
echo "╚══██╔══╝██╔══██╗██╔══██╗██║        ██║  ██║██╔════╝██╔══██╗   ██╔════╝╚══██╔══╝"
echo "   ██║   ██████╔╝██████╔╝██║        ███████║█████╗  ██████╔╝   ███████╗   ██║   "
echo "   ██║   ██╔══██╗██╔══██╗██║        ██╔══██║██╔══╝  ██╔══██╗   ╚════██║   ██║   "
echo "   ██║   ██║  ██║██████╔╝███████╗██╗██║  ██║███████╗██║  ██║██╗███████║   ██║   "
echo "   ╚═╝   ╚═╝  ╚═╝╚═════╝ ╚══════╝╚═╝╚═╝  ╚═╝╚══════╝╚═╝  ╚═╝╚═╝╚══════╝   ╚═╝   "
                                                                    
echo "\x1B[01;96m======================== OS INFO ========================"
echo "  \x1B[01;94mHostname:   \x1B[01;95m"`hostname`
echo "  \x1B[01;94mOS:         \x1B[01;95m"`cat /etc/os-release | grep NAME | cut -d '=' -f 2`
echo "  \x1B[01;94mKernel:     \x1B[01;95m"`uname -r`
echo ""
echo "\x1B[01;96m======================== HW INFO ========================"
echo "  \x1B[01;94mCPU:        \x1B[01;95m"`cat /proc/cpuinfo | grep "model name" | head -n1 | cut -d ':' -f 2 | sed -e 's/^[ \t]*//'`
echo "  \x1B[01;94mMemory:    \x1B[01;95m"`free -mht| awk '/Mem/{print " \t\tTotal: " $2 "\tFree: " $6}'`
echo "  \x1B[01;94mDisk Used:  \x1B[01;95m"`df -h /dev/nvme0n1p4 | grep '/dev' | awk -F ' ' '{print $5}'`
echo ""
echo "  type 'screen -RR' if you want a screen session"