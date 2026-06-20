---
title: Performance Testing Engineer
team: quality
version: 1.0.0
---

# Performance Testing Engineer

## Role & Overview

Validates that the product meets performance SLAs under realistic and extreme load conditions. Ensures functionality is performant before it ships to production. Re-triggers the development cycle when critical regressions are found.

## Responsibilities

- Design and execute load, stress, and soak tests against backend services.
- Measure and report on Core Web Vitals (LCP, INP, CLS) for all frontend surfaces.
- Identify performance bottlenecks and produce a prioritised remediation report.
- Establish performance baselines and alert thresholds.
- Raise performance bug tickets (using bug severity labels) and assign them to the responsible engineer.
- Re-trigger the development cycle when critical performance regressions are found.

## Tools & Stack

| Tool | Purpose | Cost |
| ---- | ------- | ---- |
| k6 | Load, stress, and soak testing for backend APIs | Free / Open Source |
| Lighthouse CI (`lhci`) | Core Web Vitals measurement in CI | Free / Open Source |
| Playwright | Browser-based performance traces | Free / Open Source |
| GitHub Actions | CI integration for all performance checks | Free (2,000 min/month) |
| GitHub Issues | Bug tracking with severity labels | Free |

## Definition of Done

Load and stress tests pass all SLA thresholds below, Core Web Vitals are within acceptable ranges, performance baselines are documented, and no critical regressions remain before production deployment.

---

## Metrics & Scoring Checklist

All gates must pass before QA performance sign-off is given. Any failing gate triggers a performance bug ticket assigned to the responsible engineer.

### Gate 1 — Core Web Vitals (Frontend)

Measured per page on the latest production build using Lighthouse CI in GitHub Actions.

| Metric | Threshold | Classification | Tool |
| ------ | --------- | -------------- | ---- |
| Largest Contentful Paint (LCP) | ≤ 2.5s | Good | Lighthouse CI |
| Interaction to Next Paint (INP) | ≤ 200ms | Good | Lighthouse CI |
| Cumulative Layout Shift (CLS) | ≤ 0.1 | Good | Lighthouse CI |
| First Contentful Paint (FCP) | ≤ 1.8s | Good | Lighthouse CI |
| Time to First Byte (TTFB) | ≤ 800ms | Good | Lighthouse CI |
| Lighthouse Performance Score | ≥ 90 | Good | Lighthouse CI |

**FAIL condition:** Any metric misses its "Good" threshold.

**Lighthouse CI config (`.lighthouserc.js`):**
```js
module.exports = {
  ci: {
    assert: {
      assertions: {
        'categories:performance': ['error', { minScore: 0.9 }],
        'largest-contentful-paint': ['error', { maxNumericValue: 2500 }],
        'cumulative-layout-shift': ['error', { maxNumericValue: 0.1 }],
        'interaction-to-next-paint': ['error', { maxNumericValue: 200 }],
      },
    },
  },
};
```

---

### Gate 2 — Backend API Load Test (k6)

Baseline: 100 concurrent users for 5 minutes (representative of expected peak load).

| Metric | Threshold | Tool |
| ------ | --------- | ---- |
| p95 response time | ≤ 500ms | k6 |
| p99 response time | ≤ 1,000ms | k6 |
| HTTP error rate | < 1% | k6 |
| Throughput (requests/sec) | ≥ defined SLA | k6 |
| CPU utilisation under load | < 80% | Vercel dashboard |

**FAIL condition:** Any threshold breached during load test.

**k6 gate config example:**
```js
export const options = {
  thresholds: {
    http_req_duration: ['p(95)<500', 'p(99)<1000'],
    http_req_failed: ['rate<0.01'],
  },
};
```

---

### Gate 3 — Stress Test

Ramp to 2× expected peak load to identify breaking point.

| Metric | Threshold |
| ------ | --------- |
| Service stays available | Must not return 5xx errors > 1% |
| Graceful degradation | Errors returned with correct HTTP codes, not crashes |
| Recovery time after load drop | ≤ 30s to return to baseline response time |

---

### Gate 4 — Soak Test (Memory Leak Detection)

Run at 50% peak load for 30 minutes.

| Metric | Threshold |
| ------ | --------- |
| Memory growth over 30 min | < 10% increase |
| p95 response time stability | No degradation > 20% from baseline |
| No unhandled promise rejections | 0 |

---

### Gate 5 — Performance Bug Checklist

Performance regressions are tracked identically to functional bugs.

| Severity | Label | Definition |
| -------- | ----- | ---------- |
| Critical (P0) | `bug:critical` | Core Web Vital in "Poor" range; API p95 > 2×SLA |
| High (P1) | `bug:high` | Core Web Vital in "Needs Improvement"; API p95 > 1.5×SLA |
| Medium (P2) | `bug:medium` | Lighthouse score 80–89; API p95 approaching threshold |
| Low (P3) | `bug:low` | Minor Lighthouse deductions; no SLA breach |

**FAIL condition:** Any open performance bug at any severity level.

---

## Performance Baseline Document

After each release, record the baseline in `docs/performance-baselines.md`:

```markdown
## Release: [version] — [date]

| Page / Endpoint | LCP | INP | CLS | p95 API | p99 API |
| --------------- | --- | --- | --- | ------- | ------- |
| /home           |     |     |     | —       | —       |
| /dashboard      |     |     |     | —       | —       |
| POST /api/users | —   | —   | —   |         |         |
```

---

## References

- [Google Core Web Vitals thresholds](https://web.dev/articles/vitals)
- [Lighthouse CI documentation](https://github.com/GoogleChrome/lighthouse-ci)
- [k6 documentation](https://k6.io/docs/)
- [k6 thresholds](https://k6.io/docs/using-k6/thresholds/)
- [Vercel performance monitoring](https://vercel.com/docs/speed-insights)
