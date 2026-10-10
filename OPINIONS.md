# OPINIONS.md

A compact map of Arly Trenck's viewpoints, taken only from what he has published: his blog at trenck.net, the READMEs and docs in his public repos, and his GitHub profile. It is written for use as LLM context, so repeated points are consolidated and evidence links are kept to one or two per entry.

Where an entry says "Arly's practice", it is describing what he does on his own systems. Where it says "Arly thinks", it is a stated view. Do not present either as more than that.

_Last updated: 2026-10-07_
_Sources: 17 published blog posts (2026-09-08 through 2026-10-07), `homelab-public` docs, `sysadmin-linux` and `sysadmin-windows` READMEs, CONTRIBUTING, and `docs/`, the profile README._

## Index

Read only the section file the question needs. Each entry below is a held view, linked to the file that has the reasoning and evidence.

### Monitoring and alerting

`opinions/monitoring-and-alerting.md`

- Monitoring is only real if it reaches a person
- Alert on a handful of things you trust
- Keep one monitor independent of the thing it watches
- A feature meant for resilience can create the failure it exists to catch
- Scope self-healing deliberately
- Detect first, then block, and alert on the watcher
- Automation that only reads is safe to run everywhere

### Metrics and reporting

`opinions/metrics-and-reporting.md`

- Closure speed measures throughput, not health
- Prefer recurrence, and be honest about what it costs

### Change management and access control

`opinions/change-management-and-access-control.md`

- An access-control rollout is a change-management project
- Design the failure path first
- Judge a rollout six months later
- Controls are worth doing firmly, and are not finished when configured

### Defaults, hardening, and secrets

`opinions/defaults-hardening-and-secrets.md`

- The default is the thing to go check
- Audit the interface nobody monitors
- One baseline on every service
- Secrets stay out of tracked files, and out of scratch files

### Troubleshooting

`opinions/troubleshooting.md`

- One change, two places: verify both
- Fixing one instance does not tell you the fix generalized
- Test the way a real user hits it
- Ask the authoritative source
- A fix downstream does not restart what is upstream
- Same failure twice earns a runbook entry
- Check the network layer before blaming the firewall

### Tooling and dependencies

`opinions/tooling-and-dependencies.md`

- Stop at the second fork
- An update should arrive as a diff, a CI run, and a changelog
- Let the grouping encode the judgment calls
- Document the exceptions
- Do not add a second tool if the first already does the job
- Write the rollback triggers before starting, and be willing to cancel

### Backups and recovery

`opinions/backups-and-recovery.md`

- A backup you have not restored is a belief
- Recovery targets are a budget, not a hope
- State what the design does not protect against
- Sort what the NAS holds before deciding what to back up
- Layer backups by what is being protected

### Documentation and reuse

`opinions/documentation-and-reuse.md`

- Scripts get read before they get run
- Keep the explanation inside the thing it explains
- The docs get opened more than the scripts get run
- Parameterize, then publish
- Write for whoever hits the problem next

### Practice and craft

`opinions/practice-and-craft.md`

- Run the homelab like production
- Fixed limits are the point
- Say when it is an opinion
