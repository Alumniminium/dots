#!/bin/bash

cp -s $PWD/.xinitrc "/home/$(whoami)/"
cp -s $PWD/.zprofile "/home/$(whoami)/"
cp -s $PWD/.zshrc "/home/$(whoami)/"
cp -s $PWD/.oh-my-zsh/themes/* "/home/$(whoami)/.oh-my-zsh/themes/"
# install background
cp -s $PWD/Assets/.bg "/home/$(whoami)/"
cp -s $PWD/Assets/ding.wav "/home/$(whoami)/.config/"

# install ocnfigs
echo 'copying .config...'
cp -rs $PWD/.config/* "/home/$(whoami)/.config/"
echo 'reloading sxhkd...'
# reload sxhkd config
pkill -USR1 -x sxhkd

echo 'copying .local...'
cp -rs $PWD/.local/* "/home/$(whoami)/.local/"
echo 'copying /etc gimme root!'
sudo cp -rs $PWD/etc /

# install font
echo 'copying fonts into /usr/share/fonts/TTF gimme root!'
sudo cp -s $PWD/Assets/ProFontWindows.ttf /usr/share/fonts/TTF/


#bypass installing apps if any arg is passed (fast path)
if [ -z $1 ]; then
    yay --save --nocleanmenu --nodiffmenu --noconfirm
    yes | yay -Syu
    yes | yay -S linux-amd acpi_call-dkms rmtrash light exa tp_smapi pulseeffects-git \
                 picom-tryone-git xclip sox rmtrash ncdu dfc zsh \
                 pkgfile mtr dotnet-host dotnet-runtime dotnet-sdk \
                 visual-studio-code-bin chromium-vaapi network-manager-applet \
                 discord thunderbird nemo vibrantlinux-git figlet \
                 deadd-notification-center-bin python-pip
    pip install notify-send.py && sudo pip install notify-send.py
    # optional stuff (wine deps, ..)
    yes | yay -S lib32-giflib lib32-mpg123 lib32-v4l-utils lib32-libxslt lib32-gtk3 keynav

    sh -c "$(curl -fsSL https://raw.githubusercontent.com/ohmyzsh/ohmyzsh/master/tools/install.sh)"
fi

