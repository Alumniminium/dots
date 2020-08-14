#!/bin/bash

#if [[ $(/usr/bin/id -u) -ne 0 ]]; then
#    echo "Give me root!"
#    exit
#fi

yay --save --nocleanmenu --nodiffmenu --noconfirm

yes | yay -S rmtrash light acpi_call exa tp_smapi pulseeffects-git picom-tyrone-git 
# optional apps
yes | yay -S keynav ncdu dfc pkgfile mtr
# optional wine deps
yes | yay -S lib32-giflib lib32-mpg123 lib32-v4l-utils lib32-libxslt lib32-gtk3
# c# dev
yes | yay -S dotnet-host dotnet-runtime dotnet-sdk

# install font
cp Assets/ProFontWindows.ttf /usr/share/fonts/TTF
# install background
cp Assets/.bg ~/.bg


cp -r .config ~
cp -r etc /
cp -r .local ~
