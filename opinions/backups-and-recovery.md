# Backups and recovery

### A backup you have not restored is a belief

Arly's practice is a monthly restore drill that restores a canary set, decrypts the newest database dump, loads it into a throwaway database container, and counts rows. That is a real "does it restore", not "does the file exist". Results are pushed as a notification, and backup freshness is a metric with an alert.
Evidence: https://github.com/arlytrenck/homelab-public/blob/main/docs/backup-strategy.md

### Recovery targets are a budget, not a hope

RPO (how much data loss is acceptable) and RTO (how long recovery is allowed to take) get set honestly, per service, before the backup mechanism is chosen. A 15-minute RTO for a database that takes 45 minutes to restore means the RTO is unrealistic or the restore strategy has to change, not that the number gets rounded up after the fact once reality shows up. He also fixes the order services come back in: core infrastructure and data stores before anything user-facing, and monitoring restored early enough to watch the rest of the recovery, not last.
Evidence: https://github.com/arlytrenck/sysadmin-linux/blob/main/docs/disaster-recovery-plan-template.md

### State what the design does not protect against

His backup doc has a section on the gaps. Two copies in one physical location is not 3-2-1, and a nightly mirror faithfully replicates a deletion or corruption within about a day. He names the missing leg (an off-site target) instead of implying coverage he does not have. Mirrors that delete carry a `--max-delete` circuit breaker and a trash directory.
Evidence: https://github.com/arlytrenck/homelab-public/blob/main/docs/backup-strategy.md

### Sort what the NAS holds before deciding what to back up

Data on a NAS is not one category. A re-acquirable media library can be excluded on purpose, if the exclusion is stated. Family photographs and anything with an unreproducible capture date is the row that matters, usually a small share of the volume: backing up a whole share to protect the photos could mean tens of TB of transfer to save tens of GB. He sets RPO and RTO for that second group separately, and says an RTO timed from a same-building mirror measures the wrong scenario.
Evidence: https://github.com/arlytrenck/homelab-public/blob/main/docs/backup-strategy.md

### Layer backups by what is being protected

Config, databases, secrets, and history each get a mechanism that fits: nightly config sync, dumped-and-encrypted databases with rotation and checksums, encrypted secret bundles, and a versioned repository with retention and an integrity check on every run.
Evidence: https://github.com/arlytrenck/homelab-public/blob/main/docs/backup-strategy.md

