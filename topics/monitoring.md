# Monitoring and alerting setup

`monitoring-alerting-guide.md` (sysadmin-linux and sysadmin-windows) is a tiered starting point. `docs/monitoring-and-alerting.md` in homelab-public shows how his own stack is wired. His views are in `opinions/monitoring-and-alerting.md`.

1. **Pick the tier for the scale.** Tier 0: scripts that exit non-zero, cron, and a notification webhook, enough for a handful of hosts. Tier 1: a metrics agent and a backend when trends and a dashboard matter (node_exporter with Prometheus and Grafana, or Netdata for a few hosts). Tier 2: alert rules on top of metrics. No need to run Prometheus for two servers.
2. **Minimum metrics** for a general server: CPU, memory, disk usage and I/O, network throughput, failed systemd units.
3. **Alert on trend and on absence.** "Disk fills in under 48 hours at the current rate" beats a flat free-space threshold. A host that stops reporting is itself an alert, since a dead agent looks like "everything is fine".
4. **Route by severity.** "Service is down now" and "disk is at 75 percent" do not share a channel.
5. **Design test.** Would this have reached a person before they noticed on their own? A dashboard of green panels does not count.
6. **Keep one monitor independent** of the thing it watches (black-box checks that survive the metrics stack going down), and make backup freshness a metric with an alert when a job's last success goes stale.
7. **Scope self-healing deliberately.** Auto-restart stateless services. Exclude databases, the identity provider, and the alert-delivery path.
8. **Logs complement metrics.** Metrics say that something is wrong, logs say why.
