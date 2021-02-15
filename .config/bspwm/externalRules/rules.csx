#!/usr/bin/env dotnet-script

#load "bspc.csx"

using System.IO;

public static StreamWriter writer = new StreamWriter("/tmp/extenal_rules.log", true) { AutoFlush = true };

public static void DialogRules()
{
    Floating = true;
    Centered = false;
    Centered = true;
}

public static void SteamRules(string WM_NAME)
{
    switch (WM_NAME)
    {
        case "Friends List":
            SelectBiggestNode();
            SplitRatio = 0.85f;
            break;
        case "Settings":
        case "Product Activation":
        case "Add a Game":
        case "About Steam":
            Floating = true;
            Centered = true;
            SizeInverted(500, 300, 0, 250);
            break;
        default:
            Tiled = true;
            break;
    }
}


public static void ApplyRulesForFirst(params string[] arr)
{
    for (int i = 0; i < arr.Length; i++)
    {
        var name = arr[i];
        if(string.IsNullOrEmpty(name))
            continue;

        var ruleFile = ".config/bspwm/externalRules/rules/" + name + ".ini";
        writer.WriteLine("Trying "+ruleFile);

        if (File.Exists(ruleFile))
        {
            writer.WriteLine("Found "+ruleFile);
        
            var lines = File.ReadAllLines(ruleFile);
            foreach (var line in lines)
            {
                if (line.StartsWith('[') || line.StartsWith('#'))
                    continue;
        
                var kvp = line.Split('=');
                if (kvp.Length == 2)
                    Flags[kvp[0]] = kvp[1];
            }
        }
    }
}


public static void PrintDebugInfo(string[] Args, string WM_CLASS, string name, string type)
{
    writer.WriteLine();
    writer.WriteLine("######");
    writer.WriteLine();
    for (int i = 0; i < Args.Length; i++)
        writer.WriteLine($"Arg {i}: {Args[i]}");
    writer.WriteLine();

    foreach (var flag in Flags)
        writer.WriteLine("Flag: " + flag.Key + "=" + flag.Value);
    writer.WriteLine();
    writer.WriteLine("Type: " + type);
    writer.WriteLine("WM_CLASS: " + WM_CLASS);
    writer.WriteLine("Name: " + name);
}