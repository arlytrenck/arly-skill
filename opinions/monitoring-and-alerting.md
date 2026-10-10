# Monitoring and alerting

### Monitoring is only real if it reaches a person

Arly thinks the test of whether a system is monitored is "would I find out about a real problem without going looking for it", not "can I query this metric". A dashboard full of green panels is a museum: somebody still has to walk through it. Removing that somebody is most of what monitoring is for.
He does not think this is a homelab-scale problem. A well-instrumented enterprise system with no alerting on the metrics that matter is discovered down the same way an unmonitored one is, by someone noticing the service is gone.
The bar he holds his own systems to: would this have reached my phone before I noticed on my own. He admits he has not finished answering that for two of his own systems.
Evidence: https://trenck.net/blog/monitoring-without-alerting-is-a-museum/

### Alert on a handful of things you trust

Alerting on everything is the opposite mistake. It buries real signal until dismissing notifications becomes a reflex, and an alert nobody trusts does the same work as no alert. He treats "what deserves to page someone" as a design decision, and prefers a handful of alerts he trusts completely over a hundred he has learned to ignore.
Evidence: https://trenck.net/blog/monitoring-without-alerting-is-a-museum/

### Keep one monitor independent of the thing it watches

In his stack, Uptime Kuma is deliberately separate from Prometheus, so black-box checks keep working when Prometheus is down. Backup freshness is a metric, with an alert when any job's last success goes stale, so a job that quietly stopped is visible.
Evidence: https://github.com/arlytrenck/homelab-public/blob/main/docs/monitoring-and-alerting.md

### A feature meant for resilience can create the failure it exists to catch

Alertmanager's gossip clustering, left on with a single instance, wedged the dispatcher after failed deliveries and silently stopped all alerts until a restart. His summary: a gossip cluster with no peer is a single point of failure wearing an HA feature's name. Check what a default is actually doing for your topology.
Evidence: https://github.com/arlytrenck/homelab-public/blob/main/docs/lessons-learned.md

### Scope self-healing deliberately

Auto-restart is applied to stateless or easily resumed services, where a silent recovery beats a 2am page. Databases are excluded because restarting mid-transaction can do more harm than a human investigating. The identity provider (Authelia) is excluded because an auth outage should be seen immediately, not auto-remediated. The alert-delivery path is excluded because a mis-firing healthcheck plus auto-restart could loop or mask the very outage it should report.
Evidence: https://github.com/arlytrenck/homelab-public/blob/main/docs/hardening-conventions.md

### Detect first, then block, and alert on the watcher

Arly's practice with CrowdSec on the public Caddy vhosts: run the engine with no bouncer for a week, so it parses logs and raises alerts but touches no traffic. A ban on a public service can lock out the one person who needs in, himself included, so the design starts with a never-ban list (LAN, tailnet, Docker bridges, loopback) and has Caddy judge the real client address behind Cloudflare, not Cloudflare's edge. Detection data is how he finds false positives without anyone getting a 403 from a guess. The bouncer went live on October 4 after a week of clean detection.
The watcher gets its own alerts: one if the engine stops answering, one if it is up but has read no log lines for a day, which is the quiet failure of a broken log block or a stale rotated file. He fails open once a bouncer exists, and says that makes the down alert matter more: fail-open without an alert is a switch that turns itself off. He lists the unlogged apex site as a known gap.
Evidence: https://trenck.net/blog/crowdsec-detection-only-on-caddy/

### Automation that only reads is safe to run everywhere

Arly thinks most automation should be unable to change anything: read state, compare it to expectation, send a message. Its worst bug is a wrong notification, so it can run every twenty minutes, unattended, with broad visibility and no test environment, and adding one costs no thought about misfires. Detection and remediation carry different risk, and bundling them makes the safe half inherit the risky half's blast radius. Read-only intent also needs scoped credentials: a dedicated key per job, and an ordinary user where root is not needed.
He lets automation act only when the action is narrow, pre-decided, and what a person would do anyway (autoheal restarting a container unhealthy for several minutes, Renovate opening a pull request). He avoids anything shaped like "detect a class of problem and apply whatever fix seems appropriate", because that makes a judgment call at 3am with no reviewer.
Evidence: https://trenck.net/blog/most-of-my-automation-cant-change-anything/

