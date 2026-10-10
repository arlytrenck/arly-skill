# Patching

`patch-management-guide.md` uses three rings: a canary host on day 0, the broad fleet a few days later, and the slow-to-recover systems (hypervisor, NAS, the box holding the only copy of something) last, after a soak period. Forty-eight to seventy-two hours catches most "this update breaks X" reports. Container images are a separate patch stream. For a bad patch: establish it is the patch, roll back the specific package and not the whole cycle, hold it and write down why, and boot the previous kernel if the kernel is the problem.
