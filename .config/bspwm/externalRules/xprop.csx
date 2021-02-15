#!/usr/bin/env dotnet-script

#r "nuget: CliWrap, 3.3.0"

using CliWrap;
using CliWrap.Buffered;

public static async Task<(string WM_CLASS, string WM_NAME, string WM_WINDOW_TYPE)> DoMagic(string windowId)
{
    var cmd = await Cli.Wrap("xprop")
                    .WithArguments($"-id {windowId} _NET_WM_WINDOW_TYPE WM_NAME WM_CLASS")
                    .WithValidation(CommandResultValidation.None)
                    .ExecuteBufferedAsync();

    var lines = cmd.StandardOutput.Split(Environment.NewLine);
    var WM_WINDOW_TYPE = ParseType(lines).ToUpperInvariant();
    var WM_NAME = ParseName(lines).ToLowerInvariant();
    var WM_CLASS = ParseClass(lines).ToLowerInvariant();

    return (WM_CLASS,WM_NAME,WM_WINDOW_TYPE);
}
static string ParseName(string[] lines)
{
    if (lines[1].Contains("="))
        return lines[1].Split('=', StringSplitOptions.RemoveEmptyEntries)[1].Replace("\"", "").Trim();
    return string.Empty;
}

static string ParseClass(string[] lines)
{
    if (lines[2].Contains("="))
    {
        var parts = lines[2].Split('=', StringSplitOptions.RemoveEmptyEntries);
        var wanted = parts[1].Replace("\"", "").Trim();
        var classes = wanted.Split(',', StringSplitOptions.RemoveEmptyEntries);
        
        var longest="";
        for(int i =0;i<classes.Length;i++)
        {
            var c = classes[i];
            if(c.Length > longest.Length)
                longest=c;
        }
        longest = longest.Replace("\"", "").Trim();
        return longest.ToLowerInvariant();
    }
    return string.Empty;
}

static string ParseType(string[] lines)
{
    string type = string.Empty;
    if (lines[0].Contains("="))
        type = lines[0].Split('=', StringSplitOptions.RemoveEmptyEntries)[1].Replace("\"", "").Trim();
    return type;
}