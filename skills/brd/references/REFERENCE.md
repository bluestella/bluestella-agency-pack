# BRD Reference Guide

## Requirements Hierarchy

```
Epic         — large feature, 6–12 weeks, multiple sprints
  User Story — shippable chunk, 1–2 weeks, 3–8 story points
    Task     — implementable unit, 1–2 days
      Sub-task — specific work item, a few hours
```

## SMART Acceptance Criteria

Every acceptance criterion must be SMART:
- **Specific** — "Signup completes within 5 seconds" not "it should be fast"
- **Measurable** — quantifiable threshold (time, percentage, count)
- **Achievable** — realistic given team size and sprint length
- **Relevant** — tied to the business outcome, not a technical preference
- **Time-bound** — validated by a specific phase or sprint

**Good:** "When user clicks Submit, account is created and verification email sent within 5 seconds."
**Bad:** "The feature should work well and be performant."

## Story Points Guide

| Points | Effort       | Description                          |
| ------ | ------------ | ------------------------------------ |
| 1–2    | Trivial      | Simple field addition, copy change   |
| 3      | Small        | New API endpoint with validation     |
| 5      | Medium       | Feature with DB + API + frontend     |
| 8      | Large        | Complex feature, multiple components |
| 13+    | Too large    | Split into smaller stories           |

## Requirements Checklist Status Values

| Status      | Meaning                                      |
| ----------- | -------------------------------------------- |
| TODO        | Not started                                  |
| In Progress | Actively being worked on                     |
| Done        | Completed and verified by QA                 |
| Blocked     | Cannot proceed — waiting on dependency       |
| Deferred    | Moved to a later sprint by Product Manager   |

## Reopening Requirements

When QA or Security triggers a feedback hook that invalidates an accepted story:
1. Update the affected AC as a new numbered item (don't delete old ACs)
2. Add a new row to the requirements checklist (don't reuse old IDs)
3. Update the story status to In Progress
4. Notify Tech Lead + stakeholder of scope impact

## External References

- [Atlassian: Epics, Stories, Themes](https://www.atlassian.com/agile/project-management/epics-stories-themes)
- [IIBA: Business Analysis Body of Knowledge (BABOK)](https://www.iiba.org/babok-guide/)
- [Mountain Goat Software: User Stories](https://www.mountaingoatsoftware.com/agile/user-stories)
