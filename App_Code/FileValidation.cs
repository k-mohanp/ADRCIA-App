using System;
using System.Collections.Generic;
using System.IO;
using System.Linq;
using System.Text.RegularExpressions;
using System.Web;

/// <summary>
/// Added by AP on March 27, 2024, regarding Ticket #24572 to handle the path traversal issue.
/// Summary description for FileValidation
/// </summary>
public class FiliPathValidation
{

        // Regular expressions for validating path and filename
    private static readonly Regex ValidPathRegex = new Regex("^[^" + Regex.Escape(new string(Path.GetInvalidPathChars())) + "]+$");
    private static readonly Regex ValidFilenameRegex = new Regex("^[^" + Regex.Escape(new string(Path.GetInvalidFileNameChars())) + "]+$");
  

    /// <summary>
    /// Replaces directory separator by Path.DirectorySeparatorChar
    /// </summary>
    public static string WithPlatformSeparators(string path)
    {
        if (Path.DirectorySeparatorChar != '/')
            path = path.Replace('/', Path.DirectorySeparatorChar);
        if (Path.DirectorySeparatorChar != '\\')
            path = path.Replace('\\', Path.DirectorySeparatorChar);
        return path;
    }

    /// <summary>
    /// Replaces directory separator by a StandardDirectorySeparator
    /// </summary>
    public const char StandardDirectorySeparator = '/';
    public static string WithStandardSeparators(string path)
    {
        if (Path.DirectorySeparatorChar != StandardDirectorySeparator)
            path = path.Replace(Path.DirectorySeparatorChar, StandardDirectorySeparator);
        path = path.Replace('\\', StandardDirectorySeparator);
        return path;
    }

    public static bool FolderContainsPath(string folder, string path)
    {
        folder = WithStandardSeparators(Path.GetFullPath(folder)).TrimEnd('/');
        path = WithStandardSeparators(Path.GetFullPath(path)).TrimEnd('/');

        return path.Length >= folder.Length + 1 && path[folder.Length] == '/' && path.StartsWith(folder);
    }

    public static string GetRelativePath(string folder, string path)
    {
        folder = WithStandardSeparators(Path.GetFullPath(folder)).TrimEnd('/');
        path = WithStandardSeparators(Path.GetFullPath(path)).TrimEnd('/');

        if (path.Length < folder.Length + 1 || path[folder.Length] != '/' || !path.StartsWith(folder))
            throw new ArgumentException(path + " isn't contained in " + folder);

        return path.Substring(folder.Length + 1);
    }

    public static bool IsValidPath(string path)
    {
        return ValidPathRegex.IsMatch(path);
    }

    public static bool IsValidFilename(string filename)
    {
        return ValidFilenameRegex.IsMatch(filename);
    }
}