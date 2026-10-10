# Making a change

`change-management-checklist.md` is a before, during, and after list.

- **Before.** Write down what is changing and why. Confirm a recent backup exists that has been tested restorable, not just "a job ran". Identify the rollback path before starting. Check for a maintenance window and silence the alerts the change will trip. Consider blast radius, and try one host first.
- **During.** One change at a time. Capture the exact commands run.
- **After.** Verify the change had the intended effect, not just that the command did not error. Watch for regressions for a while afterward. Re-enable anything silenced. Update documentation the change invalidated. Remove the rollback artifact once confident.
- **If it goes wrong.** Roll back the way you planned. A forward fix invented while something is broken is itself an untested change.

For an access-control change such as MFA or a new SSO policy, add what `opinions/change-management-and-access-control.md` says: design the failure path and the exception route before enforcement, and judge the rollout months later, not on launch day.
