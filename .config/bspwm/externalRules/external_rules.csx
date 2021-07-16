#!/usr/bin/env dotnet-script

#load "/home/alu/coding/linux-dotnet-scripts/io/ini.csx"
#load "/home/alu/coding/linux-dotnet-scripts/wrappers/xprop.csx"
#load "/home/alu/coding/linux-dotnet-scripts/wrappers/bspc/bspcStream.csx"

using System.Collections.Generic;
using System.IO;
using System.Text;

StreamWriter writer = new("/tmp/extenal_rules.log") { AutoFlush = true };

try
{
    writer.WriteLine("Starting up...");

    bspcStream.Flags = bspcStream.ParseFlags(Args[3]);
    var (WM_CLASS, WM_NAME, WM_TYPE) = xprop.getWindowInfoById(Args[0]);

    if (WM_TYPE == string.Empty)
    {
        WM_TYPE = WM_NAME;
        WM_NAME = WM_CLASS;
        WM_CLASS = Args[2].ToLowerInvariant();
    }

    WM_TYPE = WM_TYPE.ToUpperInvariant();
    WM_CLASS = WM_CLASS.ToLowerInvariant();
    WM_NAME = WM_NAME.ToLowerInvariant();

    var paths = new[]
    {
        Path.Combine(WM_CLASS, $"{WM_NAME}.ini"),
        Path.Combine(WM_CLASS, $"{WM_CLASS}.ini"),
        $"{WM_NAME}.ini",
        $"{WM_CLASS}.ini",
        $"{WM_TYPE}.ini",

        Path.Combine(WM_CLASS, $"{WM_NAME}.csx"),
        Path.Combine(WM_CLASS, $"{WM_CLASS}.csx"),
        $"{WM_NAME}.csx",
        $"{WM_CLASS}.csx",
        $"{WM_TYPE}.csx"
    };

    for (int i = 0; i < paths.Length; i++)
    {
        var ruleFile = Path.Combine("/home", Environment.UserName, ".config/bspwm/externalRules/rules/", paths[i]);
        writer.WriteLine("Trying " + ruleFile);

        if (!File.Exists(ruleFile))
            continue;

        writer.WriteLine("Found " + ruleFile);

        if (ruleFile.EndsWith(".csx"))
        {
            writer.WriteLine();
            writer.WriteLine($"| Invoking '{ruleFile}'");
            writer.WriteLine("| Following is script output:");
            writer.WriteLine();
            var result = shell.run2(ruleFile, $"{WM_TYPE} {WM_CLASS} {WM_NAME}");
            writer.WriteLine(result);
            writer.WriteLine("| Script output ends here");

            var lines = result.Split(Environment.NewLine);
            for (int c = 0; c < lines.Length; c++)
            {
                var kvp = lines[c].Split('=');
                if (kvp.Length == 2)
                    bspcStream.Flags[kvp[0]] = kvp[1];
            }
            break;
        }
        var file = new ini(ruleFile, preload: true);

        foreach (var section in file.contents)
            if (section.Key == WM_TYPE || string.IsNullOrEmpty(WM_TYPE))
                foreach (var data in section.Value)
                    bspcStream.Flags[data.Key] = data.Value;
        break;
    }

    PrintDebugInfo(Args, WM_CLASS, WM_NAME, WM_TYPE);
    bspcStream.ApplyRulesToStdOut();
    writer.WriteLine("Shutting down");
}
catch (Exception e)
{
    writer.WriteLine(e);
}


void PrintDebugInfo(IList<string> Args, string WM_CLASS, string WM_NAME, string WM_TYPE)
{
    writer.WriteLine();
    writer.WriteLine("###### Debug Info Start");
    writer.WriteLine();

    writer.Write("Args:");
    for (int i = 0; i < Args.Count - 1; i++)
        writer.Write($" {Args[i]}");
    writer.WriteLine();

    writer.WriteLine("WM_TYPE: " + WM_TYPE);
    writer.WriteLine("WM_CLASS: " + WM_CLASS);
    writer.WriteLine("WM_NAME: " + WM_NAME);
    writer.WriteLine();

    writer.WriteLine("Flags:");
    foreach (var flag in bspcStream.Flags/*.Where(flag=>!string.IsNullOrEmpty(flag.Value))*/)
        writer.WriteLine($"{flag.Key}={flag.Value}");
    writer.WriteLine();

    writer.WriteLine("###### Debug Info End");
    writer.WriteLine();
}
