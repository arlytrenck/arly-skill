# Metrics and reporting

### Closure speed measures throughput, not health

Arly thinks a fast-closing ticket queue is a weak headline health number, even though monthly reports tend to treat it as one. A quickly closed ticket can mean the cause was fixed. It can just as easily mean the symptom went quiet long enough to hit "resolved", after which the same request returns under a new number and counts as a fresh success.
Evidence: https://trenck.net/blog/ticket-metrics-measure-activity-not-health/

### Prefer recurrence, and be honest about what it costs

The metric he would use instead is repeat-ticket rate by root cause, one level below the surface category. A downward trend there means the problem stopped. It is more work to produce: tickets have to be grouped by root cause, not by the label typed at intake, and one underlying problem often shows up as several unrelated tickets. Closure time already exists as a column, while recurrence is a project, so reports default to closure time. His clearest example is password and MFA resets: each closes in minutes and looks like a win, yet they were the biggest repeat source until self-service guides and live sessions took most of them away, while the closure number barely moved. He says Freshservice reports now give him the recurrence view without regrouping the queue by hand each month.
Evidence: https://trenck.net/blog/ticket-metrics-measure-activity-not-health/ and https://trenck.net/blog/recurrence-is-the-ticket-metric-i-actually-want/

