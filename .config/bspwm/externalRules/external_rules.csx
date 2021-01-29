#!/usr/bin/env dotnet-script

#r "nuget: CliWrap, 3.3.0"
using System.IO;
using CliWrap;
using CliWrap.Buffered;

Dictionary<string, string> Flags = new Dictionary<string, string>();

var writer = new StreamWriter("/tmp/extenal_rules.log", true);
writer.AutoFlush = true;
var cmd = await Cli.Wrap("xprop")
                   .WithArguments($"-id {Args[0]} _NET_WM_WINDOW_TYPE WM_NAME")
                   .WithValidation(CommandResultValidation.None)
                   .ExecuteBufferedAsync();

var lines = cmd.StandardOutput.Split(Environment.NewLine);

var name = ParseName(lines, Args[1]);
var type = ParseType(lines);
Flags = ParseFlags(Args[3]);

PrintDebugInfo(cmd, name, type);
ApplyRules(name, type);
ApplyChanges();


async void ApplyRules(string name, string type)
{
    if (type == "_NET_WM_WINDOW_TYPE_DIALOG")
    {
        Floating();
        Centered();
    }
    if (Args[1] == "Termite")
    {
        writer.WriteLine($"Foodoododo");

        var cmd = await Cli.Wrap("bspc")
                   .WithArguments($"query -N -d")
                   .WithValidation(CommandResultValidation.None)
                   .ExecuteBufferedAsync();
        var lines = cmd.StandardOutput.Split(Environment.NewLine, StringSplitOptions.RemoveEmptyEntries);
        writer.WriteLine($"Lines: {lines.Length}");
        if (lines.Length < 2)
        {
            Centered();
            Floating();
            Size(1280, 1024, 0, 0);
        }
    }
    if (Args[1] == "Surf")
    {
        Tiled();
        SplitRatio(0.6f);
        SplitDirection("east");
    }
    if (Args[1] == "Steam")
    {
        if (name == "Steam")
            Tiled();
        if (name == "Friends List")
        {
            Tiled();
            SplitRatio(0.85f);
        }
        if (name == "Settings" || name == "Product Activation" || name == "Add a Game" || name == "About Steam")
        {
            Floating();
            Centered();
            SizeInverted(600, 400, 0, 200);
        }
    }
    if (string.IsNullOrEmpty(Args[1]))
    {
        if (name == "Task Manager - Chromium")
        {
            Floating();
            Centered();
            Size(600, 400);
        }
    }
}
void Floating(bool val = true) => Flags["state"] = val ? "floating" : "tiled";
void Tiled(bool val = true) => Flags["state"] = val ? "tiled" : "floating";
void Centered(bool val = true) => Flags["center"] = val.ToString();
void SplitRatio(float ratio) => Flags["split_ratio"] = ratio.ToString();
void SplitDirection(string direction) => Flags["split_dir"] = direction;
void Size(int w, int h, int x = 0, int y = 0) => Flags["rectangle"] = $"{w}x{h}+{x}+{y}";
void SizeInverted(int w, int h, int x = 0, int y = 0) => Flags["rectangle"] = $"{w}x{h}-{x}-{y}";

string ParseName(string[] lines, string defaultVal)
{
    if (lines[1].Contains("="))
        defaultVal = lines[1].Split('=', StringSplitOptions.RemoveEmptyEntries)[1].Replace("\"", "").Trim();
    return defaultVal;
}

string ParseType(string[] lines)
{
    string type = string.Empty;
    if (lines[0].Contains("="))
        type = lines[0].Split('=', StringSplitOptions.RemoveEmptyEntries)[1].Replace("\"", "").Trim();
    return type;
}

Dictionary<string, string> ParseFlags(string line)
{
    var pairs = line.Split(' ', StringSplitOptions.TrimEntries);
    var flags = new Dictionary<string, string>();

    foreach (var pair in pairs)
    {
        var kvp = pair.Split('=', StringSplitOptions.RemoveEmptyEntries);
        if (kvp.Length == 2)
            flags.Add(kvp[0], kvp[1]);
        else
            flags.Add(kvp[0], string.Empty);
    }
    return flags;
}


void ApplyChanges()
{
    var stdo = string.Empty;
    foreach (var flag in Flags)
        stdo += $"{flag.Key}={flag.Value} ";

    stdo.Trim();

    Console.WriteLine(stdo);
}

void PrintDebugInfo(BufferedCommandResult cmd, string name, string type)
{
    writer.WriteLine();
    writer.WriteLine("######");
    writer.WriteLine();
    for (int i = 0; i < Args.Count - 1; i++)
        writer.WriteLine($"Arg {i}: {Args[i]}");
    writer.WriteLine();

    foreach (var flag in Flags)
        writer.WriteLine("Flag: " + flag.Key + "=" + flag.Value);
    writer.WriteLine();

    writer.WriteLine("xprop stdo:");
    writer.WriteLine(cmd.StandardOutput.Trim());
    writer.WriteLine();
    writer.WriteLine("Type: " + type);
    writer.WriteLine("Name: " + name);
}