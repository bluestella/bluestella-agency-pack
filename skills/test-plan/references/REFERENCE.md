# Test Plan — Reference Guide

## Testing Trophy (Kent C. Dodds)

Recommended test distribution from bottom to top of the "trophy":
- **Static** (most): TypeScript + ESLint — catches errors without running code
- **Unit** (many): pure functions, isolated components
- **Integration** (medium): multiple components/services working together
- **E2E** (few): critical user journeys only — slow and expensive

Avoid the pure "Test Pyramid" dogma — integration tests often give the best ROI.

## Coverage Thresholds

| Level         | Minimum | Ideal | Notes                                          |
| ------------- | ------- | ----- | ---------------------------------------------- |
| Unit          | 80%     | 90%   | Statement, line, branch, function all tracked  |
| Integration   | 70%     | 80%   | Focus on module boundaries                     |
| API contracts | 100%    | 100%  | Every endpoint: happy path + every error code  |
| E2E critical  | 100%    | 100%  | Every critical user journey must have an E2E   |
| A11y          | 0 Crit  | 0 Ser | Zero tolerance for Critical + Serious violations|

## Test Command Reference

```bash
# Unit
pnpm vitest run --coverage                    # Run with coverage report
pnpm vitest run src/auth.test.ts              # Run single file

# Integration
pnpm test:integration                          # Custom script in package.json

# API (Playwright)
pnpm playwright test --project=api            # API project

# Visual regression (Playwright)
pnpm playwright test --project=visual         # Compare
pnpm playwright test --update-snapshots       # Update baselines

# E2E (Playwright)
pnpm playwright test                          # All E2E
pnpm playwright test --headed                 # With browser visible (debug)

# Performance (k6)
k6 run scripts/load-test.js                   # Run load test
k6 run --vus=100 --duration=30s scripts/...   # 100 virtual users, 30s

# Security
pnpm audit --audit-level=high                 # CVE check
gh run list --workflow=codeql-analysis.yml    # SAST results

# A11y (jest-axe)
pnpm test:a11y                                # Run axe-core checks
```

## Playwright API Test Pattern

```typescript
import { test, expect } from '@playwright/test';

test('POST /auth/signup - valid credentials', async ({ request }) => {
  const response = await request.post('/api/v1/auth/signup', {
    data: { email: 'new@example.com', password: 'ValidPass123' },
  });
  expect(response.status()).toBe(201);
  const body = await response.json();
  expect(body.success).toBe(true);
  expect(body.data.email).toBe('new@example.com');
});
```

## WCAG 2.1 AA Key Criteria

| Criterion      | Rule                                | Test Method                     |
| -------------- | ----------------------------------- | ------------------------------- |
| 1.4.3 Contrast | Text: ≥4.5:1; Large text: ≥3:1      | axe-core, Colour Contrast Analyser |
| 2.1.1 Keyboard | All functionality keyboard accessible | Manual tab + enter test        |
| 2.4.3 Focus    | Focus order is logical              | Tab through the page            |
| 3.3.1 Errors   | Errors are described in text        | Try invalid input, check message |
| 4.1.2 Names    | All controls have accessible names  | axe-core                        |

## External References

- [Kent C. Dodds: Testing Trophy](https://kentcdodds.com/blog/the-testing-trophy-and-testing-javascript)
- [Playwright Documentation](https://playwright.dev/)
- [k6 Load Testing](https://k6.io/docs/)
- [WCAG 2.1 Quick Reference](https://www.w3.org/WAI/WCAG21/quickref/)
- [OWASP Testing Guide](https://owasp.org/www-project-web-security-testing-guide/)
