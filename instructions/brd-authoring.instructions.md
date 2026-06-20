---
applyTo: "docs/**,epics/**,PLANS*.md"
title: "BRD & Epic Authoring Standards"
description: "Step-by-step guide for writing Business Requirements Documents, Epics, and User Stories"
---

## BRD Overview

A **Business Requirements Document (BRD)** defines WHAT we're building and WHY. It flows from:

**Epic** → **User Story** → **Task** → **Sub-Task**

---

## Epic Template

Every Epic answers these questions:

```markdown
# Epic: [Feature Name]

## Business Outcome
[What business goal does this achieve? How does it make users/company better?]

Example: "Enable users to export data in multiple formats (CSV, Excel, JSON), enabling self-service analytics and reducing support burden by 30%."

## User Personas
[Who benefits? Which user roles?]

Example: "Analytics Manager, Finance Analyst, Data Scientist"

## Success Metrics
[How do we measure success? Be specific and quantifiable.]

- [ ] 50% of users export data monthly
- [ ] Support tickets for "export data" reduced to 0
- [ ] User satisfaction score > 4.5/5
- [ ] Export completes in < 5 seconds for 100K records

## User Stories
[At least 3 user stories that make up this epic]

1. Analytics Manager can export data as CSV
2. Finance Analyst can export with custom column selection
3. Data Scientist can export as JSON with raw timestamps

## Definition of Done (by role)

### Developer
- [ ] All user stories implemented
- [ ] No console errors or warnings
- [ ] Code reviewed and merged

### QA
- [ ] All acceptance criteria tested
- [ ] Edge cases tested (empty export, large export, special characters)
- [ ] Visual regression testing passed

### Product
- [ ] Business outcome achieved (metrics show improvement)
- [ ] User feedback collected (at least 3 users tested)
- [ ] Documented in help center

### Support
- [ ] Support team trained on export feature
- [ ] FAQ updated with export instructions
- [ ] Zero unresolved support tickets on this feature
```

---

## User Story Template

Every User Story has:
1. **As a / I want / So that** (context, action, benefit)
2. **Acceptance Criteria** (specific, testable)
3. **Definition of Done** (per role)

```markdown
# User Story: [Title]

## As a / I Want / So That

**As a** [user role],  
**I want** [specific action],  
**So that** [business benefit]

Example:
**As a** Analytics Manager,  
**I want** to export subscription data as CSV,  
**So that** I can analyze it in Excel and create custom reports.

## Acceptance Criteria

- [ ] User can click "Export" button on dashboard
- [ ] Export dialog shows format options (CSV, Excel, JSON)
- [ ] User can select columns to include
- [ ] Export generates file within 5 seconds (for < 100K records)
- [ ] CSV file is properly formatted (valid column headers, escaped values)
- [ ] User receives download in browser
- [ ] Export respects user's date filters (only exports filtered data)
- [ ] Error message shows if export fails (network error, DB timeout)

## Definition of Done

### Developer
- [ ] Feature implemented in [branch name]
- [ ] Code reviewed by [reviewer]
- [ ] Unit tests written (≥90% coverage)
- [ ] Handles error cases (network, timeout, empty data)
- [ ] No console errors/warnings
- [ ] Merged to main

### QA
- [ ] Tested on Chrome, Firefox, Safari
- [ ] Tested on desktop + mobile
- [ ] Tested with < 100 records (fast), > 1M records (slow but works)
- [ ] Tested with special characters (commas, quotes in data)
- [ ] Tested with empty data set (no errors)
- [ ] Performance acceptable (< 5 seconds for 100K records)

### Product
- [ ] Business value confirmed (Analytics Manager approved)
- [ ] Help article written (with screenshots)
- [ ] Feature released to production
- [ ] Metrics tracked (export volume, usage patterns)

### Support
- [ ] Support team trained (30-min training session)
- [ ] FAQ updated
- [ ] Support tickets on this feature: 0 within first week
```

---

## Task Breakdown (from User Story)

Break each User Story into implementation Tasks:

```markdown
# Task 1: Create export API endpoint

## Description
Build POST /api/exports endpoint that generates CSV export.

## Technical Requirements
- Accept export parameters: (format: CSV|Excel|JSON, columns, filters)
- Validate parameters with Zod
- Query database with user's filters
- Generate file in requested format
- Return download URL

## Acceptance Criteria
- [ ] Endpoint accepts POST /api/exports
- [ ] Validates format, columns, filters
- [ ] Returns 400 if validation fails
- [ ] Generates CSV (properly escaped, valid headers)
- [ ] Returns 200 with download URL
- [ ] Handles 1M record export without timeout

## Subtasks
- [ ] Implement CSV generation (use npm package)
- [ ] Implement Excel generation (use npm package)
- [ ] Implement JSON generation
- [ ] Add Zod validation schema
- [ ] Add unit tests

---

# Task 2: Create export UI button and dialog

## Description
Build React component for export dialog (format selection, column picker).

## Technical Requirements
- Display "Export" button on dashboard
- Show dialog with format options
- Show column picker (checkboxes)
- Call API endpoint to generate export
- Download file when ready

## Acceptance Criteria
- [ ] Export button visible on dashboard
- [ ] Dialog shows CSV/Excel/JSON options
- [ ] Column checkboxes work (select/deselect all)
- [ ] API called with correct parameters
- [ ] File downloads to user's device
- [ ] Loading state shown during export
- [ ] Error message shown if export fails

## Subtasks
- [ ] Create ExportDialog component
- [ ] Create column picker component
- [ ] Add error boundary
- [ ] Add loading spinner
```

---

## Acceptance Criteria Quality Checklist

Every acceptance criterion should be:

- ✅ **Specific:** Not "user can export data" (too vague), but "CSV exports with all columns selected by default"
- ✅ **Testable:** Can QA verify this with a test?
- ✅ **Independent:** One criterion per behavior
- ✅ **Measurable:** Use numbers ("< 5 seconds", "≤ 100MB")

❌ Bad criteria:
- "Export works correctly"
- "Performance is good"
- "User experience is improved"

✅ Good criteria:
- "Export completes within 5 seconds for 100K records"
- "CSV file is valid (proper headers, escaped values)"
- "Error message appears within 2 seconds if API fails"

---

## Definition of Done Quality Checklist

Every role's DoD should include:

- ✅ **Specific outcomes:** Not "tested", but "tested on Chrome, Firefox, Safari"
- ✅ **Measurable:** "< 5 seconds", "0 bugs"
- ✅ **Role-appropriate:** Different roles have different responsibilities
- ✅ **Verifiable:** Can the role definitively say "this is done"?

---

## Estimation

**Developer estimates tasks:**
- S = Small (< 4 hours, 1 dev)
- M = Medium (4-8 hours, 1 dev)
- L = Large (1-2 days, 1 dev or 2 devs in parallel)
- XL = Extra Large (> 2 days, needs break down or multiple devs)

**Time box:** Never estimate more than 2 days for a single task. Break down XL tasks.

---

## Epic → Story → Task → Subtask Flow

```
Epic: Data Export Feature
├─ User Story 1: Export as CSV
│  ├─ Task 1: CSV API endpoint
│  ├─ Task 2: CSV download UI
│  └─ Task 3: CSV testing & QA
├─ User Story 2: Export as Excel
│  ├─ Task 1: Excel library integration
│  ├─ Task 2: Excel UI
│  └─ Task 3: Excel testing
└─ User Story 3: Column selection
   ├─ Task 1: Column picker component
   ├─ Task 2: Column state management
   └─ Task 3: Testing
```

---

## Checklist Before Marking Epic "Done"

- [ ] All user stories completed
- [ ] All acceptance criteria met
- [ ] All developer DoD items met
- [ ] All QA DoD items met
- [ ] All product DoD items met
- [ ] All support DoD items met
- [ ] Zero open bugs
- [ ] Product manager approved
- [ ] Metrics meeting success criteria
