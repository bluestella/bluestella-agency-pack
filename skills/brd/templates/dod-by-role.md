# Definition of Done (DoD) by Role

## Backend Developer

- [ ] Code peer-reviewed (Tech Lead)
- [ ] Unit tests ≥ 90% coverage (statement, line, branch, function)
- [ ] `tsc --noEmit` — 0 TypeScript errors
- [ ] `pnpm lint` — 0 ESLint errors
- [ ] SonarCloud Quality Gate: Passed
- [ ] API response schema matches contract
- [ ] HTTP status codes correct (200, 400, 401, 404, 500, etc.)
- [ ] No `console.log`, `debugger` statements
- [ ] No hardcoded secrets
- [ ] Error responses are descriptive (not raw exceptions)
- [ ] Acceptance criteria verified in code/tests

## Frontend Developer (React)

- [ ] Component tested with React Testing Library (≥ 90% coverage)
- [ ] Visual regression testing: `toHaveScreenshot` passes
- [ ] Accessibility audit (axe-core): 0 Critical, 0 Serious violations
- [ ] `tsc --noEmit` — 0 TypeScript errors
- [ ] `pnpm lint` — 0 ESLint errors
- [ ] SonarCloud Quality Gate: Passed
- [ ] All acceptance criteria manually verified
- [ ] No `console.log`, `debugger` statements
- [ ] Keyboard navigation tested (Tab, Enter, Esc)
- [ ] Mobile responsive (works on mobile breakpoints)
- [ ] Component story in Storybook (if applicable)

## QA / Testing

- [ ] All acceptance criteria tested and verified
- [ ] Happy path + error paths tested
- [ ] Edge cases tested (empty, max length, special chars, etc.)
- [ ] Performance validated (load time, response time)
- [ ] No critical bugs (P0/P1)
- [ ] No high-severity bugs (P2) without team sign-off
- [ ] Bug checklist updated (labels: `bug:critical`, `bug:high`, `bug:medium`, `bug:low`)
- [ ] Test coverage ≥ 90%

## Security

- [ ] SAST scan (CodeQL): 0 findings
- [ ] SCA scan (`pnpm audit`): 0 CVEs at audit-level
- [ ] No hardcoded secrets or credentials
- [ ] Authentication/authorization tested for this feature
- [ ] Input validation and sanitization verified
- [ ] Sensitive data not logged
- [ ] STRIDE threat model: All threats mitigated or risk-accepted

## Product Manager

- [ ] Feature aligns with roadmap and business goals
- [ ] User flows match approved mockups/wireframes
- [ ] Acceptance criteria are complete and testable
- [ ] Stakeholder review completed
- [ ] Sign-off obtained
- [ ] Success metrics defined and measurable
- [ ] Documentation updated (user-facing help text, etc.)

---

## How to Use This Checklist

1. **Before starting work:** Copy the relevant DoD for your role
2. **During development:** Check off each item as you complete it
3. **Before opening a PR:** Verify all items are checked
4. **During code review:** Tech Lead verifies all role-specific DoD items

**Example PR Comment (Tech Lead):**

```
Gate 1 — Unit Test Coverage: ✅ PASS (91% coverage)
Gate 2 — Type Safety: ✅ PASS (0 TS errors)
Gate 3 — Linting: ✅ PASS (0 ESLint errors)
Gate 4 — Code Quality: ✅ PASS (SonarCloud Passed)
Gate 5 — Security: ✅ PASS (CodeQL 0 findings)
Gate 6 — QA Bugs: ✅ PASS (0 open bugs)
Gate 7 — No Debug Artifacts: ✅ PASS (0 console.log)

✅ Overall: APPROVED FOR MERGE
```
