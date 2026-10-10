# Defaults, hardening, and secrets

### The default is the thing to go check

Two lessons from his own systems point the same way. Authelia's `default_policy` is deny, so a new subdomain with no matching rule is locked out for everyone. Container ports default to `0.0.0.0`, and a media-library manager's VNC port (5900) sat unauthenticated on `0.0.0.0`, reachable from the LAN, until an audit caught it. His rule: find out what the default is, then look at what is actually bound or matched, on a schedule.
Evidence: https://trenck.net/blog/authelia-two-file-access-control-bug/ and https://github.com/arlytrenck/homelab-public/blob/main/docs/lessons-learned.md

### Audit the interface nobody monitors

Arly's practice: he went through his server's baseboard management controller end to end after it had run for years on day-one settings. It had legacy protocols on that he had never deliberately used (IPMI-over-LAN, SLP, SSDP, CIM-over-HTTPS) and stray RDP and VNC port forwards. He turned the protocols off, removed the forwards, enabled audit logging and set a password-expiration policy. Expect that enabling expiration counts the current password's age retroactively, so plan the change first. He thinks the BMC stays unaudited because it sits outside the monitoring the OS gets and is never what he is thinking about.
The remaining risk was network placement, not settings: it sat on the flat LAN, which took a network redesign. As of October 7 it is on a management VLAN, and the certificate is still self-signed, which he says plainly.
Evidence: https://trenck.net/blog/bmc-hardening-the-forgotten-interface/

### One baseline on every service

Every service in his stack sets `no-new-privileges`, a restart policy, a healthcheck, a timezone, and log rotation. Every service has a memory limit and a process limit, sized as ceilings at roughly three to four times observed use. Ports publish on `127.0.0.1` behind a reverse proxy, or on a specific LAN address, never `0.0.0.0`. Databases get a long stop grace period so they checkpoint cleanly. A service that skips part of the baseline carries a comment saying why (a distroless image with no shell for a healthcheck, the alert path kept off auto-restart), and a service that drifts from it without one is treated as a bug.
Evidence: https://github.com/arlytrenck/homelab-public#conventions

### Secrets stay out of tracked files, and out of scratch files

Secrets never live in a compose file or any tracked file. Each stack reads an untracked env file with restrictive permissions, and documents every key, without values, in an `.env.example`. He also counts untracked plaintext as a problem: two credential files left on disk as quick notes-to-self were found in an audit. If you write a password down during setup, move it to a password manager and delete the scratch file.
Evidence: https://github.com/arlytrenck/homelab-public/blob/main/docs/lessons-learned.md

