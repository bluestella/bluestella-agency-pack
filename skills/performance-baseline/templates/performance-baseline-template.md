# Performance Baselines: [Project Name]

## Release: [version] — [YYYY-MM-DD]

### Core Web Vitals & API Latency

| Page / Endpoint | LCP | INP | CLS | p95 API | p99 API |
| --------------- | --- | --- | --- | ------- | ------- |
| /home           |     |     |     | —       | —       |
| /dashboard      |     |     |     | —       | —       |
| /[key-page]     |     |     |     | —       | —       |
| POST /api/[endpoint] | — | — | — |         |         |
| GET /api/[endpoint]  | — | — | — |         |         |

**Thresholds (Google "Good" band):**
- LCP: ≤ 2.5s
- INP: ≤ 200ms
- CLS: ≤ 0.1
- p95 API: ≤ 500ms
- p99 API: ≤ 1000ms

### Load Test Results (k6)

| Scenario | VUs | Duration | Req/s | p95 | p99 | Error Rate |
| -------- | --- | -------- | ----- | --- | --- | ---------- |
| Baseline | 10  | 5 min    |       |     |     |            |
| Stress   | 50  | 10 min   |       |     |     |            |
| Spike    | 200 | 2 min    |       |     |     |            |

### Regressions vs. Previous Release

| Metric | Previous | Current | Delta | Status |
| ------ | -------- | ------- | ----- | ------ |
| /home LCP | | | | ✅ / ⚠️ / ❌ |
| p95 POST /api/orders | | | | ✅ / ⚠️ / ❌ |
