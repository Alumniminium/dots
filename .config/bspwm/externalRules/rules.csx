#!/usr/bin/env dotnet-script

#load "bspc.csx"

using System.IO;

public static StreamWriter writer = new StreamWriter("/tmp/extenal_rules.log", true) { AutoFlush = true };

public static bool ApplyRulesForFirst(string WM_CLASS, string WM_NAME, string WM_TYPE)
{
    WM_CLASS = string.Join("_", WM_CLASS.Split(Path.GetInvalidFileNameChars()));
    WM_NAME = string.Join("_", WM_NAME.Split(Path.GetInvalidFileNameChars()));

    var paths = new[]
    {
        Path.Combine(WM_CLASS, $"{WM_NAME}.ini"),
        Path.Combine(WM_CLASS, $"{WM_CLASS}.ini"),
        $"{WM_NAME}.ini",
        $"{WM_CLASS}.ini",
        $"{WM_TYPE}.ini"
    };

    for (int i = 0; i < paths.Length; i++)
        if (LoadFile(paths[i]))
            return true;
    return false;
}

public static bool LoadFile(string filename)
{
    var ignoredPrefixes = new[] { '[', '#', '/' };
    var ruleFile = Path.Combine(Environment.CurrentDirectory, ".config/bspwm/externalRules/rules/", filename);

    writer.WriteLine("Trying " + ruleFile);

    if (File.Exists(ruleFile))
    {
        writer.WriteLine("Found " + ruleFile);

        var lines = File.ReadAllLines(ruleFile);

        foreach (var ignoredChar in ignoredPrefixes)
            lines = lines.Where(l => !l.StartsWith(ignoredChar)).ToArray();

        foreach (var line in lines)
        {
            var kvp = line.Split('=');
            if (kvp.Length == 2)
                Flags[kvp[0]] = kvp[1];
        }
        return true;
    }
    return false;
}

public static void PrintDebugInfo(IList<string> Args, string WM_CLASS, string WM_NAME, string WM_TYPE)
{
    writer.WriteLine();
    writer.WriteLine("###### Debug Info Start");
    writer.Write("Args:");
    for (int i = 0; i < Args.Count - 1; i++)
        writer.Write($" {Args[i]}");

    writer.WriteLine();
    writer.WriteLine("WM_TYPE: " + WM_TYPE);
    writer.WriteLine("WM_CLASS: " + WM_CLASS);
    writer.WriteLine("WM_NAME: " + WM_NAME);
    writer.WriteLine();

    writer.Write("Flags:");
    foreach (var flag in Flags)
        if (!string.IsNullOrEmpty(flag.Value))
            writer.Write($" {flag.Key}={flag.Value}");
    writer.WriteLine();

    writer.WriteLine("###### Debug Info End");
    writer.WriteLine();
}