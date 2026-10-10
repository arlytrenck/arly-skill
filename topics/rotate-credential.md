# Rotating a credential

Both rotation runbooks start with an inventory: a secret is rarely in one file. Know how each consumer reloads (a systemd environment variable needs a daemon reload and restart; a container `env_file` needs `up -d`, since a plain `restart` does not re-read it). Prefer rotation with an overlap window: issue the new credential alongside the old, update every consumer, verify each on the new value, confirm the old one has had no use for a full business cycle, then revoke it.
