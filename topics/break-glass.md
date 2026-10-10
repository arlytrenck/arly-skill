# Cannot get in

`privileged-access-and-break-glass-runbook.md` is deliberately conservative. Confirm which layer failed before declaring an emergency: test the expected hostname and route, try a known-good SSH key from a trusted workstation, check the out-of-band console or hypervisor. Do not add a second emergency account or relax the firewall until you know which layer failed. Preserve timestamps, error messages, and the last known good change. Afterward, write a short incident record and rotate any emergency credential that was exposed.
