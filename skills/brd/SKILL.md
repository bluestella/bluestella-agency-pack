---
name: brd
description: Generates a structured Business Requirements Document (BRD) following Agile hierarchy (Epic → User Story → Task → Sub-task) with acceptance criteria, Definition of Done per role, and a requirements checklist with status tracking (TODO / In Progress / Done). WHEN: Writing requirements, creating an epic, drafting user stories, defining acceptance criteria, breaking down a business goal into development work items, organizing requirements in JIRA/GitHub.
---

# BRD Skill — Business Requirements Document Generation

## Overview

This skill helps Business Analysts and Product Managers generate structured Business Requirements Documents (BRDs) that follow the Agile hierarchy model: **Epic → User Story → Task → Sub-task**. The skill ensures that requirements are complete, testable, traceable, and ready for engineering implementation.

## When to Use This Skill

- **Scenario 1:** Create a new Epic from a business goal statement
- **Scenario 2:** Write User Stories with acceptance criteria for a feature
- **Scenario 3:** Break a Story into implementable Tasks and Sub-tasks
- **Scenario 4:** Define Definition of Done (DoD) with role-specific metrics
- **Scenario 5:** Establish a requirements checklist with status tracking
- **Scenario 6:** Re-open and update requirements when QA/Security findings demand scope changes

## Workflow

### Step 1: Define the Epic

**Input:** Business goal or feature description (plain language)

**Output:** Structured Epic with:

- **Epic Title:** Clear, business-focused
- **Business Outcome:** What value does this deliver?
- **Success Metrics:** How do we measure success?
- **Target Completion:** Rough timeline
- **Key Stakeholders:** Who cares about this epic?
- **Assumptions & Constraints:** Known limits

**Example:**

```markdown
**Epic:** User Registration & Onboarding

**Business Outcome:**
Enable new users to create accounts, verify email, and set up profiles
so that we can grow the user base and personalize their experience.

**Success Metrics:**

- Signup completion rate ≥ 80% (users who start signup flow finish it)
- Average signup time ≤ 5 minutes
- Email verification rate ≥ 95%

**Target Completion:** 3 sprints (6 weeks)

**Key Stakeholders:** Product, Engineering, Customer Support

**Assumptions:**

- Email service available and reliable (99.9% uptime)
- Database can handle 1,000 new signups/day

**Constraints:**

- Must comply with GDPR (user consent, data minimization)
- Must support only OAuth 2.0 + email/password (no social logins initially)
```

---

### Step 2: Create User Stories

**Input:** Epic definition

**Output:** 3–5 User Stories per Epic, each with:

- **"As a / I want / So that"** statement
- **Acceptance Criteria** (testable, not implementation)
- **Effort Estimate** (story points or hours)
- **Definition of Done** (role-specific metrics)

**Template:**

```markdown
## User Story 1: User Account Registration

**As a** new user
**I want** to create an account with an email and password
**So that** I can access my personalized dashboard

### Acceptance Criteria

- [ ] User can enter email address, password, confirm password
- [ ] Password validation: ≥ 8 chars, ≥ 1 uppercase, ≥ 1 number
- [ ] Email validation: RFC 5322 compliant; must be unique
- [ ] On success, account created and verification email sent within 5 seconds
- [ ] On error, user sees specific error message (not "Error")
- [ ] Form inputs persist if validation fails (except password)
- [ ] Captcha or rate-limiting prevents brute force attempts

### Definition of Done

**Developer:**

- [ ] Code peer-reviewed
- [ ] Unit tests ≥ 90% coverage
- [ ] No TypeScript errors
- [ ] Endpoint returns correct HTTP status (200, 400, 409, 429)
- [ ] Request/response matches API contract

**QA:**

- [ ] All acceptance criteria verified manually
- [ ] Edge cases tested (special characters, max length, etc.)
- [ ] No critical bugs
- [ ] Performance: signup < 5 seconds p95

**Product:**

- [ ] Feature aligns with roadmap
- [ ] User flow matches mockups
- [ ] Stakeholder sign-off obtained

**Security:**

- [ ] No SQL injection or XSS vulnerabilities
- [ ] Passwords hashed (bcrypt, argon2, etc.)
- [ ] No passwords logged
- [ ] Rate limiting active (max 5 signup attempts per IP per hour)

### Effort Estimate

5 story points (1–2 days)

### Dependencies

None (independent)
```

---

### Step 3: Break Stories into Tasks & Sub-tasks

**Input:** User Story with acceptance criteria

**Output:** 2–4 implementable Tasks, each with Sub-tasks

**Example:**

```markdown
### Story 1: User Account Registration

#### Task 1: Backend – Email & Password Validation

- [ ] Sub-task 1a: Implement email format validation (RFC 5322) and uniqueness check
- [ ] Sub-task 1b: Implement password validation (length, complexity)
- [ ] Sub-task 1c: Add rate limiting (5 attempts per IP per hour)
- [ ] Sub-task 1d: Write unit tests for all validation functions
- [ ] Sub-task 1e: API endpoint returns correct HTTP status codes

#### Task 2: Backend – Account Creation & Email Service Integration

- [ ] Sub-task 2a: Design database schema for users table
- [ ] Sub-task 2b: Create POST /api/v1/auth/signup endpoint
- [ ] Sub-task 2c: Integrate with email service (SendGrid / SES)
- [ ] Sub-task 2d: Generate verification token (JWT, 24hr expiry)
- [ ] Sub-task 2e: Write integration tests (happy path + errors)

#### Task 3: Frontend – Signup Form UI

- [ ] Sub-task 3a: Design signup form component (React)
- [ ] Sub-task 3b: Add client-side validation feedback
- [ ] Sub-task 3c: Handle API errors and display messages
- [ ] Sub-task 3d: Add accessibility features (labels, ARIA, keyboard nav)
- [ ] Sub-task 3e: Write component tests with React Testing Library

#### Task 4: QA – End-to-End Testing

- [ ] Sub-task 4a: Write E2E tests (Playwright) for happy path
- [ ] Sub-task 4b: Test error scenarios (duplicate email, weak password, etc.)
- [ ] Sub-task 4c: Test rate limiting
- [ ] Sub-task 4d: Verify email delivery and verification link
- [ ] Sub-task 4e: Run security audit (SAST, dependency scan)
```

---

### Step 4: Create Requirements Checklist

**Input:** All Stories, Tasks, and Sub-tasks

**Output:** Centralized checklist with status tracking

**Template:**

```markdown
## Requirements Checklist: User Registration & Onboarding Epic

| ID     | Item                             | Type     | Owner              | Status      | Target Sprint | Notes                                 |
| ------ | -------------------------------- | -------- | ------------------ | ----------- | ------------- | ------------------------------------- |
| 1.1    | User Account Registration        | Story    | Backend Team       | In Progress | Sprint 1      | 5 points; DB schema ready             |
| 1.1.1  | Email & Password Validation      | Task     | Backend            | In Progress | Sprint 1      | Assigned to Alice                     |
| 1.1.1a | Email validation function        | Sub-task | Alice              | Done        | Sprint 1      | Code review pending                   |
| 1.1.1b | Password validation function     | Sub-task | Alice              | In Progress | Sprint 1      | Due EOD Thursday                      |
| 1.1.2  | Account Creation & Email Service | Task     | Backend            | Not Started | Sprint 1      | Depends on 1.1.1 completion           |
| 1.2    | Email Verification               | Story    | Backend / Frontend | Not Started | Sprint 2      | Blocked: waiting for SendGrid API key |

| ...

**Status Values:**

- TODO: Not started
- In Progress: Actively being worked on
- Done: Completed and verified
- Blocked: Cannot proceed (waiting on dependency)
- Deferred: Moved to later sprint
```

---

## Definition of Done by Role

### Developer DoD (Backend)

- [ ] Code peer-reviewed by Tech Lead
- [ ] Unit tests ≥ 90% coverage (statement, line, branch, function)
- [ ] TypeScript compile: 0 errors (`tsc --noEmit`)
- [ ] ESLint: 0 errors
- [ ] SonarCloud Quality Gate: Passed
- [ ] API contracts match Integration Architect spec (OpenAPI)
- [ ] Error responses have correct HTTP status codes and messages
- [ ] No hardcoded secrets, no debug artifacts (`console.log`, `debugger`)
- [ ] Acceptance criteria verified in code or tests

### Frontend Developer DoD (React)

- [ ] Component tested with React Testing Library (≥ 90% coverage)
- [ ] Visual regression testing (Playwright `toHaveScreenshot`)
- [ ] Accessibility audit (axe-core): 0 Critical, Serious violations
- [ ] TypeScript: 0 errors
- [ ] ESLint: 0 errors
- [ ] SonarCloud Quality Gate: Passed
- [ ] All acceptance criteria verified manually
- [ ] No layout shifts, broken links, or visual regressions

### QA / Testing DoD

- [ ] All acceptance criteria tested and verified
- [ ] Edge cases tested (empty inputs, max length, special chars, etc.)
- [ ] Happy path + error paths tested
- [ ] Performance validated (response time, page load)
- [ ] No critical or high-severity bugs
- [ ] Bug checklist updated with any findings
- [ ] Test coverage ≥ 90%

### Security DoD

- [ ] SAST scan (GitHub CodeQL): 0 findings
- [ ] STRIDE threat model: All threats mitigated or risk-accepted
- [ ] Dependency audit (`pnpm audit`): 0 CVEs at audit-level
- [ ] No hardcoded secrets or credentials
- [ ] Authentication/authorization tested for this feature
- [ ] Input validation and sanitization verified
- [ ] Sensitive data not logged

### Product DoD

- [ ] Feature aligns with roadmap and business goals
- [ ] User flow matches approved mockups
- [ ] Acceptance criteria are complete and testable
- [ ] Stakeholder review and sign-off obtained
- [ ] Success metrics defined and measurable

---

## BRD Template (Markdown)

```markdown
# Business Requirements Document: [Epic Name]

## Executive Summary

[2–3 sentences on the business goal, customer value, and expected impact]

---

## Epic Definition

**Epic Title:** [e.g., "User Registration & Onboarding"]

**Business Outcome:**
[What problem does this solve? What value does it deliver?]

**Success Metrics:**

- [Metric 1 with threshold, e.g., Signup completion rate ≥ 80%]
- [Metric 2, e.g., Average signup time ≤ 5 minutes]
- [Metric 3, e.g., Email verification rate ≥ 95%]

**Target Timeline:** [e.g., 3 sprints, 6 weeks]

**Key Stakeholders:** [Product, Engineering, Support, etc.]

**Assumptions:** [e.g., Email service 99.9% uptime, 1,000 signups/day capacity]

**Constraints:** [e.g., GDPR compliance, OAuth 2.0 only]

---

## User Stories

### User Story 1: [Story Title]

**As a** [user role, e.g., "new user"]
**I want** [action/feature, e.g., "create an account with email and password"]
**So that** [business value, e.g., "I can access my personalized dashboard"]

**Acceptance Criteria:**

- [ ] [AC 1 — testable condition]
- [ ] [AC 2 — testable condition]
- [ ] [AC 3 — edge case]

**Definition of Done:**
**Developer:** _(see template above)_
**QA:** _(see template above)_
**Product:** _(see template above)_
**Security:** _(see template above)_

**Effort Estimate:** [Story points or hours, e.g., 5 points]

**Dependencies:** [Related stories/tasks, e.g., "Depends on Task 1.2"]

**Blockers / Notes:** [Any known issues or concerns]

---

## Requirements Checklist

| ID     | Requirement                 | Type     | Status | Owner   | Sprint | Notes |
| ------ | --------------------------- | -------- | ------ | ------- | ------ | ----- |
| 1.1    | User Account Registration   | Story    | TODO   | Backend | S1     | -     |
| 1.1.1  | Email & Password Validation | Task     | TODO   | Alice   | S1     | -     |
| 1.1.1a | Email validation function   | Sub-task | TODO   | Alice   | S1     | -     |
| ...    | ...                         | ...      | ...    | ...     | ...    | ...   |

**Status Key:** TODO | In Progress | Done | Blocked | Deferred

---

## References & Attachments

- [Design mockups](#)
- [API specification](#)
- [Compliance checklist (GDPR, etc.)](#)
- [Security threat model (STRIDE)](#)
- [Performance baselines](#)

---

## Sign-Off

- [ ] Product Manager: ********\_******** Date: **\_\_\_**
- [ ] Tech Lead: ********\_******** Date: **\_\_\_**
- [ ] Security Lead: ********\_******** Date: **\_\_\_**
- [ ] Stakeholder: ********\_******** Date: **\_\_\_**
```

---

## Best Practices

### Acceptance Criteria Should Be:

- **SMART:** Specific, Measurable, Achievable, Relevant, Time-bound
- **Testable:** Verifiable by a machine or QA engineer
- **Not implementation details:** "Use React hooks" is too specific; "Support state management" is better
- **Business-focused:** Describe the outcome, not the code

### Good AC Example:

> When user clicks "Submit", the form data is validated and persisted within 2 seconds. A success message appears, and the user is redirected to the dashboard.

### Bad AC Example:

> The feature should work well and be performant.

---

### Requirements Hierarchy

```
Epic (large feature, 6–12 weeks)
  ├─ User Story (shippable chunk, 1–2 weeks, 3–8 points)
  │   ├─ Task (implementable unit, 1–2 days)
  │   │   ├─ Sub-task (specific work item, a few hours)
  │   │   └─ Sub-task
  │   └─ Task
  └─ User Story
```

---

## References

- [Epics, Stories, and Themes – Atlassian](https://www.atlassian.com/agile/project-management/epics-stories-themes)
- [User Story Best Practices – Product School](https://www.productschool.com/blog/)
- [Acceptance Criteria Guide – ThoughtWorks](https://www.thoughtworks.com/)
- [SMART Goals – MindTools](https://www.mindtools.com/pages/article/smart-goals.htm)
- [Business Analysis Guide – IIBA](https://www.iiba.org/)
