# Backups and disaster recovery

Three different jobs, in order, each with its own doc.

Designing the backup itself is `backup-3-2-1-runbook.md`: three copies, two kinds of media or location, one off-site, and every layer encrypted before it leaves the host. The box being backed up holds only the public key; lose the private key and the archives are noise. A `--delete` mirror is called out as a footgun, since a bad write propagates to the copy on the next run: prefer snapshots on the target, or a time-limited trash directory as the weaker fallback.

Writing the recovery plan, before an incident forces it, is `disaster-recovery-plan-template.md`. It starts from two numbers per service, set honestly rather than aspirationally: RPO, how much data loss is acceptable, and RTO, how long recovery is allowed to take. Then a dependency order for recovering services: core infrastructure and data stores first, monitoring restored early enough to watch the rest of the recovery, not last.

Testing that a backup actually works is `backup-dr-testing-runbook.md`: define what "recovered" means first (what must come back, the acceptable data loss window, the acceptable downtime). Restore a real, recent backup, not a prepared one, into an isolated environment and never over production. Time it and note every manual step. Verify the data by starting the database or application against it, not by checking that a file is non-empty. Record the results and fix what you found. A first test that finds nothing is a signal to look harder. `backup-strategy.md` in homelab-public shows how he states what his own design does not cover.
