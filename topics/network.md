# Network problem that smells like a service fault

There is no single network runbook in his public material. The triage order lives in `troubleshooting-flowchart.md` (can you SSH in, and if not, network first). The references are `dns-dhcp-reference.md` and `windows-networking-cheatsheet.md` in sysadmin-windows and `networking-cheatsheet.md`, `dns-cheatsheet.md`, and `firewall-cheatsheet.md` in sysadmin-linux. Say so if the user wants a procedure beyond these.

1. **Compare vantage points first.** Same request from outside the network and from inside it. If it works from one and fails from the other, the variable is the network path, not the service. This took two minutes in his case after an hour in proxy logs.
2. **Works outside, times out inside the LAN:** suspect NAT hairpin before the firewall or DNS. The public record resolves to the router's WAN IP, and many routers do not loop that back in.
3. **Fix with local DNS,** not a service change: a local resolver answers those names with the reverse proxy's LAN address. Offer it network-wide from the router over DHCP, since a per-device setting only helps devices that were configured.
4. **State the gap.** One local resolver as the only DNS means rebooting it takes DNS down LAN-wide. A second instance on a separate failure domain is the plan. A public fallback would defeat the local answers.
5. **When every tool says fine except the failing one,** ask the authoritative source (the authoritative nameserver), not a cache. See `opinions/troubleshooting.md`.
6. **Test the way a real user hits it,** not from a host with special access.
