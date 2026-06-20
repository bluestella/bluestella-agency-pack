---
title: React Native Engineer
team: frontend
version: 1.0.0
---

# React Native Engineer

## Role & Overview

Builds and maintains the mobile application using React Native and Expo (TypeScript). Responsible for cross-platform (iOS/Android) performance, native integrations, and mobile UX.

## Responsibilities

- Develop cross-platform mobile screens and components in React Native + Expo (TypeScript).
- Integrate with device-native features (camera, push notifications, biometrics).
- Ensure consistent performance and UX across iOS and Android.
- Write unit tests and perform platform-specific QA.
- Coordinate with the React Engineer to share logic and design tokens where possible.

## Tools & Stack

| Tool | Purpose | Cost |
| ---- | ------- | ---- |
| React Native + Expo (TypeScript) | Mobile framework | Free / Open Source |
| Vitest + React Native Testing Library (RNTL) | Unit and integration testing | Free / Open Source |
| Detox or Maestro | Mobile E2E testing | Free / Open Source |
| ESLint + `@typescript-eslint` | Static analysis and linting | Free / Open Source |
| `tsc --noEmit` | TypeScript type checking | Free / Open Source |
| SonarCloud | Code smell and quality analysis | Free (public; free tier private) |
| GitHub CodeQL | SAST security scanning | Free (public repos) |
| Dependabot + `pnpm audit` | Dependency vulnerability scanning | Free / Built-in |
| Codecov | Coverage reporting in CI and PRs | Free (public; free tier private) |

## Definition of Done

Screens are tested on both iOS and Android, native integrations are verified, all gates in the Metrics & Scoring Checklist are passing, and no platform-specific regressions are introduced.

---

## Metrics & Scoring Checklist

All gates must pass before a PR is approved. The Tech Lead verifies this checklist on every review. Any failing gate results in a bug ticket and reassignment.

### Gate 1 — Unit Test Coverage ≥ 90%

| Metric | Threshold | Tool | CI Job |
| ------ | --------- | ---- | ------ |
| Statement coverage | ≥ 90% | Vitest + RNTL | `test` |
| Line coverage | ≥ 90% | Vitest | `test` |
| Branch coverage | ≥ 90% | Vitest | `test` |
| Function coverage | ≥ 90% | Vitest | `test` |

**What to test:** Every screen component, hook, and utility. Use React Native Testing Library to test rendered output and user interactions (press, swipe, input).

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
| `react-native/no-raw-text` | error | i18n and a11y compliance |
| `react-native/no-color-literals` | warn | Theming consistency |

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
| SAST findings (all levels) | 0 | GitHub CodeQL |
| Hardcoded secrets / API keys | 0 | GitHub Secret Scanning |

**Mobile-specific security checks:**

| Check | Threshold |
| ----- | --------- |
| No hardcoded API endpoints in source | 0 | Use `expo-constants` or env vars |
| Sensitive storage uses `expo-secure-store` | Required | Never use `AsyncStorage` for secrets |
| Biometric auth follows Expo best practices | Required | Per Expo documentation |

**Check:** GitHub Security tab must show 0 open alerts. CI must run `pnpm audit --audit-level=low` without errors.

---

### Gate 6 — Platform Compatibility

| Metric | Threshold |
| ------ | --------- |
| iOS build passes | 0 errors | EAS build or local `npx expo run:ios` |
| Android build passes | 0 errors | EAS build or local `npx expo run:android` |
| Platform-specific regressions | 0 | Detox / Maestro E2E tests |

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

- [React Native Testing Library](https://callstack.github.io/react-native-testing-library/)
- [Expo Security best practices](https://docs.expo.dev/guides/security/)
- [expo-secure-store](https://docs.expo.dev/versions/latest/sdk/securestore/)
- [Detox E2E testing](https://wix.github.io/Detox/)
- [Maestro mobile E2E](https://maestro.mobile.dev/)
- [Vitest coverage configuration](https://vitest.dev/config/#coverage)
- [GitHub CodeQL for JS/TS](https://docs.github.com/en/code-security/code-scanning/managing-your-code-scanning-configuration/javascript-typescript-built-in-queries)
