using System;
using System.IO;
using System.Collections.Generic;

class FileMissingReport
{
    static void Main(string[] args)
    {
        if (args.Length != 2)
        {
            Console.WriteLine("Usage: FileMissingReport <input_list> <search_root>");
            return;
        }

        string listPath = args[0];
        string searchRoot = args[1];

        if (!File.Exists(listPath) || !Directory.Exists(searchRoot)) return;

        // Still using the HashSet because it is the fastest way to handle
        // a massive directory tree on a remote server.
        var existingFiles = new HashSet<string>(StringComparer.OrdinalIgnoreCase);

        // Scan the server ONCE
        foreach (var path in Directory.EnumerateFiles(searchRoot, "*.wav", SearchOption.AllDirectories))
        {
            existingFiles.Add(Path.GetFileName(path));
        }

        // Check your sorted list against the "bucket"
        foreach (var line in File.ReadLines(listPath))
        {
            string targetFile = line.Trim();
            if (string.IsNullOrWhiteSpace(targetFile) || targetFile.StartsWith("//")) continue;

            if (!existingFiles.Contains(targetFile))
            {
                // Just print the filename as requested
                Console.WriteLine(targetFile);
            }
        }
    }
}
