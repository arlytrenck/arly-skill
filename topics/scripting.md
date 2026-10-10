# Scripting and automation

Follow the conventions in `CONTRIBUTING.md` of `sysadmin-linux` and `sysadmin-windows`: a header block with purpose, usage, options, and exit codes; `getopts` and a `-h` option for bash, comment-based help and `-WhatIf` for PowerShell; fail safely by erroring out instead of guessing; put destructive actions behind an explicit flag; run ShellCheck or PSScriptAnalyzer. Check `TOOLS.md` first, since a script for the job may already exist.
