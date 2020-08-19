#!/bin/bash

#bypass installing apps if any arg is passed (fast path)
if [ -z $1 ]; then
    yay --save --nocleanmenu --nodiffmenu --noconfirm
    yes | yay -Syu
    yes | yay -S linux-amd rmtrash light acpi_call exa tp_smapi pulseeffects-git picom-tyrone-git xclip sox rmtrash ncdu dfc pkgfile mtr dotnet-host dotnet-runtime dotnet-sdk
    # optional stuff (wine deps, ..)
    yes | yay -S lib32-giflib lib32-mpg123 lib32-v4l-utils lib32-libxslt lib32-gtk3 keynav 
fi

# install background
cp Assets/.bg ~/.bg
cp Assets/ding.wav ~/.config/

cp -r .config ~
cp -r .local ~
echo 'copying /etc gimme root!'
sudo cp -r etc /

# install font
echo 'copying //usr/share/fonts/TTF gimme root!'
sudo cp Assets/ProFontWindows.ttf /usr/share/fonts/TTF