---
applyTo: "{tests/**,**/*.test.*,**/*.spec.*}"
title: "Testing Standards"
description: "Enforce test structure, coverage requirements, and quality practices"
---

## Test Naming & Structure

### Naming Convention: [Unit]_[Scenario]_[Expected_Outcome]

**Examples:**

- ✅ `userRepository_findById_returnsUser`
- ✅ `userRepository_findById_throwsIfNotFound`
- ✅ `calculateDiscount_appliesSeasonsalRate_whenDateInPromotion`
- ✅ `calculateDiscount_appliesNoDiscount_whenDateOutsidePromotion`

### Arrange / Act / Assert (AAA) Structure

```typescript
describe("calculateDiscount", () => {
  it("calculateDiscount_appliesSeasonsalRate_whenDateInPromotion", () => {
    // ⬇️ Arrange: Set up test data
    const date = new Date("2026-07-04"); // Independence Day (summer promotion)
    const basePrice = 100;

    // ⬇️ Act: Execute the function
    const discountedPrice = calculateDiscount(basePrice, date);

    // ⬇️ Assert: Verify result
    expect(discountedPrice).toBe(75); // 25% summer discount
  });
});
```

**Blank lines between each section for readability.**

## Coverage Requirements

- **Minimum coverage:** 90% (statements, lines, branches, functions)
- **Command:** `vitest run --coverage`
- **Enforce:** CI/CD blocks merge if coverage < 90%
- **Target:** 95% for critical business logic (payments, auth)

**Coverage types:**

- Statements: 90%+ (did all code run?)
- Lines: 90%+ (did all lines execute?)
- Branches: 90%+ (did all if/else paths execute?)
- Functions: 90%+ (were all functions called?)

## Mocking & Isolation

- **MOCK all external dependencies:** no real network or DB calls
- **USE** `vitest.mock()` for imported modules
- **MOCK return values** to test all code paths
- **Unit tests:** Fast, run in milliseconds, no external calls

Example:

```typescript
// ✅ GOOD: Mock database
vi.mock("@/db", () => ({
  db: {
    query: vi
      .fn()
      .mockResolvedValue([{ id: "123", email: "user@example.com" }]),
  },
}));

// ❌ BAD: Makes real DB call
const user = await db.query("SELECT * FROM users");
```

## Test Types & Tools

| Type            | Tool             | Coverage | Speed  | Purpose                            |
| --------------- | ---------------- | -------- | ------ | ---------------------------------- |
| **Unit**        | Vitest           | ≥90%     | <1s    | Test functions in isolation        |
| **Integration** | Jest             | ≥80%     | 5-10s  | Test service + repository together |
| **API**         | Playwright       | N/A      | 10-30s | Test HTTP endpoints                |
| **Visual**      | toHaveScreenshot | N/A      | 10-30s | Test UI snapshot regression        |
| **E2E**         | Playwright       | N/A      | 1-5m   | Test full user workflows           |
| **Performance** | k6               | N/A      | 1-5m   | Test load, throughput, latency     |

## Bug-Fix Protocol

1. **Add failing test** that reproduces the bug BEFORE fixing
2. **Verify** the test fails (proves it catches the bug)
3. **Fix the bug**
4. **Verify** the test now passes
5. **Commit** with message: `fix(component): description. Fixes #1234`

Example:

```typescript
// Step 1: Add failing test
it("userRepository_findById_doesNotReturnDeletedUsers", () => {
  const user = await userRepository.findById("deleted-user-id");
  expect(user).toBeNull(); // Should not return soft-deleted users
});

// Step 2: Test fails ❌
// Step 3: Fix the code
// SELECT * FROM users WHERE id = ? AND deleted_at IS NULL
// Step 4: Test passes ✅
```

## Edge Cases & Error Paths

**NEVER assert only the happy path.** Include edge cases for every function.

### Examples

**Function:** `calculateDiscount(price: number, quantity: number)`

Happy path:

- ✅ Normal purchase: quantity 10, discount applies

Edge cases:

- ✅ Zero quantity
- ✅ Negative price (invalid)
- ✅ Very large quantity (overflow)
- ✅ Decimal price (rounding)
- ✅ Quantity exactly at discount threshold

**Function:** `userRepository.findById(id: string)`

Happy path:

- ✅ User exists and returned

Edge cases:

- ✅ User doesn't exist (returns null)
- ✅ User is soft-deleted (returns null)
- ✅ Invalid ID format (throws error)
- ✅ Empty ID (throws error)
- ✅ Database connection fails (throws error)

## Error Handling Tests

- **Test success path:** Does the function work correctly?
- **Test error path:** Does it throw the right error?
- **Test recovery:** Can the code recover from errors?

Example:

```typescript
it("userRepository_findById_throwsIfDatabaseFails", async () => {
  vi.mocked(db.query).mockRejectedValue(new Error("Connection timeout"));

  expect(async () => {
    await userRepository.findById("123");
  }).rejects.toThrow("Connection timeout");
});
```

## Performance Testing

- **Smoke test:** Verify API returns within reasonable time (< 1s)
- **Load test:** Can system handle 1000 concurrent users?
- **Stress test:** When does system break?
- **Soak test:** Can system run for 24 hours without memory leaks?

Tools: **k6**, **Apache JMeter**, **Locust**

## Accessibility Testing

- **axe-core:** Automated a11y scanning
- **jest-axe:** Integration with Jest
- **Keyboard navigation:** Tab through UI, verify focus order
- **Screen reader:** Test with NVDA or JAWS

Example:

```typescript
import { axe, toHaveNoViolations } from 'jest-axe';

it('loginForm_hasNoAccessibilityViolations', async () => {
  const { container } = render(<LoginForm />);
  const results = await axe(container);
  expect(results).toHaveNoViolations();
});
```
