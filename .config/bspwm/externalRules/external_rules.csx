#!/usr/bin/env dotnet-script

#load "/home/alu/coding/linux-dotnet-scripts/io/ini.csx"
#load "/home/alu/coding/linux-dotnet-scripts/wrappers/xprop.csx"
#load "/home/alu/coding/linux-dotnet-scripts/wrappers/bspc.csx"

StreamWriter writer = new StreamWriter("/tmp/extenal_rules.log", true) { AutoFlush = true };

writer.WriteLine("Starting up...");

bspc.Flags = bspc.ParseFlags(Args[3]);
var (WM_CLASS, WM_NAME, WM_TYPE) = await xprop.getWindowInfoById(Args[0]);

var paths = new[]
{
    Path.Combine(WM_CLASS, $"{WM_NAME}.ini"),
    Path.Combine(WM_CLASS, $"{WM_CLASS}.ini"),
    $"{WM_NAME}.ini",
    $"{WM_CLASS}.ini",
    $"{WM_TYPE}.ini"
};

for (int i = 0; i < paths.Length; i++)
{
    var ruleFile = Path.Combine("/home",Environment.UserName, ".config/bspwm/externalRules/rules/", paths[i]);
    writer.WriteLine("Trying " + ruleFile);

    if (!File.Exists(ruleFile))
        continue;

    writer.WriteLine("Found " + ruleFile);
    var file = new ini(ruleFile,preload: true);

    foreach (var section in file.contents)
        if(section.Key == WM_TYPE || string.IsNullOrEmpty(WM_TYPE))
            foreach(var data in section.Value)
                bspc.Flags[data.Key] = data.Value;
    break;
}

PrintDebugInfo(Args,WM_CLASS,WM_NAME,WM_TYPE);
bspc.ApplyRulesToStdOut();
writer.WriteLine("Shutting down...");


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
    foreach (var flag in bspc.Flags/*.Where(flag=>!string.IsNullOrEmpty(flag.Value))*/)
        writer.WriteLine($"{flag.Key}={flag.Value}");
    writer.WriteLine();

    writer.WriteLine("###### Debug Info End");
    writer.WriteLine();
}
