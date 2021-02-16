#!/usr/bin/env dotnet-script

#load "rules.csx"
#load "xprop.csx"
#load "bspc.csx"

writer.WriteLine("Starting up...");
Flags = ParseFlags(Args[3]);
var (WM_CLASS, WM_NAME, type) = await DoMagic(Args[0]);

// if (type == "_NET_WM_WINDOW_TYPE_DIALOG")
    // DialogRules();
// else
ApplyRulesForFirst(WM_CLASS, WM_NAME,type);

ApplyRules();
PrintDebugInfo(Args,WM_CLASS,WM_NAME,type);
writer.WriteLine("Shutting down...");
