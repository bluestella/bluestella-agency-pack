---
name: test-plan
description: Generates comprehensive test plans covering unit tests, integration tests, API tests, visual regression tests, performance tests, and security tests. Includes test strategy, test cases with acceptance criteria, coverage goals, and success metrics. WHEN: Planning QA for a feature, writing test strategy, defining test scope, ensuring coverage goals, coordinating testing across teams.
---

# Test Plan Skill — Comprehensive QA Test Planning

## Overview

A **Test Plan** defines the testing strategy for a feature, including what to test, how to test it, who tests it, and success criteria. This skill helps QA engineers, automation testing engineers, and development teams plan comprehensive testing across all layers (unit, integration, API, visual, performance, security).

## When to Use This Skill

- **Scenario 1:** Plan QA for a new feature (e.g., OAuth 2.0 login)
- **Scenario 2:** Define end-to-end test scope for a user story
- **Scenario 3:** Coordinate testing across teams (frontend, backend, QA, security)
- **Scenario 4:** Establish coverage goals and success metrics
- **Scenario 5:** Plan regression testing before release

---

## Test Plan Template

### Header

````markdown
# Test Plan: [Feature Name]

**Version:** 1.0  
**Date:** [YYYY-MM-DD]  
**Owner:** [QA Lead]  
**Related Ticket:** [User Story or Epic link]  
**Status:** Draft | Ready for Review | Approved

---

## 1. Objective

[1-2 sentences: What is the goal of this test plan? What feature/system are we testing?]

**Scope:** [What is included/excluded in testing?]

---

## 2. Test Strategy

### Testing Levels

| Level         | Type                          | Tool                          | Owner           | Priority |
| ------------- | ----------------------------- | ----------------------------- | --------------- | -------- |
| Unit          | Component logic, utilities    | Vitest, React Testing Library | Developer       | P0       |
| Integration   | Multiple components, services | Jest, Vitest                  | Developer       | P0       |
| API           | REST endpoints, contracts     | Playwright API, Postman       | QA              | P1       |
| Visual        | UI appearance, layout         | Playwright `toHaveScreenshot` | QA              | P1       |
| E2E           | User workflows, happy path    | Playwright                    | QA              | P1       |
| Performance   | Load, stress, Core Web Vitals | k6, Lighthouse                | Performance Eng | P1       |
| Security      | STRIDE, SAST, dependency scan | CodeQL, pnpm audit            | Security Eng    | P1       |
| Accessibility | WCAG 2.1 AA compliance        | axe-core, jest-axe            | A11y Eng        | P1       |

### Coverage Goals

- Unit test coverage: ≥ 90% (statement, line, branch, function)
- Integration test coverage: ≥ 80%
- E2E critical user journeys: 100%
- API contract coverage: 100% (happy path + errors)
- Security threats identified: 100%
- Accessibility violations: 0 Critical, 0 Serious

---

## 3. Test Cases

### 3.1 Unit Tests

**Component:** [Component Name]

| Test ID | Description                              | Input                                                 | Expected Output                                | Status |
| ------- | ---------------------------------------- | ----------------------------------------------------- | ---------------------------------------------- | ------ |
| U-001   | Test validation on valid input           | {email: "user@example.com", password: "ValidPass123"} | Returns true                                   | TODO   |
| U-002   | Test validation on weak password         | {email: "user@example.com", password: "weak"}         | Returns error "Password too weak"              | TODO   |
| U-003   | Test validation on invalid email         | {email: "invalid", password: "ValidPass123"}          | Returns error "Invalid email"                  | TODO   |
| U-004   | Test state updates after form submission | Submit form with valid data                           | Component state updated, success message shown | TODO   |

**Command:** `pnpm vitest run src/auth.test.ts --coverage`

---

### 3.2 Integration Tests

**Scenario:** User signup flow (frontend + backend)

| Test ID | Description                 | Steps                                                        | Expected Result                                                          | Status |
| ------- | --------------------------- | ------------------------------------------------------------ | ------------------------------------------------------------------------ | ------ |
| I-001   | Signup with new email       | 1. Enter email/password 2. Click Submit 3. Verify email sent | User created, verification email in inbox, redirect to confirmation page | TODO   |
| I-002   | Signup with duplicate email | 1. Try to register with existing email 2. Submit             | Error message: "Email already registered"                                | TODO   |
| I-003   | Verify email link works     | 1. Click verification link from email 2. Check database      | User email_verified = true, can now login                                | TODO   |

**Command:** `pnpm test:integration`

---

### 3.3 API Tests

**Endpoint:** `POST /api/v1/auth/signup`

| Test ID | Description                   | Request                                                     | Expected Response                                        | Status |
| ------- | ----------------------------- | ----------------------------------------------------------- | -------------------------------------------------------- | ------ |
| A-001   | Signup with valid credentials | `{email: "new@example.com", password: "ValidPass123"}`      | 201 Created, user object returned, JWT token             | TODO   |
| A-002   | Signup with missing email     | `{password: "ValidPass123"}`                                | 400 Bad Request, error: "email is required"              | TODO   |
| A-003   | Signup with weak password     | `{email: "new@example.com", password: "weak"}`              | 400 Bad Request, error: "Password must be ≥ 8 chars"     | TODO   |
| A-004   | Signup with duplicate email   | `{email: "existing@example.com", password: "ValidPass123"}` | 409 Conflict, error: "Email already registered"          | TODO   |
| A-005   | Rate limiting test            | Make 10 signup requests from same IP in 1 minute            | First 5 succeed, requests 6-10 get 429 Too Many Requests | TODO   |

**Playwright API Test Template:**

```typescript
test("POST /api/v1/auth/signup - valid credentials", async ({ request }) => {
  const response = await request.post("/api/v1/auth/signup", {
    data: { email: "new@example.com", password: "ValidPass123" },
  });
  expect(response.status()).toBe(201);
  const body = await response.json();
  expect(body.user.email).toBe("new@example.com");
  expect(body.token).toBeDefined();
});
```
````

**Command:** `pnpm test:api`

---

### 3.4 Visual Regression Tests

| Test ID | Component  | Scenario                        | Expected                                     | Status |
| ------- | ---------- | ------------------------------- | -------------------------------------------- | ------ |
| V-001   | SignupForm | Default state (desktop)         | Baseline screenshot                          | TODO   |
| V-002   | SignupForm | Default state (mobile 375px)    | Baseline screenshot                          | TODO   |
| V-003   | SignupForm | Error state (password too weak) | Error message displayed, red border on input | TODO   |
| V-004   | SignupForm | Success state (after submit)    | Loading spinner, then success message        | TODO   |
| V-005   | SignupForm | Focus state (keyboard nav)      | Blue focus outline visible                   | TODO   |

**Command:** `pnpm test:visual -- --update` (to capture baselines), then `pnpm test:visual` (to compare)

---

### 3.5 End-to-End Tests

| Test ID | User Journey              | Steps                                                                                                               | Expected Result                                     | Status |
| ------- | ------------------------- | ------------------------------------------------------------------------------------------------------------------- | --------------------------------------------------- | ------ |
| E-001   | Happy path signup         | 1. Visit signup page 2. Enter email/password 3. Submit 4. Check email 5. Click verify link 6. Redirect to dashboard | User created, verified, logged in, dashboard loaded | TODO   |
| E-002   | Signup error recovery     | 1. Enter invalid email 2. See error 3. Correct email 4. Submit 5. Success                                           | Form persists valid data, allows re-submission      | TODO   |
| E-003   | Verification email resend | 1. Signup 2. Wait for email 3. Click "Resend email" 4. Check inbox                                                  | Two verification emails sent, both links work       | TODO   |

**Command:** `pnpm test:e2e`

---

### 3.6 Performance Tests

| Test ID | Scenario                              | Baseline SLA                        | Threshold                    | Tool          |
| ------- | ------------------------------------- | ----------------------------------- | ---------------------------- | ------------- |
| P-001   | POST /signup — p95 latency            | ≤ 500ms                             | p95 ≤ 600ms (acceptable)     | k6            |
| P-002   | Signup page load (Lighthouse) — LCP   | ≤ 2.5s                              | ≤ 3s (acceptable)            | Lighthouse CI |
| P-003   | Signup page — CLS                     | ≤ 0.1                               | ≤ 0.15 (acceptable)          | Lighthouse    |
| P-004   | Stress test: 1,000 concurrent signups | System handles with < 1% error rate | < 2% error rate (acceptable) | k6            |

**Command:** `pnpm test:performance`

---

### 3.7 Security Tests

| Test ID | Threat Category              | Test Description                  | Expected Result                                 | Status |
| ------- | ---------------------------- | --------------------------------- | ----------------------------------------------- | ------ |
| S-001   | STRIDE:Tampering             | SQLi in email field               | Query rejected, logged                          | TODO   |
| S-002   | STRIDE:InformationDisclosure | Password visible in logs          | Password not logged, redacted in all logs       | TODO   |
| S-003   | STRIDE:ElevationOfPrivilege  | JWT token forgery                 | Invalid token rejected, request denied          | TODO   |
| S-004   | SCA: Dependency CVE          | High-severity CVE in node_modules | Dependency updated or mitigated, build succeeds | TODO   |
| S-005   | SAST: Hardcoded secrets      | Source code scanned for API keys  | 0 secrets found                                 | TODO   |

**Command:** `pnpm audit --audit-level=low`, `pnpm test:security` (CodeQL)

---

### 3.8 Accessibility Tests

| Test ID | WCAG Criterion             | Test Description                    | Expected Result                                | Status |
| ------- | -------------------------- | ----------------------------------- | ---------------------------------------------- | ------ |
| A-001   | 1.4.3 Contrast             | Text contrast ratio                 | ≥ 4.5:1 normal / ≥ 3:1 large                   | TODO   |
| A-002   | 1.4.11 Non-text Contrast   | Focus indicator visible             | Focus outline ≥ 3:1 contrast                   | TODO   |
| A-003   | 2.1.1 Keyboard             | All form inputs keyboard accessible | Tab order logical, Enter submits, Esc cancels  | TODO   |
| A-004   | 2.1.2 No Keyboard Trap     | Focus can leave any element         | No infinite loop when tabbing                  | TODO   |
| A-005   | 2.4.3 Focus Order          | Focus order matches visual order    | Tab order matches left-to-right, top-to-bottom | TODO   |
| A-006   | 3.3.1 Error Identification | Error messages announce             | Screen reader announces errors                 | TODO   |
| A-007   | 4.1.2 Name, Role, Value    | Form labels associated              | `<label>` linked to input, ARIA labels present | TODO   |

**Command:** `pnpm test:a11y`

---

## 4. Test Execution Plan

### Timeline

| Phase             | Dates          | Owner           | Deliverable                 |
| ----------------- | -------------- | --------------- | --------------------------- |
| Unit tests        | Sprint Day 1-3 | Developer       | Tests ≥ 90% coverage        |
| Integration tests | Sprint Day 3-4 | Developer + QA  | Integration suite passing   |
| API tests         | Sprint Day 4-5 | QA              | API contract tests ✅       |
| Visual tests      | Sprint Day 5   | QA              | Visual baseline established |
| E2E tests         | Sprint Day 5-6 | QA              | E2E flows passing           |
| Performance tests | Sprint Day 6   | Performance Eng | Performance SLAs met        |
| Security tests    | Sprint Day 6   | Security Eng    | 0 SAST/CVE findings         |
| A11y tests        | Sprint Day 6   | A11y Eng        | 0 Critical violations       |
| Regression tests  | Sprint Day 6   | QA              | Previous features working   |

---

## 5. Success Criteria

- [ ] Unit test coverage ≥ 90%
- [ ] All unit, integration, API tests passing
- [ ] Visual regression baseline captured
- [ ] E2E happy path passing
- [ ] Performance SLAs met (p95 ≤ 500ms, CWV ≤ thresholds)
- [ ] 0 STRIDE threats unmitigated
- [ ] 0 SAST/CVE findings
- [ ] 0 Critical or Serious a11y violations
- [ ] Regression tests passing (existing features not broken)
- [ ] Tech Lead approval on all gates

---

## 6. Known Issues & Blockers

| Issue                                 | Impact                    | Resolution                                         |
| ------------------------------------- | ------------------------- | -------------------------------------------------- |
| Email service may be slow in test env | 30-second delays in I-003 | Mock email service in tests; verify in staging     |
| Visual regression diffs hard to debug | May have false positives  | Use Playwright Inspector, keep browser open        |
| k6 load test requires staging env     | Can't run in isolated CI  | Schedule performance tests for EOD (lower CI load) |

---

## 7. Sign-Off

- [ ] QA Lead: ****\_\_**** Date: **\_\_**
- [ ] Dev Lead: ****\_\_**** Date: **\_\_**
- [ ] Tech Lead: ****\_\_**** Date: **\_\_**

```

---

## Test Plan Best Practices

1. **Tie tests to acceptance criteria:** Every user story AC should have a test case
2. **Use test IDs:** U-001, I-002, A-003 make it easy to reference failing tests
3. **Include error paths:** Not just happy path; test all error scenarios
4. **Define success metrics upfront:** "Coverage ≥ 90%" is clearer than "Good coverage"
5. **Assign owners:** Who runs each test? Who fixes failures?
6. **Plan for regression:** Don't just test new features; verify old features still work
7. **Use test data:** Create realistic test data (use factories, fixtures)
8. **Document blockers:** What prevents testing? Email service? Third-party API?
9. **Include performance from day 1:** Don't add performance tests at the end
10. **Security and a11y aren't optional:** Build them into the test plan, not as afterthoughts

---

## References

- [Testing Trophy](https://kentcdodds.com/blog/the-testing-trophy-and-testing-javascript) — Balance of test types
- [Test Pyramid](https://martinfowler.com/articles/testing-strategies.html) — How many of each test?
- [WCAG 2.1 Testing](https://www.w3.org/WAI/test-evaluate/) — A11y testing standards
- [OWASP Testing Guide](https://owasp.org/www-project-web-security-testing-guide/) — Security testing
```
