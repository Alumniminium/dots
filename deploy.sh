#!/bin/bash
cp -sf $PWD/.profile "/home/$(whoami)/"
cp -sf $PWD/.zprofile "/home/$(whoami)/"
cp -sf $PWD/.zshrc "/home/$(whoami)/"

# install background
cp -sf $PWD/Assets/.bg "/home/$(whoami)/"
cp -sf $PWD/Assets/ding.wav "/home/$(whoami)/.config/"

# install ocnfigs
echo 'copying .config...'
cp -rsf $PWD/.config/* "/home/$(whoami)/.config/"
echo 'reloading sxhkd...'
# reload sxhkd config
pkill -USR1 -x sxhkd

echo 'newsboat...'
mkdir "/home/$(whoami)/.newsboat" > /dev/null 2>&1
cp -rsf $PWD/.newsboat/* "/home/$(whoami)/.newsboat/"

echo 'copying .local...'
cp -rsf $PWD/.local/* "/home/$(whoami)/.local/"
echo 'copying /etc gimme root!'
sudo cp -rf $PWD/etc/* /etc/

# install font
echo 'copying fonts into /usr/share/fonts/TTF gimme root!'
sudo cp -f $PWD/Assets/ProFontWindows.ttf /usr/share/fonts/TTF/

cp -sf $PWD/.oh-my-zsh/themes/* "/home/$(whoami)/.oh-my-zsh/themes/"

#bypass installing apps if any arg is passed (fast path)
if [ -z $1 ]; then
    mkdir /tmp/yay > /dev/null 2>&1
    yay --save --nocleanmenu --nodiffmenu --noconfirm --builddir /tmp/yay --sortby popularity --removemake --batchinstall --combinedupgrade --sudoloop 
    yes | yay -Syu
    # core linux shit
    yay -S pkgfile linux linux-headers acpi_call light exa tp_smapi pulseeffects-git lib32-giflib lib32-mpg123 lib32-v4l-utils lib32-libxslt lib32-gtk3 xclip rmtrash ncdu dfc pcmanfm
    yay -S keynav advcp
    yay -S wireguard-dkms wireguard-tools mtr  network-manager-applet  
    yay -S discord mailspring-libre  
    # media
    yay -S pamixer surf ly mpv mpc playerctl mpd sox chromium-vaapi vibrantlinux-git figlet picom-tryone-git 
    # gaming
    yay -S steam gamemode
    # wine
    yay -S wine wine-nine wine-tkg-fsync-vkd3d-opt-git
    
    # C# Shit
    yay -S dotnet-host dotnet-runtime dotnet-sdk dotnet-host-preview dotnet-runtime-preview dotnet-sdk-preview otnet-targeting-pack-preview
    # aspnetcore shit
    yay -S aspnet-runtime-preview aspnet-targeting-pack-preview
    # shit IDE
    yay -S visual-studio-code-bin
    
    # whyp.it
    yay -S redis-desktop-maanger mysql-workbench ffmpeg
    
    # trbl blow
    yay -S ruby ruby-cairo
    echo "PATH="$PATH:$(ruby -e 'puts Gem.user_dir')/bin"" >> "/home/$(whoami)/.profile"
    gem install jekyll bundler
    ## ready for bundle exec jekyll serve

    # sidebar
    yay -S deadd-notification-center-bin python-pip
    pip install notify-send.py && sudo pip install notify-send.py

    # shell
    yay -S zsh 
    sh -c "$(curl -fsSL https://raw.githubusercontent.com/ohmyzsh/ohmyzsh/master/tools/install.sh)"
    cp -sf $PWD/.oh-my-zsh/themes/* "/home/$(whoami)/.oh-my-zsh/themes/"
fi