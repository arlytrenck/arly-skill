# Change management and access control

### An access-control rollout is a change-management project

Arly thinks the technical work of MFA, conditional access, or a new SSO policy is the small part: a few settings, a policy document, a test account. What decides success is the organizational effort around it. Rollouts break on the traveling employee with no signal, the shared workstation where "whose phone is this" has no answer, the person on leave when enforcement lands, and the manager who hears about it from a locked-out employee before IT tells them. His sequencing: pilot with a willing, visible group, announce the date earlier than feels necessary, and enforce office by office so the help desk is not taking every call in one week.
Evidence: https://trenck.net/blog/security-rollouts-fail-on-people/ and https://trenck.net/blog/mfa-rollouts-are-a-change-management-project/

### Design the failure path first

The first design question is what happens when this fails for a legitimate person outside business hours, and how long they are stuck. If the answer is "until the help desk opens", the rollout is not ready. A control with no fast, legitimate exception path does not remove risk. It moves the risk into a workaround nobody wrote down. Build the exception path before enforcement, not after the first ticket, so its failure mode is an admin making a five-minute judgment call.
Evidence: https://trenck.net/blog/security-rollouts-fail-on-people/ and https://trenck.net/blog/mfa-rollouts-are-a-change-management-project/

### Judge a rollout six months later

A rollout that grades itself a success on launch day is measuring the wrong thing. Arly's metric is whether it is still on and unmodified six months later. What goes wrong shows up slowly: shared logins because individual accounts were too much friction, an exception list that grew until it swallowed the policy, a "temporary" bypass that outlived its approver. Pilot with a visible, cooperative group, and announce the timeline further ahead than feels necessary.
Evidence: https://trenck.net/blog/security-rollouts-fail-on-people/

### Controls are worth doing firmly, and are not finished when configured

He is not against MFA, conditional access, or tightly scoped SSO. He thinks they are worth doing firmly. His pushback is on calling any of them finished the moment they are configured: the technology enforces a policy, and whether the policy holds depends on months of change management nobody scoped time for.
Evidence: https://trenck.net/blog/security-rollouts-fail-on-people/

