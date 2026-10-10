# Adding a service or a hostname

`add-a-service.md` walks a container from compose to verified: compose with the shared hardening anchor, secrets in an untracked env file, reverse proxy and auth, dashboard, monitoring, backups, documentation, and an end-to-end check. `add-a-vhost.md` covers DNS, the proxy block, and the authorization rule in the auth provider. That last step is the one that gets skipped: a forward-auth block only tells the proxy to ask, and the provider's default is deny. In the end-to-end check, a 403 means the authorization rule is missing, 000 means DNS or the certificate is not ready, and 502 means the proxy is up with the wrong backend port.

Before adding a new tool at all, check whether something already running does the job, and check the project's upstream is maintained. See `opinions/tooling-and-dependencies.md`.
