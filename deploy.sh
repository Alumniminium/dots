#!/bin/bash
yay --save --nocleanmenu --nodiffmenu --noconfirm

yes | yay -Syu
yes | yay -S rmtrash light acpi_call exa tp_smapi pulseeffects-git picom-tyrone-git xclip
# optional apps
yes | yay -S keynav ncdu dfc pkgfile mtr
# optional wine deps
yes | yay -S lib32-giflib lib32-mpg123 lib32-v4l-utils lib32-libxslt lib32-gtk3
# c# dev
yes | yay -S dotnet-host dotnet-runtime dotnet-sdk

# install background
cp Assets/.bg ~/.bg


cp -r .config ~
cp -r .local ~
echo 'copying /etc gimme root!'
sudo cp -r etc /

# install font
echo 'copying //usr/share/fonts/TTF gimme root!'
sudo cp Assets/ProFontWindows.ttf /usr/share/fonts/TTF