#!/usr/bin/env dotnet-script

#load "/home/alu/coding/linux-dotnet-scripts/wrappers/bspcConfig.csx"
#load "/home/alu/coding/linux-dotnet-scripts/wrappers/bspcRule.csx"


//#BSPWM configuration
//bspc config border_width        1
//bspc config window_gap			12
//bspc config top_padding         22
//bspc config split_ratio         0.51

bspcConfig.BorderThickness = 1;
bspcConfig.WindowGap = 12;
bspcConfig.TopPadding = 22;
bspcConfig.SplitRatio = 0.5f;


//esktop='^2'    follow=off  state=floating      rectangle=1280x1024+0+0     center=true
new bspcRule("Chromium")
        .Desktop(2)
        .DontFollow()
        .Floating()
        .Centered()
        .Size(1280,1024,0,0)
        .Apply();