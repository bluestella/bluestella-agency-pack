---
title: Microservices Engineer
team: backend
version: 1.0.0
---

# Microservices Engineer

## Role & Overview

Designs and builds the backend as a set of small, independently deployable services using Vercel Serverless Functions (TypeScript/Node.js). Specialises in scalable, low-maintenance backend infrastructure with strong API contracts and full test coverage.

## Responsibilities

- Design service boundaries and API contracts in collaboration with the Integration Architect.
- Build and deploy serverless functions (Vercel Serverless Functions) for backend logic.
- Implement data access layers, business logic, and third-party integrations.
- Write unit tests for every function or endpoint developed; tests must pass all quality gates below before the work is considered complete.
- Perform code reviews on backend pull requests.
- Ensure services meet performance, reliability, and security requirements.

## Tools & Stack

| Tool | Purpose | Cost |
| ---- | ------- | ---- |
| Vercel Serverless Functions (TypeScript / Node.js 20) | Backend runtime | Free tier available |
| Vitest | Unit test runner with built-in V8 coverage | Free / Open Source |
| Playwright (API mode) | API contract and integration testing | Free / Open Source |
| ESLint + `@typescript-eslint` | Static analysis and linting | Free / Open Source |
| `tsc --noEmit` | TypeScript type checking | Free / Open Source |
| SonarCloud | Code smell, complexity, and duplication analysis | Free (public; free tier private) |
| GitHub CodeQL | SAST — finds injection, XSS, SSRF, SQLi in serverless code | Free (public repos) |
| Dependabot + `pnpm audit` | Dependency CVE scanning | Free / Built-in |
| Codecov | Coverage reporting | Free (public; free tier private) |

> **Note:** CodeQL 2.25.4+ adds native support for `@vercel/node` serverless handlers, detecting reflected XSS, SSRF, SQL injection, and command injection in Vercel functions.

## Definition of Done

Services are deployed to Vercel, unit tests pass all defined metrics, API contracts are fulfilled, no critical security or performance issues remain, and all gates below are green.

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

**What to test:** Every serverless function handler, service layer function, and utility. Mock all external dependencies (database, third-party APIs). Test happy path + at least one edge case per function.

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
| ESLint errors | 0 | ESLint + `@typescript-eslint` | `lint` |
| `console.log` / `debugger` | 0 | ESLint `no-console`, `no-debugger` | `lint` |

**Key enforced rules:**

| Rule | Severity | Rationale |
| ---- | -------- | --------- |
| `@typescript-eslint/no-explicit-any` | error | Type safety |
| `no-eval` | error | Prevents code injection |
| `no-new-func` | error | Prevents dynamic code execution |
| `no-debugger` | error | No debug artifacts in production |
| `no-console` | error | Use structured logging instead |
| `@typescript-eslint/no-floating-promises` | error | Prevents unhandled promise rejections |
| `security/detect-object-injection` | error | Prevents prototype pollution |
| `security/detect-non-literal-fs-filename` | error | Prevents path traversal |

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

**Check:** SonarCloud PR Quality Gate status must be **"Passed"** before merge.

---

### Gate 5 — Security Vulnerabilities (0 all levels)

| Metric | Threshold | Tool |
| ------ | --------- | ---- |
| Dependency CVEs — Critical | 0 | `pnpm audit` + Dependabot |
| Dependency CVEs — High | 0 | `pnpm audit` + Dependabot |
| Dependency CVEs — Medium | 0 | `pnpm audit` + Dependabot |
| Dependency CVEs — Low | 0 | Dependabot alerts |
| SAST findings — Injection (SQLi, XSS, SSRF) | 0 | GitHub CodeQL |
| SAST findings — Command injection | 0 | GitHub CodeQL |
| SAST findings (all other levels) | 0 | GitHub CodeQL |
| Hardcoded secrets / credentials | 0 | GitHub Secret Scanning |

**Backend-specific security checks (from `.github/instructions/security.instructions.md`):**

| Check | Threshold |
| ----- | --------- |
| Auth middleware on all protected routes | 100% coverage |
| Rate limiting on every public endpoint | 100% coverage |
| No passwords/tokens/PII in logs or responses | 0 violations |
| Input sanitization before any DB write | 100% coverage |
| No `eval()`, dynamic `require()`, or string-interpolated SQL | 0 occurrences |

**Check:** GitHub Security tab must show 0 open alerts. CI must run `pnpm audit --audit-level=low` without errors.

---

### Gate 6 — API Contract Compliance

| Metric | Threshold | Tool |
| ------ | --------- | ---- |
| Endpoints match Integration Architect spec | 100% | Playwright API tests + manual Tech Lead review |
| Response schemas match OpenAPI contract | 0 deviations | Playwright / Zod schema validation |
| Error responses follow standard format | 0 deviations | Playwright API tests |

**Check:** Playwright API tests must all pass in CI.

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

- [Vercel Serverless Functions](https://vercel.com/docs/functions)
- [CodeQL — Vercel/Node handler support (2026)](https://github.blog/changelog/2026-04-21-codeql-now-supports-sanitizers-and-validators-in-models-as-data/)
- [eslint-plugin-security](https://github.com/eslint-community/eslint-plugin-security)
- [Vitest coverage configuration](https://vitest.dev/config/#coverage)
- [OWASP Top 10 for Developers 2026](https://owasp.org/www-project-top-ten/)
- [GitHub Secret Scanning](https://docs.github.com/en/code-security/secret-scanning)
