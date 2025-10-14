// FileCollector
//
// Searches various directory trees on the CMI Media Server,
// and copies target files to the producer's working directory.
// To compile, run the following command:
//
//  dotnet publish -c Release -r win-x64 --self-contained false
//

using System;
using System.IO;
using System.Collections.Generic;

class FileCollector
{
    static void Main(string[] args)
    {
        if (args.Length != 2)
        {
            Console.WriteLine("Usage: FileCollector <input_csv> <search_root>");
            return;
        }

        string csvPath = args[0];
        string searchRoot = args[1];
        string destinationDir = @"C:\AvVol1\CLA";

        if (!File.Exists(csvPath))
        {
            Console.WriteLine($"Error: File list '{csvPath}' not found.");
            return;
        }

        if (!Directory.Exists(destinationDir))
        {
            Directory.CreateDirectory(destinationDir);
        }

        Console.WriteLine($"Reading filenames from: {csvPath}");
        Console.WriteLine($"Searching in: {searchRoot}");
        Console.WriteLine($"Copying to: {destinationDir}");
        Console.WriteLine();

        int copiedCount = 0;
        int notFoundCount = 0;

        foreach (var line in File.ReadLines(csvPath))
        {
            string filename = line.Trim() + ".wav";
            if (string.IsNullOrEmpty(filename)) continue;

            try
            {
                // Search for the file recursively, case-insensitive match
                var matches = Directory.EnumerateFiles(searchRoot, "*", SearchOption.AllDirectories);
                bool found = false;

                foreach (var path in matches)
                {
                    if (string.Equals(Path.GetFileName(path), filename, StringComparison.OrdinalIgnoreCase))
                    {
                        string destPath = Path.Combine(destinationDir, Path.GetFileName(path));
                        File.Copy(path, destPath, overwrite: true);
                        Console.WriteLine($"Copied: {path} -> {destPath}");
                        copiedCount++;
                        found = true;
                        break; // Stop after first match
                    }
                }

                if (!found)
                {
                    Console.WriteLine($"Not found: {filename}");
                    notFoundCount++;
                }
            }
            catch (Exception ex)
            {
                Console.WriteLine($"Error processing {filename}: {ex.Message}");
            }
        }

        Console.WriteLine();
        Console.WriteLine($"Completed. Files copied: {copiedCount}, not found: {notFoundCount}");
    }
}

