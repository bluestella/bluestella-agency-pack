# Post-Incident Review: [Incident Title]

**Date:** [YYYY-MM-DD]
**Duration:** [HH:MM UTC] to [HH:MM UTC] ([N] minutes/hours)
**Severity:** Critical | High | Medium | Low
**Status:** Resolved | Monitoring | Ongoing

---

## Executive Summary

[2 sentences: What happened? What was the impact and how was it resolved?]

---

## Timeline

| Time (UTC) | Event                                | Owner     | Note                    |
| ---------- | ------------------------------------ | --------- | ----------------------- |
| [HH:MM]    | [First detection — alert or report]  | [Monitor] | [Alert threshold]       |
| [HH:MM]    | [On-call notified]                   | [Name]    | [Channel]               |
| [HH:MM]    | [Incident declared, war room opened] | [Name]    | [Severity level]        |
| [HH:MM]    | [Investigation finding]              | [Name]    | [Key finding]           |
| [HH:MM]    | [Root cause identified]              | [Name]    |                         |
| [HH:MM]    | [Remediation initiated]              | [Name]    | [Action taken]          |
| [HH:MM]    | [Service recovered]                  | [Monitor] | [Recovery confirmed by] |
| [HH:MM]    | [PIR scheduled]                      | [Name]    |                         |

---

## Impact Assessment

### Scope

- **Services Affected:** [List services]
- **Users Affected:** [N% of DAU / N users]
- **Duration:** [N minutes]
- **Geographic Impact:** [Region(s)]

### Business Impact

| Metric                | Value | Impact              |
| --------------------- | ----- | ------------------- |
| Estimated lost txns   | [N]   | [$X revenue impact] |
| SLA breach?           | Yes/No | [SLA threshold]   |
| Data loss?            | Yes/No | [Details]         |
| Customer complaints   | [N]   | [Support tickets]   |

### Technical Impact

- [ ] [System/service impact 1]
- [ ] [System/service impact 2]

---

## Root Cause Analysis

### 5 Whys

1. **Why** did [symptom occur]? → [Answer]
2. **Why** did [Answer from 1] happen? → [Answer]
3. **Why** did [Answer from 2] happen? → [Answer]
4. **Why** did [Answer from 3] happen? → [Answer]
5. **Why** did [Answer from 4] happen? → [Root cause]

### Primary Cause

[One sentence: the root cause]

### Contributing Factors

1. [Factor 1 — process gap]
2. [Factor 2 — missing monitoring]
3. [Factor 3 — code/review gap]

---

## What Went Well ✅

- [ ] [Positive outcome 1 — e.g., alert detected within 2 minutes]
- [ ] [Positive outcome 2 — e.g., rollback completed in 3 minutes]
- [ ] [Positive outcome 3 — e.g., no data loss]

---

## What Didn't Go Well ❌

- [ ] [Process gap 1 — e.g., no monitoring for X metric]
- [ ] [Process gap 2 — e.g., runbook missing for this scenario]
- [ ] [Process gap 3 — e.g., PR review missed the bug]

---

## Lessons Learned

### Technical

| Lesson | Prevention Action |
| ------ | ----------------- |
| [e.g., Connection pools need monitoring] | [e.g., Add CloudWatch alert: pool > 80%] |
| [Lesson 2] | [Action 2] |

### Process

| Lesson | Prevention Action |
| ------ | ----------------- |
| [e.g., Friday 5 PM deploys are risky] | [e.g., Block deploys after 3 PM Friday] |
| [Lesson 2] | [Action 2] |

---

## Action Items

### P0 — Urgent (fix this week)

- [ ] **[P0-1]** [Specific action]
  - Owner: [Name/Team]
  - Target: [YYYY-MM-DD]
  - Verification: [How we confirm it's done]

### P1 — High (fix this sprint)

- [ ] **[P1-1]** [Specific action]
  - Owner: [Name/Team]
  - Target: [YYYY-MM-DD]
  - Verification: [How we confirm it's done]

### P2 — Medium (fix this quarter)

- [ ] **[P2-1]** [Specific action]
  - Owner: [Name/Team]
  - Target: [YYYY-MM-DD]
  - Verification: [How we confirm it's done]

---

## Action Item Tracking

| Item   | Owner  | Status      | Target     | Actual | Notes |
| ------ | ------ | ----------- | ---------- | ------ | ----- |
| P0-1   | [Name] | Not Started | [date]     | —      |       |
| P1-1   | [Name] | Not Started | [date]     | —      |       |

---

## Communication

**Internal:**
- [ ] Incident report sent to #incidents
- [ ] Root cause summary sent to engineering team
- [ ] Action items tracked in project management tool

**External (if customer-facing impact):**
- [ ] Status page updated with resolution note
- [ ] Support response template sent for inbound tickets

---

## Sign-Off

- [ ] Incident Commander: ______________ Date: ______
- [ ] Tech Lead: ______________ Date: ______
- [ ] Engineering Manager: ______________ Date: ______
