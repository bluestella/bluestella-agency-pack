---
name: post-incident-review
description: Conducts structured post-incident reviews documenting what happened, root cause analysis, lessons learned, and action items to prevent future occurrences. Includes blameless review principles and follow-up accountability. WHEN: After an incident, production outage, security breach, data loss, critical bug, performing incident retrospective.
---

# Post-Incident Review Skill — Learning from Incidents

## Overview

A **Post-Incident Review (PIR)** (also called Post-Mortem or Incident Retrospective) is a blameless investigation into what happened during an incident, why it happened, and how to prevent it next time. This skill helps DevOps, SRE, and Tech Lead teams conduct structured reviews that improve reliability.

## When to Use This Skill

- **Scenario 1:** Database went down for 30 minutes, users couldn't log in
- **Scenario 2:** Security breach: SQL injection vulnerability discovered and exploited
- **Scenario 3:** Data loss: accidental delete query affected 1,000 user records
- **Scenario 4:** Performance degradation: website slow for 2 hours during peak traffic
- **Scenario 5:** Deployment failure: bad config pushed to production

---

## Post-Incident Review Template

```markdown
# Post-Incident Review: [Incident Title]

**Date:** 2026-06-20  
**Duration:** 09:30 UTC to 10:15 UTC (45 minutes)  
**Severity:** Critical | High | Medium | Low  
**Status:** Resolved | Ongoing Monitoring

---

## Executive Summary

[1-2 paragraphs: What happened? What was the impact? How was it resolved?]

**Example:**
"On 2026-06-20 at 09:30 UTC, the payment processing service became unavailable due to a database connection pool exhaustion. Users were unable to complete purchases for 45 minutes. The issue was caused by a code change in the transaction service that didn't close database connections properly. We recovered by rolling back the deployment. No data loss occurred. All users were able to complete transactions within 10 minutes post-recovery."

---

## Timeline

[Detailed, minute-by-minute account of what happened]

| Time (UTC) | Event | Owner | Note |
| ---------- | ----- | ----- | ---- |
| 09:30 | Payment service becomes unresponsive | [Monitor alert] | Threshold: response time > 5 seconds |
| 09:32 | On-call engineer (Alice) pages incident commander (Bob) | Alice | Slack: #incidents |
| 09:35 | Incident declared and #incident-war-room Slack created | Bob | Severity: Critical |
| 09:37 | Database team investigates connection pool | Carol | Finds pool exhausted (max 100, used 100) |
| 09:40 | Root cause identified: transaction service change | Dev team | Code review of yesterday's PR |
| 09:42 | Rollback initiated | DevOps | Deployment takes 3 minutes |
| 09:45 | Service recovered (traffic processing normally) | [Monitor alert] | Response time back to < 100ms |
| 10:00 | All queries processed, no backlog remains | Bob | Recovery confirmed |
| 10:15 | Post-incident review scheduled | Bob | Tomorrow at 10:00 AM |

---

## Impact Assessment

[How many users affected? How much revenue lost? Data integrity?]

### Scope

- **Service(s) Affected:** Payment service, checkout flow
- **Users Affected:** ~5% of daily active users (those attempting to purchase during outage)
- **Duration:** 45 minutes (09:30 - 10:15 UTC)
- **Geographic Impact:** Global (all regions)

### Business Impact

| Metric | Value | Impact |
| ------ | ----- | ------ |
| Estimated transactions lost | ~2,000 | $50,000 revenue impact |
| SLA breach? | Yes | 45 min > 30 min SLA |
| Data loss? | No | No data lost; all transactions queued and processed after recovery |
| Customer complaints | ~50 | Support team received 50 tickets |
| PR impact | Medium | Issue mentioned on Twitter by 2 users |

### Technical Impact

- [ ] Payment database: connection pool exhausted (100/100 connections)
- [ ] API response time: degraded from 100ms to 5,000ms+ (timeout)
- [ ] Error rate: 100% (all payment requests failed)
- [ ] No cascading failures to other systems (payment is isolated microservice)

---

## Root Cause Analysis

### Timeline to Root Cause

1. **Symptom:** Payment service slow / timing out
   ↓
2. **Investigation:** Database query time normal; connection pool exhausted
   ↓
3. **Code Review:** Transaction service PR merged yesterday
   ↓
4. **Finding:** Database connection not closed in error path
   ```python
   # BAD (before)
   try:
       db.execute("UPDATE subscription SET status = 'paid'")
       connection.close()  # Only called on success!
   except Exception as e:
       pass  # Connection never closed on error ❌
   
   # GOOD (after)
   try:
       db.execute("UPDATE subscription SET status = 'paid'")
   finally:
       connection.close()  # Always closed ✅
   ```
5. **Why it happened:** 
   - PR author didn't use try-finally pattern
   - Code review missed the bug
   - No connection pool monitoring alert

### Root Cause Summary

**Primary Cause:** Database connection not closed in error handling path

**Contributing Factors:**
1. Code review didn't catch the bug (insufficient expertise)
2. No monitoring alert for connection pool exhaustion
3. No integration test for error scenario
4. PR approval happened Friday at 5 PM (low review bandwidth)

**Why Now?** Error scenario was triggered by production traffic patterns that weren't tested in staging.

---

## What Went Well ✅

[Blameless: acknowledge good things the team did]

- [ ] Monitoring alert detected the issue within 2 minutes
- [ ] On-call engineer responded immediately (< 3 min)
- [ ] Incident commander declared severity correctly
- [ ] Rollback process worked smoothly (3 min deployment)
- [ ] No data loss due to transaction queuing
- [ ] Team coordinated well in #incident-war-room Slack channel
- [ ] Customer communication sent 15 minutes post-recovery

---

## What Didn't Go Well ❌

[Blameless: identify process gaps, not blame people]

- [ ] Connection pool not monitored (no alert until traffic dropped)
- [ ] Code review insufficient for connection handling code
- [ ] Error scenario not tested in staging (integration test missing)
- [ ] PR merged on Friday at 5 PM (low review coverage)
- [ ] No runbook for "payment service slow" (on-call had to investigate blind)
- [ ] No pre-incident briefing/readiness check (nobody knew about recent change)

---

## Lessons Learned

### Technical Lessons

| Lesson | How to Prevent |
| ------ | -------------- |
| Connection pools need monitoring | Add CloudWatch alert: connection pool > 80% |
| Error paths need same testing as happy path | Require error scenario tests in PR template |
| Try-finally is critical for resource cleanup | Add ESLint rule to enforce try-finally |
| Database timeouts should be short | Set query timeout to 5 seconds (was 30) |

### Process Lessons

| Lesson | How to Prevent |
| ------ | -------------- |
| Code review of connection code needs 2 reviewers | Add code path ownership rules |
| Friday 5 PM deploys risky | No deployments after 3 PM on Friday |
| Runbooks need updating | Weekly runbook review meeting |
| On-call rotation needs better handoff | 30-min overlap for knowledge transfer |

---

## Action Items

[Specific, measurable actions to prevent recurrence]

### URGENT (Fix this week)

- [ ] **P0 — Add connection pool monitoring**
  - Owner: Carol (Database team)
  - Action: Add CloudWatch alert if connections > 80%
  - Target date: 2026-06-24
  - Verification: Alert triggers in staging when pool maxed out

- [ ] **P0 — Add integration test for error scenario**
  - Owner: Alice (QA)
  - Action: Test database error handling (connection failure, timeout, etc.)
  - Target date: 2026-06-24
  - Verification: Test added to CI/CD pipeline, all pass

### HIGH (Fix this sprint)

- [ ] **P1 — Add code review checklist for database code**
  - Owner: Bob (Tech Lead)
  - Action: Create checklist: try-finally, connection closing, error handling
  - Target date: 2026-06-28
  - Verification: Checklist added to PR template, reviewers use it

- [ ] **P1 — Update runbook for "payment service slow"**
  - Owner: DevOps team
  - Action: Document investigation steps (check connection pool, query time, error logs)
  - Target date: 2026-06-28
  - Verification: On-call tests runbook in staging

- [ ] **P1 — Implement 2-reviewer requirement for critical code paths**
  - Owner: Bob (Tech Lead)
  - Action: Add GitHub branch protection rule
  - Target date: 2026-06-28
  - Verification: Verify rule blocks PRs with < 2 approvals

### MEDIUM (Fix this quarter)

- [ ] **P2 — Freeze Friday 5 PM deployments**
  - Owner: DevOps team
  - Action: Update deployment policy + CI/CD job scheduling
  - Target date: 2026-07-15
  - Verification: Deployment job skipped after 3 PM Friday

- [ ] **P2 — Implement query timeout enforcement**
  - Owner: Data Architect
  - Action: Set max query timeout to 5 seconds
  - Target date: 2026-07-15
  - Verification: Long-running queries logged and tracked

- [ ] **P2 — Improve on-call handoff process**
  - Owner: SRE team
  - Action: 30-min overlap for on-call rotation, brief on recent incidents/changes
  - Target date: 2026-07-15
  - Verification: Handoff template created and used

---

## Action Item Tracking

[Monitor progress of fixes]

| Action Item | Owner | Status | Target | Actual | Notes |
| ----------- | ----- | ------ | ------ | ------ | ----- |
| Connection pool monitoring | Carol | Not Started | 2026-06-24 | - | Waiting on CloudWatch training |
| Error scenario test | Alice | In Progress | 2026-06-24 | - | 50% complete, code review today |
| Code review checklist | Bob | Done ✅ | 2026-06-28 | 2026-06-21 | Already using in PRs |

---

## Blameless Review Principles

**This review is blameless.** We focus on systems, processes, and controls — not individual people. Why?

1. **People make mistakes** — everyone. Blaming doesn't prevent recurrence; processes do.
2. **Good intent** — team members want to do good work. They didn't try to break production.
3. **Learning culture** — if people fear blame, they hide issues and don't speak up.
4. **Systems thinking** — incidents are usually caused by chains of events, not one person.

**Instead of:** "Alice wrote bad code"  
**We ask:** "How could our code review process catch this? How could testing catch this? How could monitoring catch this?"

---

## Communication

### Internal (Slack, Email)

- [ ] Incident report sent to #incidents
- [ ] Root cause explanation sent to engineering team
- [ ] Action items assigned and tracked in Jira
- [ ] Post-incident review summary shared tomorrow

### External (Customers)

- [ ] Status page updated: "Incident resolved" + brief explanation
- [ ] Customer support sent response template for support tickets
- [ ] Example: "We experienced a 45-minute payment service outage. Root cause: database connection pool exhaustion. We've implemented monitoring and improved code review to prevent recurrence."
- [ ] Followup: "We've completed 4/7 action items. Here's what we fixed..."

### Preventive

- [ ] Newsletter article: "How we prevented the June 20 incident" (educational for customers)
- [ ] Blog post: "Lessons learned from our 45-minute incident" (transparency builds trust)

---

## Accountability & Follow-Up

[Track that action items actually get done]

### Weekly Check-In

**Responsible:** Bob (Tech Lead)  
**When:** Every Monday @ 10 AM

| Week | P0 Items | P1 Items | P2 Items | Status |
| ---- | -------- | -------- | -------- | ------ |
| Week 1 | 2/2 done ✅ | 3/5 in progress | - | On track |
| Week 2 | Done ✅ | 5/5 done ✅ | 1/3 started | Ahead |
| Week 3 | - | Done ✅ | 3/3 done ✅ | Complete |

### Follow-Up Incident Review

**Date:** 2 weeks post-incident (2026-07-04)  
**Purpose:** Verify action items completed, monitor metrics

**Checklist:**
- [ ] All P0 items complete?
- [ ] All P1 items complete?
- [ ] Metrics improved? (connection pool avg, response time, error rate)
- [ ] No similar incidents?
- [ ] Are fixes actually working?

---

## Appendices

### Appendix A — Logs & Evidence

**Database logs (2026-06-20 09:30 - 09:45):**
```
[09:30:15] Connection pool exhausted (100/100 active)
[09:30:20] New connection request denied (no available connections)
[09:30:25] Query timeout: UPDATE subscription SET status = 'paid'
[09:31:00] Repeated timeouts in transaction service
```

**Application logs (2026-06-20 09:30 - 09:45):**
```
ERROR: Database connection timeout
ERROR: Failed to process payment for transaction_id=1234567
ERROR: Connection pool unavailable
```

### Appendix B — Affected Transactions

[If data integrity concerns]

- [ ] Verified: 2,000 transactions queued and reprocessed successfully
- [ ] Verified: No duplicate charges (idempotency key prevented double-charging)
- [ ] Verified: No customer refunds needed
- [ ] Verified: All transactions consistent in database

### Appendix C — Similar Past Incidents

[Learn from history]

- 2026-04-15: Similar connection pool issue in authentication service (fix: implement try-finally everywhere)
- 2025-12-10: Database timeout during Black Friday (lesson: implement circuit breaker)
- 2025-08-22: Connection leak in analytics service (lesson: use connection pool monitoring)

**Pattern:** Connection pool issues keep recurring. We need systemic fix (monitoring + code practices).

---

## Attendees

- Bob Smith (Incident Commander)
- Alice Chen (On-Call Engineer)
- Carol Davis (Database Administrator)
- Dave Wilson (DevOps Engineer)
- Eve Johnson (QA Lead)
- Frank Lee (Tech Lead)

---

## Sign-Off

- [ ] Incident Commander: __________ Date: ______
- [ ] Tech Lead: __________ Date: ______
- [ ] Engineering Manager: __________ Date: ______

---

## References

- [Google: Postmortems at Google](https://sre.google/books/) — Blameless postmortem principles
- [PagerDuty Incident Response](https://www.pagerduty.com/incident-response/) — Incident management best practices
- [Etsy: Blameless Postmortems](https://www.etsy.com/) — Pioneered blameless review culture
- [Incident.io](https://incident.io/) — Post-incident management platform
```

---

## PIR Best Practices

1. **Schedule early:** Within 24-48 hours while memory is fresh
2. **Be blameless:** Focus on systems, not people; remove fear
3. **Be thorough:** Include timeline, root cause, lessons learned, action items
4. **Be specific:** Not "improve testing" but "add integration test for error scenario"
5. **Get all perspectives:** Include on-call engineer, developer, ops, and customer-facing teams
6. **Track action items:** Verify they're completed, not forgotten
7. **Share learnings:** Communicate to the whole org; prevent repeat incidents
8. **Follow up:** Check in 1-2 weeks to verify improvements
9. **No blame:** Blame reduces learning; systems thinking prevents recurrence
10. **Celebrate wins:** Acknowledge what the team did right during the incident

---

## References

- [Google: Site Reliability Engineering (SRE) Book](https://sre.google/books/)
- [PagerDuty: Incident Response Training](https://www.pagerduty.com/)
- [Etsy: Blameless Postmortems](https://www.etsy.com/codeascraft)
