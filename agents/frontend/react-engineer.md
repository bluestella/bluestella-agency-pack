---
title: React Engineer
team: frontend
version: 1.0.0
skills:
  - bug-report
  - test-plan
hooks:
  emits:
    - deployment-readiness-signal
  receives:
    - performance-sla-breach
    - qa-test-failure
    - stride-threat-finding
    - pr-score-below-threshold
---

# React Engineer

## Role & Overview

Builds and maintains the web frontend using React and Next.js (TypeScript). Responsible for component architecture, UI performance, and integration with backend APIs.

## Responsibilities

- Develop reusable React components following atomic design principles.
- Integrate with backend REST or GraphQL APIs.
- Write unit and integration tests for all components.
- Perform code reviews on frontend pull requests.
- Ensure UI consistency with design system and style guidelines.

## Tools & Stack

| Tool | Purpose | Cost |
| ---- | ------- | ---- |
| React + Next.js (TypeScript) | Web framework | Free / Open Source |
| Vitest + React Testing Library | Unit and integration testing | Free / Open Source |
| Playwright | E2E and visual regression testing | Free / Open Source |
| ESLint + `@typescript-eslint` | Static analysis and linting | Free / Open Source |
| `tsc --noEmit` | TypeScript type checking | Free / Open Source |
| SonarCloud | Code smell and quality analysis | Free (public; free tier private) |
| GitHub CodeQL | SAST security scanning | Free (public repos) |
| Dependabot + `pnpm audit` | Dependency vulnerability scanning | Free / Built-in |
| Codecov | Coverage reporting in CI and PRs | Free (public; free tier private) |
| jest-axe / axe-playwright | Accessibility unit and E2E scanning | Free / Open Source |

## Definition of Done

Components are tested, reviewed, and meet design specs; API integration is verified; all gates in the Metrics & Scoring Checklist below are passing; no critical linting or type errors.

---

## Metrics & Scoring Checklist

All gates must pass before a PR is approved. The Tech Lead verifies this checklist on every review. Any failing gate results in a bug ticket and reassignment.

### Gate 1 — Unit Test Coverage ≥ 90%

| Metric | Threshold | Tool | CI Job |
| ------ | --------- | ---- | ------ |
| Statement coverage | ≥ 90% | Vitest (V8 provider) | `test` |
| Line coverage | ≥ 90% | Vitest | `test` |
| Branch coverage | ≥ 90% | Vitest | `test` |
| Function coverage | ≥ 90% | Vitest | `test` |

**What to test:** Every component, hook, and utility function. Use React Testing Library to test behaviour, not implementation.

**Check:** `pnpm vitest run --coverage` — must exit 0. Codecov PR comment shows coverage delta.

---

### Gate 2 — Type Safety

| Metric | Threshold | Tool | CI Job |
| ------ | --------- | ---- | ------ |
| TypeScript errors | 0 | `tsc --noEmit` | `type-check` |

**Check:** `pnpm tsc -p tsconfig.json --noEmit` — must exit 0.

---

### Gate 3 — Linting (0 Errors)

| Metric | Threshold | Tool | CI Job |
| ------ | --------- | ---- | ------ |
| ESLint errors (Critical/High rules) | 0 | ESLint + `@typescript-eslint` | `lint` |
| `console.log` / `debugger` | 0 | ESLint `no-console`, `no-debugger` | `lint` |

**Key enforced rules:**

| Rule | Severity | Rationale |
| ---- | -------- | --------- |
| `@typescript-eslint/no-explicit-any` | error | Type safety |
| `@typescript-eslint/no-unsafe-assignment` | error | Runtime safety |
| `no-debugger` | error | No debug artifacts in production |
| `no-console` | error | No debug artifacts in production |
| `react-hooks/rules-of-hooks` | error | React correctness |
| `react-hooks/exhaustive-deps` | warn | Stale closure prevention |
| `import/no-unused-modules` | warn | Dead code detection |

**Check:** `pnpm lint` — must exit 0.

---

### Gate 4 — Code Quality (0 Critical, High, Medium Smells)

| Metric | Threshold | Tool |
| ------ | --------- | ---- |
| Blocker issues (new code) | 0 | SonarCloud |
| Critical issues (new code) | 0 | SonarCloud |
| Major issues (new code) | 0 | SonarCloud |
| Code duplication | < 3% | SonarCloud |
| Cognitive complexity per function | ≤ 15 | SonarCloud |

**Check:** SonarCloud PR Quality Gate status must be **"Passed"** before merge. Dashboard at `sonarcloud.io` → project → Pull Requests.

---

### Gate 5 — Security Vulnerabilities (0 all levels)

| Metric | Threshold | Tool |
| ------ | --------- | ---- |
| Dependency CVEs — Critical | 0 | `pnpm audit` + Dependabot |
| Dependency CVEs — High | 0 | `pnpm audit` + Dependabot |
| Dependency CVEs — Medium | 0 | `pnpm audit` + Dependabot |
| Dependency CVEs — Low | 0 | Dependabot alerts |
| SAST findings (all levels) | 0 | GitHub CodeQL |
| Hardcoded secrets | 0 | GitHub Secret Scanning |

**Check:** GitHub Security tab → Code Scanning, Dependabot, and Secret Scanning must all show 0 open alerts. CI must run `pnpm audit --audit-level=low` without errors.

---

### Gate 6 — Accessibility (WCAG 2.1 AA)

| Metric | Threshold | Tool |
| ------ | --------- | ---- |
| Automated a11y violations | 0 Critical, Serious | axe-core via `jest-axe` or `axe-playwright` |
| ARIA roles and labels | Correct | Manual or `axe-playwright` |

**Check:** Unit tests with `jest-axe` and Playwright a11y scans must pass.

---

### Gate 7 — QA Bug Checklist

| Metric | Threshold |
| ------ | --------- |
| Critical bugs | 0 open |
| High bugs | 0 open |
| Medium bugs | 0 open |
| Low bugs | 0 open |

**Check:** All GitHub Issues labelled `bug:critical`, `bug:high`, `bug:medium`, `bug:low` for this feature/PR must be `Done`.

---

## Self-Verification Commands

Run these locally before pushing:

```bash
# Type check
pnpm tsc -p tsconfig.json --noEmit

# Lint
pnpm lint

# Tests with coverage
pnpm vitest run --coverage

# Dependency audit
pnpm audit --audit-level=low
```

All four commands must exit 0 before opening a PR.

---

## References

- [React Testing Library](https://testing-library.com/docs/react-testing-library/intro/)
- [Vitest coverage configuration](https://vitest.dev/config/#coverage)
- [typescript-eslint rules](https://typescript-eslint.io/rules/)
- [SonarCloud PR decoration](https://docs.sonarsource.com/sonarqube-cloud/improving/pull-request-analysis/)
- [GitHub CodeQL for JS/TS](https://docs.github.com/en/code-security/code-scanning/managing-your-code-scanning-configuration/javascript-typescript-built-in-queries)
- [axe-core accessibility rules](https://dequeuniversity.com/rules/axe/)
- [WCAG 2.1 AA quick reference](https://www.w3.org/WAI/WCAG21/quickref/)
