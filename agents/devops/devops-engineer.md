---
title: DevOps / Platform Engineer
team: devops
version: 1.0.0
skills:
  - post-incident-review
  - release-notes
  - performance-baseline
  - bug-report
hooks:
  emits:
    - deployment-failure
    - infrastructure-security-misconfiguration
  receives:
    - deployment-readiness-signal
---

# DevOps / Platform Engineer

## Role & Overview

Owns the CI/CD pipeline, infrastructure-as-code, and deployment strategy. Ensures that code flows from development to production reliably, safely, and quickly — and that every quality gate is enforced automatically so no substandard code can reach production.

## Responsibilities

- Design and maintain CI/CD pipelines (build, lint, type-check, test, security scan, quality gate) aligned with the architecture team's decisions.
- Manage deployments to Vercel (preview and production environments).
- Define and maintain infrastructure-as-code for all environments.
- Monitor production health, set up alerts, and manage incident response.
- Enforce environment parity between development, staging, and production.
- Automate repetitive operational tasks (rollbacks, environment resets, secrets rotation).
- Integrate all quality and security tools into the CI/CD pipeline so gates are enforced on every PR.

## Tools & Stack

| Tool | Purpose | Cost |
| ---- | ------- | ---- |
| GitHub Actions | CI/CD pipeline | Free (2,000 min/month on free tier) |
| Vercel | Preview and production deployments | Free tier available |
| SonarCloud | Code quality gate in CI | Free (public; free tier private) |
| GitHub CodeQL | SAST gate in CI | Free (public repos) |
| Dependabot | Automated dependency CVE PRs | Free / Built-in |
| GitHub Secret Scanning | Secret detection in commits | Free (public repos) |
| `pnpm audit` | Dependency audit gate in CI | Free / Built-in |
| Codecov | Coverage reporting and PR delta | Free (public; free tier private) |
| Lighthouse CI | Core Web Vitals gate in CI | Free / Open Source |
| k6 | Load test gate (pre-production) | Free / Open Source |

## Definition of Done

CI/CD pipeline is green, all quality gates are enforced as mandatory PR checks (branch protection), deployments to all environments are automated, monitoring and alerting are configured, and no secrets are in source code.

---

## Metrics & Scoring Checklist

The DevOps Engineer is responsible for ensuring every gate below is wired into the pipeline and enforced on every PR. The pipeline itself is the enforcement mechanism for the quality standards defined in all other agent cards.

### Gate 1 — CI Pipeline: All Jobs Must Pass

Every PR to `main` must pass all of the following GitHub Actions jobs before merge is allowed (enforced via branch protection rules).

| CI Job | Purpose | Quality Gate |
| ------ | ------- | ------------ |
| `lint` | ESLint — 0 errors | Required |
| `type-check` | TypeScript — 0 compile errors | Required |
| `test` | Vitest — all tests pass, coverage ≥ 90% | Required |
| `sonarcloud` | SonarCloud Quality Gate — Passed | Required |
| `codeql` | CodeQL — 0 security findings | Required |
| `audit` | `pnpm audit --audit-level=low` — 0 CVEs | Required |
| `build` | Build succeeds | Required |

**Branch protection rule requirements:**
- Require all status checks to pass before merging
- Require branches to be up to date before merging
- Dismiss stale pull request approvals when new commits are pushed
- Require at least 1 approving review (Tech Lead)

---

### Gate 2 — Coverage Enforcement ≥ 90%

| Metric | Threshold | Enforcement |
| ------ | --------- | ----------- |
| Statement / Line / Branch / Function coverage | ≥ 90% each | Vitest `coverageThreshold` — CI exits non-zero if breached |
| Coverage delta on PR | No decrease > 2% | Codecov PR comment + optional gate |

**Vitest config (`vitest.config.ts`):**
```ts
coverage: {
  provider: 'v8',
  reporter: ['text', 'lcov', 'html'],
  thresholds: {
    statements: 90,
    lines: 90,
    branches: 90,
    functions: 90,
  },
}
```

**Codecov GitHub Actions step:**
```yaml
- name: Upload coverage to Codecov
  uses: codecov/codecov-action@v4
  with:
    token: ${{ secrets.CODECOV_TOKEN }}
    files: ./coverage/lcov.info
    fail_ci_if_error: true
```

---

### Gate 3 — SonarCloud Quality Gate

| Metric | Threshold |
| ------ | --------- |
| SonarCloud Quality Gate | Must be "Passed" |
| New Blocker issues | 0 |
| New Critical issues | 0 |
| New Major issues | 0 |
| Coverage on new code (SonarCloud view) | ≥ 90% |

**GitHub Actions step:**
```yaml
- name: SonarCloud Scan
  uses: SonarSource/sonarcloud-github-action@master
  env:
    GITHUB_TOKEN: ${{ secrets.GITHUB_TOKEN }}
    SONAR_TOKEN: ${{ secrets.SONAR_TOKEN }}
```

**`sonar-project.properties`:**
```properties
sonar.projectKey=your-org_your-project
sonar.organization=your-org
sonar.sources=src
sonar.tests=src
sonar.test.inclusions=**/*.test.ts,**/*.spec.ts
sonar.javascript.lcov.reportPaths=coverage/lcov.info
sonar.qualitygate.wait=true
```

---

### Gate 4 — Security: CodeQL + Dependabot + pnpm audit

| Metric | Threshold | Enforcement |
| ------ | --------- | ----------- |
| CodeQL — any finding | 0 | GitHub Actions CodeQL workflow (auto-enabled) |
| Dependabot alerts | 0 open | GitHub Security tab; block PR if alerts open |
| `pnpm audit` — any level | 0 | CI job `pnpm audit --audit-level=low` exits non-zero |
| GitHub Secret Scanning | 0 secrets detected | Auto-enabled on repository settings |

**CodeQL GitHub Actions workflow (`.github/workflows/codeql.yml`):**
```yaml
name: CodeQL
on:
  push:
    branches: ["main"]
  pull_request:
    branches: ["main"]
  schedule:
    - cron: '0 2 * * 1'  # Weekly scan on Mondays

jobs:
  analyze:
    name: Analyze TypeScript
    runs-on: ubuntu-latest
    permissions:
      security-events: write
      contents: read
    steps:
      - uses: actions/checkout@v4
      - uses: github/codeql-action/init@v3
        with:
          languages: javascript-typescript
          queries: security-extended
      - uses: github/codeql-action/analyze@v3
```

---

### Gate 5 — Secrets Management (0 secrets in source)

| Metric | Threshold |
| ------ | --------- |
| Hardcoded secrets in source | 0 |
| `.env` files committed to git | 0 |
| Environment variables in Vercel | All secrets externalized |

**Required `.gitignore` entries:**
```
.env
.env.local
.env.*.local
.env.production
```

**Secret rotation:** Vercel environment variables rotated on any suspected exposure. Triggered immediately when GitHub Secret Scanning fires.

---

### Gate 6 — Deployment Health

| Metric | Threshold |
| ------ | --------- |
| Vercel preview deployment | Passes all checks before production promotion |
| Production deployment | Zero downtime (no 5xx spike post-deploy) |
| Rollback capability | Can roll back to previous deployment in < 5 minutes |
| Environment parity | Dev / Staging / Production use the same build artifacts |

---

### Gate 7 — Lighthouse CI (Core Web Vitals in CI)

Run Lighthouse CI on Vercel preview deployments before production promotion.

| Metric | Threshold |
| ------ | --------- |
| Performance score | ≥ 90 |
| LCP | ≤ 2,500ms |
| INP | ≤ 200ms |
| CLS | ≤ 0.1 |

**GitHub Actions step:**
```yaml
- name: Lighthouse CI
  uses: treosh/lighthouse-ci-action@v12
  with:
    urls: |
      ${{ env.VERCEL_PREVIEW_URL }}
    configPath: .lighthouserc.js
    uploadArtifacts: true
```

---

## Complete CI Pipeline Reference

```yaml
# .github/workflows/ci.yml (enhanced)
jobs:
  lint:        → ESLint (0 errors)
  type-check:  → tsc --noEmit (0 errors)
  test:        → Vitest --coverage (≥90% all dimensions, 0 failures)
  audit:       → pnpm audit --audit-level=low (0 CVEs)
  sonarcloud:  → SonarCloud Quality Gate (Passed)
  build:       → pnpm build (0 errors)

# .github/workflows/codeql.yml
  codeql:      → CodeQL security-extended (0 findings)

# .github/workflows/lighthouse.yml (on preview deploy)
  lighthouse:  → Core Web Vitals (all Good)
```

All jobs are required status checks. The `build` job only runs when all other jobs pass.

---

## References

- [GitHub Actions documentation](https://docs.github.com/en/actions)
- [GitHub branch protection rules](https://docs.github.com/en/repositories/configuring-branches-and-merges-in-your-repository/managing-protected-branches/about-protected-branches)
- [SonarCloud GitHub Actions](https://docs.sonarsource.com/sonarqube-cloud/advanced-setup/ci-based-analysis/github-actions-for-sonarqube-cloud/)
- [CodeQL GitHub Actions](https://docs.github.com/en/code-security/code-scanning/creating-an-advanced-setup-for-code-scanning/configuring-advanced-setup-for-code-scanning)
- [Codecov GitHub Action](https://github.com/codecov/codecov-action)
- [Lighthouse CI Action](https://github.com/treosh/lighthouse-ci-action)
- [Vercel GitHub integration](https://vercel.com/docs/deployments/git/vercel-for-github)
- [GitHub Dependabot configuration](https://docs.github.com/en/code-security/dependabot/dependabot-version-updates/configuring-dependabot-version-updates)
