#!/usr/bin/env dotnet-script

#load "/home/alu/coding/linux-dotnet-scripts/wrappers/bspc.csx"

//esktop='^2'    follow=off  state=floating      rectangle=1280x1024+0+0     center=true
new bspcRule("Chromium").Floating().Size(1280,1024,0,0).Centered();