#!/usr/bin/env dotnet-script

#load "rules.csx"
#load "xprop.csx"
#load "bspc.csx"

Flags = ParseFlags(Args[3]);
var (WM_CLASS, WM_NAME, type) = await DoMagic(Args[0]);

if (type == "_NET_WM_WINDOW_TYPE_DIALOG")
    DialogRules();
else if (WM_CLASS == "steam")
    SteamRules(WM_NAME);
else
    ApplyRulesForFirst(WM_CLASS, WM_NAME);

ApplyRules();
