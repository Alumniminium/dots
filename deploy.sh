#!/bin/bash

cp -s $PWD/.profile "/home/$(whoami)/"
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
mkdir "/home/$(whoami)/.local/share/mailspring-nord-theme/"
cp -rs $PWD/Assets/mailspring-nord-theme/* "/home/$(whoami)/.local/share/mailspring-nord-theme/"
cp -rs $PWD/.local/* "/home/$(whoami)/.local/"
echo 'copying /etc gimme root!'
sudo cp -rs $PWD/etc /

# install font
echo 'copying fonts into /usr/share/fonts/TTF gimme root!'
sudo cp -s $PWD/Assets/ProFontWindows.ttf /usr/share/fonts/TTF/


#bypass installing apps if any arg is passed (fast path)
if [ -z $1 ]; then
    mkdir /tmp/yay
    yay --save --nocleanmenu --nodiffmenu --noconfirm --builddir /tmp/yay --sortby popularity --removemake --batchinstall --combinedupgrade --sudoloop
    yes | yay -Syu
    yes | yay -S linux-amd linux-amd-headers acpi_call-dkms rmtrash light exa tp_smapi pulseeffects-git \
                 lib32-giflib lib32-mpg123 lib32-v4l-utils lib32-libxslt lib32-gtk3 keynav \
                 steam surf ly mpv clementine picom-tryone-git xclip sox rmtrash ncdu dfc zsh \
                 wireguard-dkms wireguard-tools pkgfile mtr dotnet-host dotnet-runtime dotnet-sdk \
                 ruby-cairo visual-studio-code-bin chromium-vaapi network-manager-applet gamemode \
                 discord thunderbird pcmanfm vibrantlinux-git figlet mysql-workbench redis-desktop-manager \
                 wine-nine deadd-notification-center-bin python-pip wine-tkg-fsync-vkd3d-opt-git
    pip install notify-send.py && sudo pip install notify-send.py
    sh -c "$(curl -fsSL https://raw.githubusercontent.com/ohmyzsh/ohmyzsh/master/tools/install.sh)"
fi

