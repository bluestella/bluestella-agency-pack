---
name: post-incident-review
description: >
  Conducts structured post-incident reviews documenting timeline, root cause analysis,
  lessons learned, and action items to prevent recurrence. Follows blameless review
  principles with follow-up accountability tracking. Use when conducting a post-mortem
  after an incident, production outage, security breach, data loss event, critical bug,
  or any incident retrospective.
metadata:
  author: bluestella
  version: "1.0"
---

# Post-Incident Review (PIR)

## Overview

A Post-Incident Review (also called Post-Mortem) is a blameless investigation into what happened during an incident, why it happened, and how to prevent recurrence. This skill produces structured PIR documents for DevOps, SRE, and Tech Lead teams. The emphasis is on systems and processes — not individual blame.

## Steps

1. **Schedule immediately.** Within 24–48 hours of resolution while memory is fresh. Include: on-call engineer, developer(s) involved, incident commander, relevant ops/QA.
2. **Write the executive summary.** 2 sentences: what happened, impact duration, and how it was resolved.
3. **Build the timeline.** Minute-by-minute log from first detection to full recovery. Include: who detected it, when, what actions were taken, when it was resolved.
4. **Assess impact.** Users affected, revenue impact, SLA breach, data integrity.
5. **Perform root cause analysis.** Use the "5 Whys" technique. Document primary cause + contributing factors. Include the code/config snippet that caused the issue.
6. **Capture what went well and what didn't.** Both sections are required — blameless reviews acknowledge good team responses as well as process gaps.
7. **Extract lessons learned.** Technical + process lessons. Each lesson must map to a preventive action.
8. **Write action items.** P0 (urgent, this week), P1 (this sprint), P2 (this quarter). Each action: owner, specific action, target date, verification method.
9. **Set up accountability tracking.** Weekly check-in cadence with the incident commander until all P0/P1 items are complete.

## Output Format

A single markdown PIR document:

```
# Post-Incident Review: [Incident Title]
Date / Duration / Severity / Status
## Executive Summary
## Timeline           — minute-by-minute table
## Impact Assessment  — scope, business, technical
## Root Cause Analysis — 5 Whys, primary cause, contributing factors
## What Went Well     — checkbox list
## What Didn't        — checkbox list
## Lessons Learned    — technical + process table
## Action Items       — P0/P1/P2 with owner/date/verification
## Action Item Tracking — weekly status table
## Communication      — internal + external
## Sign-Off
```

Template: [`templates/pir-template.md`](templates/pir-template.md)

## Examples

**Input:** "Database connection pool exhausted for 45 minutes. Payment service was down."

**Output:** PIR with timeline from 09:30 (first alert) to 10:15 (full recovery), root cause (connection not closed in error path), 3 P0 actions (add connection pool monitoring, add integration test for error paths, set query timeout), 2 P1 actions (code review checklist, update runbook).

**Input:** "Security breach: SQL injection vulnerability exploited."

**Output:** PIR with Critical severity, immediate data integrity assessment, root cause (unparameterized query), P0 actions including credential rotation and SAST scan of entire codebase, and Security Architect added to sign-off.

## Edge Cases

- Ongoing incident (not yet resolved): use this template as a live incident doc during the incident, then convert to final PIR after resolution.
- No data loss but SLA breached: still write a PIR — SLA breaches affect customer trust and contracts.
- Blame culture risk: if participants start attributing blame, redirect to "how could our system/process have caught this?"
- Action item scope creep: if a P2 action becomes a large project, create a proper ticket and link it — don't write the full design in the PIR.

## References

See [`references/REFERENCE.md`](references/REFERENCE.md) for blameless review principles, 5 Whys technique, and SRE guidance.
