# Troubleshooting

### One change, two places: verify both

A reverse proxy handing the access decision to a separate service is a two-step change. Caddy's `forward_auth` declares where to ask. Authelia's `access_control` declares what the answer is. Nothing shows both at once, so a correct-looking proxy block can sit in front of a rule that does not exist. The shape generalizes to nginx `auth_request` and Traefik `forwardAuth`. After adding a protected route, read the authorization side's own rule list and find the route by name.
Evidence: https://trenck.net/blog/authelia-two-file-access-control-bug/

### Fixing one instance does not tell you the fix generalized

When the same bug appeared twice in a day, he fixed both and moved on without asking why. Later he found the same gap on three more vhosts. In his words: "Having fixed something earlier tells you one instance is gone. It says nothing about whether the fix generalized." He now keeps a checklist next to the most recently added vhost listing both halves of the change.
Evidence: https://trenck.net/blog/authelia-two-file-access-control-bug/

### Test the way a real user hits it

Testing a protected route means an actual browser that is not already authenticated. `curl` from inside the LAN can pass the real check for an entirely different reason.
Evidence: https://trenck.net/blog/authelia-two-file-access-control-bug/

### Ask the authoritative source

When DNS looks right in every tool except the one failing, query the authoritative nameserver directly, not a public resolver. A resolver returns what it last cached, which is the wrong answer when the origin data never finished publishing. Rule out the obvious suspects first (token scope, a typo, propagation delay), then stop guessing.
Evidence: https://trenck.net/blog/cloudflare-stuck-dns-publish-fix/

### A fix downstream does not restart what is upstream

After correcting the DNS record, Caddy's ACME client was still backing off exponentially from its earlier failures, so fixing DNS did not trigger a retry. A restart cleared the backoff. When you repair a dependency, check whether the consumer is waiting out its own delay.
Evidence: https://trenck.net/blog/cloudflare-stuck-dns-publish-fix/

### Same failure twice earns a runbook entry

The stuck-DNS fix worked twice, months apart, on different subdomains. It went into the runbook: recreate the record, confirm against the authoritative server, restart Caddy. His stated payoff is five minutes next time instead of an afternoon second-guessing a token that was never the problem.
Evidence: https://trenck.net/blog/cloudflare-stuck-dns-publish-fix/

### Check the network layer before blaming the firewall

If a public-facing service works from outside but fails from inside the LAN, check for NAT hairpinning before assuming a firewall or DNS misconfiguration. The fix is a local resolver overriding those specific names to the LAN address, not a change to the service. Arly's practice is AdGuard Home answering with the reverse proxy's internal address, offered network-wide by the router over DHCP, since an opt-in fix only helps devices that were configured. He notes it looks like a dead service from the client side, so the first hour went into proxy logs. Comparing what a client outside the LAN saw against one inside took two minutes. The open gap he states: that one resolver is the only DNS the router offers, so rebooting its VM takes DNS down LAN-wide. A second instance on a separate failure domain is planned, not built, and a public fallback would defeat the local answers.
Evidence: https://trenck.net/blog/nat-hairpin-and-local-dns/ and https://github.com/arlytrenck/homelab-public/blob/main/docs/lessons-learned.md

