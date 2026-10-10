# Something is wrong now

`incident-response-runbook.md` has six phases. Follow them in order, and do not skip straight to fixing.

1. **Assess.** What alerted? Confirm the service is really down or degraded with something independent (`curl`, `systemctl status`, `journalctl -xe`), not one dashboard. One host or the fleet? Note the start time.
2. **Contain.** If it looks like a security incident, isolate the host if the downtime is affordable, do not reboot or wipe it (the running state may be needed), and rotate credentials that may be exposed. If it looks like capacity, check disk, `top`, and `dmesg` for OOM kills, and look for a runaway process or log flooding.
3. **Diagnose.** Start with `systemctl --failed`, `journalctl -p err -b`, `dmesg -T | tail -100`, `df -hP`, `free -h`, `uptime`, `ss -tulpn`. Then application logs. Line up the first symptom's timestamp against recent deploys, config changes, and cron jobs.
4. **Mitigate.** The smallest change that restores service. Write down exactly what you changed.
5. **Verify.** Healthy from a client's point of view, not just a running process. Watch for a few minutes for recurrence. Re-check dependent services.
6. **Document.** Within 24 hours: timeline, root cause, impact, follow-up actions with owners. Blameless. `incident-postmortem-template.md` has the structure.

If the category is unknown, `troubleshooting-flowchart.md` gives the triage order: can you SSH in (if not, network), then CPU load against core count, then memory and swap, then disk near 100 percent, and if none of those, recent changes, then logs. `troubleshooting-guide.md` is the symptom reference.

Two habits from his posts apply while diagnosing. When every tool says the state is fine except the one that is failing, ask the authoritative source (the authoritative nameserver, the authorization side's own rule list), not a cache or a summary. And test the way a real user hits it, since a request from inside the LAN or an authenticated session can pass for a different reason. See `opinions/troubleshooting.md`.
