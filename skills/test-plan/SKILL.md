---
name: test-plan
description: >
  Generates comprehensive test plans covering unit, integration, API, visual regression,
  performance, security, and accessibility tests. Includes test strategy, test cases with
  acceptance criteria, coverage goals, and success metrics. Use when planning QA for a
  feature, writing test strategy, defining test scope, ensuring coverage goals, or
  coordinating testing across teams.
metadata:
  author: bluestella
  version: "1.0"
---

# Test Plan

## Overview

A Test Plan defines the testing strategy for a feature — what to test, how, who, when, and the success criteria. This skill produces multi-layer test plans covering all testing types (unit → E2E → performance → security → accessibility), ensuring nothing is left to chance before a feature ships.

## Steps

1. **State the objective and scope.** What feature is being tested? What's explicitly in scope and out of scope? Link to the User Story or Epic.
2. **Define the test strategy.** Select testing levels needed: unit, integration, API, visual regression, E2E, performance, security, accessibility. Assign owner and tool per level.
3. **Write test cases per level.** For each level: test ID, description, input, expected result. Cover happy paths AND error paths. Reference acceptance criteria from the BRD.
4. **Set coverage goals.** Unit: ≥90%; Integration: ≥80%; API contracts: 100% (happy + error paths); Critical E2E journeys: 100%; A11y violations: 0 Critical/Serious.
5. **Plan the execution timeline.** Map each test type to a sprint day and assign owners. Unit/integration first (developer-owned); API/visual/E2E next (QA-owned); performance + security last (specialist-owned).
6. **Define success criteria.** All coverage goals met, all critical tests passing, zero unresolved Critical bugs.
7. **Document blockers.** Known dependencies or environment issues that could delay testing.

## Output Format

A markdown test plan document:

```
# Test Plan: [Feature Name]
Version / Date / Owner / Status
## 1. Objective + Scope
## 2. Test Strategy         — levels, tools, owners, priorities
## 3. Test Cases            — per level: ID, description, input, expected, status
## 4. Coverage Goals
## 5. Execution Timeline    — sprint day + owner per level
## 6. Success Criteria      — checkboxes
## 7. Known Issues          — blockers table
## 8. Sign-Off
```

Template: [`templates/test-plan-template.md`](templates/test-plan-template.md)

## Examples

**Input:** "Plan QA for OAuth 2.0 login (Google + GitHub). Feature adds new login flow alongside existing email/password."

**Output:** Test plan with: unit tests for JWT validation and OAuth token exchange logic, API tests for GET /auth/oauth (all providers + error states), E2E test for full OAuth login journey, security tests for token forgery and redirect URI validation, regression tests for existing email/password flow.

**Input:** "Performance SLA: login must complete in ≤500ms at p95 under 1,000 concurrent users."

**Output:** Performance test cases: P-001 (p95 latency ≤500ms at 1K concurrent), P-002 (0% error rate at 1K concurrent), P-003 (Lighthouse LCP ≤2.5s). Tool: k6 for load, Lighthouse CI for CWV.

## Edge Cases

- No performance engineer on the team: document performance test cases anyway; developer or QA runs them with k6.
- Third-party OAuth provider unavailable in CI: mock the OAuth token exchange endpoint; document that production testing requires real providers in staging.
- Visual regression first run: first run creates baselines — mark all V-tests as "baseline" not "pass/fail" until second run.
- Accessibility audit finds Critical violations: block the release; Critical a11y = same priority as Critical bugs.

## References

See [`references/REFERENCE.md`](references/REFERENCE.md) for the testing trophy model, coverage thresholds, tool commands, and WCAG 2.1 testing guidance.
