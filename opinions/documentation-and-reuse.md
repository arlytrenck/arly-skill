# Documentation and reuse

### Scripts get read before they get run

His scripts are built to be read: each documents its own options, and the PowerShell ones carry comment-based help and `-WhatIf`. Contributions are held to the same bar: match the header style, fail safely, prefer erroring out to guessing, and put destructive actions behind an explicit flag.
Evidence: https://github.com/arlytrenck/sysadmin-linux#why-this-repo-exists and https://github.com/arlytrenck/sysadmin-linux/blob/main/CONTRIBUTING.md

### Keep the explanation inside the thing it explains

Arly thinks a separate notes document goes stale because nothing forces it to change when the script does. What stays accurate is the header and comments in the script itself: what it does, why a flag is set that way, what broke the last time someone tried the obvious alternative. Editing code while leaving the explanation beside it untouched feels wrong in a way that ignoring a wiki page never does. His example is `backup-rotate.sh`, whose comments read like a small incident log: an unvalidated `-k` once made the prune find nothing yet print "Nothing to prune" and exit 0, so retention quietly stopped. Anyone tempted to simplify the code can see what the simpler version cost. This covers operational detail, not architecture: diagrams and why a system exists still need their own writing. His test: if he cannot tell what a script does and why from the script itself six months later, the gap is in the script.
Evidence: https://trenck.net/blog/the-best-documentation-you-never-have-to-read/ and https://trenck.net/blog/my-best-documentation-lives-in-the-scripts/

### The docs get opened more than the scripts get run

Most days the work is a command whose shape is familiar but not the exact flags, so cheatsheets are used more than any single script. Docs favor concrete commands over abstract advice, and state their assumptions (privileges, package manager).
Evidence: https://github.com/arlytrenck/sysadmin-linux#why-this-repo-exists

### Parameterize, then publish

The step that makes a script reusable across a few hosts (parameterizing paths, thresholds, package manager) is most of the work to make it reusable by others, so he publishes instead of keeping it private. Vendor-specific tooling is out of scope, because it mostly helps people already paying that vendor. Split the toolkit by platform, not by task, so generalizing stays cheap and each repo needs one shell and one linter.
Evidence: https://github.com/arlytrenck/sysadmin-linux#why-this-repo-exists

### Write for whoever hits the problem next

His blog skips getting-started material, since good writing already exists, and covers what comes after: what you set up correctly a year ago that breaks in a way the logs do not explain, or the tool that was right when chosen and stopped being right without saying so. He writes while still in the middle of something, so posts read as notes. Some are narrow enough to be a note to himself.
Evidence: https://trenck.net/blog/welcome-to-the-blog/

