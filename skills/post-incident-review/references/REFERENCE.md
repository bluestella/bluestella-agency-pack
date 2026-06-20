# Post-Incident Review — Reference Guide

## Blameless Review Principles

A blameless PIR focuses on systems, processes, and controls — not individual people. Reasons:
- People make mistakes; everyone does. Blame doesn't prevent recurrence; better systems do.
- People act with good intent. They didn't try to break production.
- Fear of blame hides issues. Psychological safety enables learning.
- Incidents are caused by chains of events, rarely one person's error.

**Instead of:** "Alice wrote bad code."
**Ask:** "How could code review, testing, or monitoring have caught this?"

## The 5 Whys Technique

Iteratively ask "Why?" until you reach the root cause (usually 4–6 levels deep):

1. Why did the service go down? → Database connections exhausted.
2. Why were connections exhausted? → Transaction service leaked connections on error.
3. Why did the code leak connections? → Developer used try-catch instead of try-finally.
4. Why wasn't this caught in review? → Reviewer didn't check error handling paths.
5. Why didn't tests catch it? → No integration test for DB error scenarios.

Root cause: no test coverage for DB error paths + no code review checklist for connection handling.

## Action Item Prioritization

| Priority | Timeframe    | Criteria                                              |
| -------- | ------------ | ----------------------------------------------------- |
| P0       | This week    | Prevents same incident immediately; high-risk gap     |
| P1       | This sprint  | Significantly reduces recurrence risk                 |
| P2       | This quarter | Reduces related risks; process improvements           |

Each action item must have: specific action (not vague), named owner, target date, verifiable completion criteria.

## Common Incident Patterns

| Pattern                        | Root Cause Category        | Common Fix                                     |
| ------------------------------ | -------------------------- | ---------------------------------------------- |
| Connection pool exhaustion     | Resource leak              | Try-finally, connection pool monitoring        |
| Config error in production     | No staging validation      | Config schema validation + staging parity      |
| Cascading failure              | No circuit breaker         | Circuit breaker pattern, timeout, bulkhead     |
| Missing monitoring alert       | Observability gap          | Add alert before next deploy                   |
| Friday 5 PM deploy failure     | Process gap                | Deploy freeze policy                           |
| Test covered happy path only   | Test coverage gap          | Require error scenario tests in PR checklist   |

## SLA Definitions (Common Reference)

| Severity | SLA Target | Escalation If Unresolved |
| -------- | ---------- | ------------------------ |
| Critical | < 1 hour   | PM + On-call commander after 30 min |
| High     | < 4 hours  | Tech Lead after 2 hours |
| Medium   | < 24 hours | Tech Lead after 12 hours |
| Low      | < 1 week   | Sprint planning |

## External References

- [Google SRE Book — Postmortem Culture](https://sre.google/sre-book/postmortem-culture/)
- [PagerDuty Incident Response](https://response.pagerduty.com/)
- [Etsy Blameless Postmortems](https://www.etsy.com/codeascraft/blameless-postmortems/)
- [Incident.io — Post-Incident Workflow](https://incident.io/)
