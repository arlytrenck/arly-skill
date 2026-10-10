# Tooling and dependencies

### Stop at the second fork

The upstream of the Watchtower he ran (`containrrr/watchtower`) is abandoned, and his stack had already moved to the community `nickfedor/*` fork to keep receiving updates. Fork-hopping a second time is where he stops and picks a different tool.
Evidence: https://trenck.net/blog/watchtower-to-renovate/

### An update should arrive as a diff, a CI run, and a changelog

A phone notification that an image tag moved says nothing about what changed, does not check that the new version starts, and leaves no record. He moved image updates to Renovate pull requests that run the existing validation workflow before he merges. Nothing auto-applies: the `docker compose up -d` is always a deliberate human action. The CI that gates those PRs is held to the same bar: third-party GitHub Actions are pinned to a commit SHA with the version in a comment, and Renovate bumps the pins, since a repo meant to show a hardened setup should not leave its own CI supply chain on mutable tags.
Evidence: https://trenck.net/blog/watchtower-to-renovate/ and https://github.com/arlytrenck/homelab-public/blob/main/CHANGELOG.md

### Let the grouping encode the judgment calls

Rolling `:latest` tags are digest-pinned and batched into one weekly PR, since they have no changelog to read. Version-tagged images get their own PR with the changelog attached. Components that must stay in lockstep move as a group. Authelia, Vaultwarden, and major versions of Postgres and Valkey are flagged individually for a manual release-notes read, because taking those updates is a decision about data formats or auth behavior. Version bumps stay manual for good. Auto-merge is planned only for digest-only bumps, after a few clean weeks.
Evidence: https://trenck.net/blog/watchtower-to-renovate/

### Document the exceptions

What Renovate does not manage (anything in `.env`, so Immich's version) is a documented exception, not a gap. A PR nobody merges without reading the notes is just noise. The older registry-digest script stays as an out-of-band check on what the primary tracker misses.
Evidence: https://trenck.net/blog/watchtower-to-renovate/

### Do not add a second tool if the first already does the job

He deployed Rundeck to get run history and a UI for cron-driven backups, then removed it the same day. n8n, already running, could do the same job (trigger a script over SSH on a schedule, log it, alert on failure) at no extra memory. Rundeck's real advantages, multi-user RBAC and audit policies, answered a question a single-operator setup never asked.
Evidence: https://github.com/arlytrenck/homelab-public/blob/main/docs/lessons-learned.md

### Write the rollback triggers before starting, and be willing to cancel

For a planned Emby to Jellyfin move, Arly wrote down rollback triggers in advance so he could not talk himself into or out of them later, and made the risky part (each user's watch state) a gated step with a read-only diff and a 99 percent bar. Emby stayed untouched until the last phase. In October he decided to stay on Emby and cancelled the cutover because the migration cost outweighed the benefit, and he left the plan post up as written with the update on top. The reasons to leave had been small (closed code, a license tied to one server, a stack leaning toward Jellyfin), not a failure.
Evidence: https://trenck.net/blog/emby-to-jellyfin-migration-plan/

