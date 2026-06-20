# Test Plan: [Feature Name]

**Version:** 1.0
**Date:** [YYYY-MM-DD]
**Owner:** [QA Lead]
**Related Ticket:** [User Story or Epic link]
**Status:** Draft | Ready for Review | Approved

---

## 1. Objective

[1–2 sentences: What feature is being tested and why does this test plan exist?]

**In scope:** [What's being tested]
**Out of scope:** [What's explicitly excluded and why]

---

## 2. Test Strategy

| Level         | Type                          | Tool                          | Owner              | Priority |
| ------------- | ----------------------------- | ----------------------------- | ------------------ | -------- |
| Unit          | Component logic, utilities    | Vitest / Jest                 | Developer          | P0       |
| Integration   | Multi-component flows         | Vitest / Jest                 | Developer          | P0       |
| API           | Endpoints, contracts          | Playwright API / Postman      | QA                 | P1       |
| Visual        | UI screenshots, layout        | Playwright `toHaveScreenshot` | QA                 | P1       |
| E2E           | Full user journeys            | Playwright                    | QA                 | P1       |
| Performance   | Load, latency, Core Web Vitals| k6, Lighthouse CI             | Performance Eng    | P1       |
| Security      | STRIDE, SAST, dependencies    | CodeQL, pnpm audit            | Security Eng       | P1       |
| Accessibility | WCAG 2.1 AA                   | axe-core, jest-axe            | A11y Eng / QA      | P1       |

**Coverage Goals:**
- Unit: ≥ 90% (statement, line, branch, function)
- Integration: ≥ 80%
- API contracts: 100% (happy path + all error responses)
- Critical E2E journeys: 100%
- Security threats: 100% identified, all Critical mitigated
- A11y violations: 0 Critical, 0 Serious

---

## 3. Test Cases

### 3.1 Unit Tests

| Test ID | Description                   | Input                            | Expected Output              | Status |
| ------- | ----------------------------- | -------------------------------- | ---------------------------- | ------ |
| U-001   | [Test name]                   | [Input value or state]           | [Expected return or behavior]| TODO   |
| U-002   | [Error case — invalid input]  | [Invalid input]                  | [Error message/exception]    | TODO   |

**Command:** `pnpm vitest run [file] --coverage`

---

### 3.2 Integration Tests

| Test ID | Description                   | Steps                            | Expected Result              | Status |
| ------- | ----------------------------- | -------------------------------- | ---------------------------- | ------ |
| I-001   | [Happy path scenario]         | [1. Step 2. Step]                | [Expected outcome]           | TODO   |
| I-002   | [Error scenario]              | [Steps that trigger error]       | [Error handled correctly]    | TODO   |

**Command:** `pnpm test:integration`

---

### 3.3 API Tests

**Endpoint:** `[METHOD] /api/v1/[path]`

| Test ID | Description                   | Request                          | Expected Response            | Status |
| ------- | ----------------------------- | -------------------------------- | ---------------------------- | ------ |
| A-001   | Happy path                    | `{valid request body}`           | 200/201 + expected schema    | TODO   |
| A-002   | Missing required field        | `{body missing required field}`  | 400 + VALIDATION_ERROR       | TODO   |
| A-003   | Unauthorized access           | No auth header                   | 401 + UNAUTHORIZED           | TODO   |
| A-004   | Duplicate / conflict          | `{request causing conflict}`     | 409 + CONFLICT               | TODO   |
| A-005   | Rate limit                    | N+1 requests in rate limit window| 429 + RATE_LIMITED           | TODO   |

**Command:** `pnpm test:api`

---

### 3.4 Visual Regression Tests

| Test ID | Component      | Scenario              | Expected                   | Status |
| ------- | -------------- | --------------------- | -------------------------- | ------ |
| V-001   | [Component]    | Default state         | Baseline screenshot        | TODO   |
| V-002   | [Component]    | Error state           | Error UI displayed         | TODO   |
| V-003   | [Component]    | Mobile (375px)        | Mobile layout correct      | TODO   |

**Command:** `pnpm test:visual` (compare), `pnpm test:visual -- --update` (capture baselines)

---

### 3.5 End-to-End Tests

| Test ID | User Journey              | Steps                            | Expected Result              | Status |
| ------- | ------------------------- | -------------------------------- | ---------------------------- | ------ |
| E-001   | Happy path                | [Full journey steps]             | [User achieves goal]         | TODO   |
| E-002   | Error recovery            | [Error then correction]          | [User can recover and retry] | TODO   |

**Command:** `pnpm test:e2e`

---

### 3.6 Performance Tests

| Test ID | Scenario               | SLA             | Tool       | Status |
| ------- | ---------------------- | --------------- | ---------- | ------ |
| P-001   | p95 response time      | ≤ 500ms         | k6         | TODO   |
| P-002   | Concurrent users       | 0% error at 1K  | k6         | TODO   |
| P-003   | LCP (page load)        | ≤ 2.5s          | Lighthouse | TODO   |

**Command:** `pnpm test:performance`

---

### 3.7 Security Tests

| Test ID | STRIDE Category    | Description                  | Expected Result              | Status |
| ------- | ------------------ | ---------------------------- | ---------------------------- | ------ |
| S-001   | Tampering          | SQLi in input fields         | Query rejected, logged       | TODO   |
| S-002   | Info Disclosure    | Check password not in logs   | Password absent from logs    | TODO   |
| S-003   | SCA                | `pnpm audit --audit-level=high` | 0 high/critical CVEs      | TODO   |

**Command:** `pnpm audit`, `pnpm test:security` (CodeQL)

---

### 3.8 Accessibility Tests

| Test ID | WCAG Criterion     | Description                  | Expected Result              | Status |
| ------- | ------------------ | ---------------------------- | ---------------------------- | ------ |
| AX-001  | 1.4.3 Contrast     | Text contrast ratio          | ≥ 4.5:1                      | TODO   |
| AX-002  | 2.1.1 Keyboard     | All interactive elements     | Full keyboard navigation     | TODO   |
| AX-003  | 4.1.2 Name/Role    | Form labels linked           | axe-core 0 critical/serious  | TODO   |

**Command:** `pnpm test:a11y`

---

## 4. Execution Timeline

| Phase          | Sprint Day   | Owner          | Deliverable                    |
| -------------- | ------------ | -------------- | ------------------------------ |
| Unit + Integ   | Day 1–3      | Developer      | ≥ 90% unit coverage            |
| API tests      | Day 4–5      | QA             | All API contracts tested       |
| Visual + E2E   | Day 5–6      | QA             | Baselines + E2E flows passing  |
| Performance    | Day 6        | Performance Eng| SLAs verified                  |
| Security       | Day 6        | Security Eng   | 0 SAST/CVE findings            |
| A11y           | Day 6        | A11y Eng / QA  | 0 Critical violations          |
| Regression     | Day 6        | QA             | Existing features unaffected   |

---

## 5. Success Criteria

- [ ] Unit coverage ≥ 90%
- [ ] All unit, integration, and API tests passing
- [ ] Visual baseline captured; no unexpected diffs
- [ ] E2E critical journey(s) passing
- [ ] Performance SLAs met
- [ ] 0 unmitigated STRIDE threats
- [ ] 0 SAST findings / 0 high+ CVEs
- [ ] 0 Critical or Serious a11y violations
- [ ] Regression suite passing (no existing feature broken)
- [ ] Tech Lead sign-off

---

## 6. Known Issues & Blockers

| Issue                              | Impact                    | Resolution                             |
| ---------------------------------- | ------------------------- | -------------------------------------- |
| [e.g., Staging env not available]  | [Blocks E2E]              | [Request infra access by Day 3]        |

---

## 7. Sign-Off

- [ ] QA Lead: ______________ Date: ______
- [ ] Dev Lead: ______________ Date: ______
- [ ] Tech Lead: ______________ Date: ______
