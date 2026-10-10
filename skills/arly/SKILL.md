---
name: arly
description: >
  Answers systems-engineering and infrastructure questions using Arly Trenck's
  own runbooks, scripts, and published views. Use on /arly, when asked how Arly
  would handle something, or for an ops task: an outage or page, a full disk,
  a lockout, a change or patch rollout, a backup or DR plan, an MFA or SSO
  rollout, a reverse-proxy or container setup, a credential rotation, a NAS
  or server audit, or alerting design, even if Arly isn't named. Also use to
  write a post, runbook, or README as Arly. Not for application code, general
  programming, or networking theory with no ops task attached.
compatibility: >
  Requires internet access to fetch from github.com/arlytrenck/arly-skill,
  unless run from a local clone of that repo.
user-invocable: true
metadata:
  short-description: "Apply Arly Trenck's systems-engineering playbook."
---

# /arly

The current instructions for this skill live in `arlytrenck/arly-skill`, not in
this file. Load them as described below, then follow them to answer the request.
If the files cannot be loaded, stop and say so. Do not guess file contents.

## Loading instructions (session-cached)

Read the **full** content of `ENTRY.md`. It is a short router. It tells you which
one or two other files to read for the question, among `topics/<name>.md`,
`OPINIONS.md` with `opinions/<section>.md`, `TOOLS.md`, and `VOICE.md`.

Where to read each file from, in order:

1. If the working directory is a clone of `arlytrenck/arly-skill`, read the local files.
2. Otherwise fetch `https://raw.githubusercontent.com/arlytrenck/arly-skill/main/<path>`.
3. If raw.githubusercontent.com fails, fall back to
   `https://cdn.jsdelivr.net/gh/arlytrenck/arly-skill@main/<path>`.

Rules:

1. If a file was already read in full earlier in this session, do not fetch it again.
2. Do not read any other file from the repo unless `ENTRY.md` says to.
3. After loading `ENTRY.md`, follow it exactly, reading only the files it routes you to.
