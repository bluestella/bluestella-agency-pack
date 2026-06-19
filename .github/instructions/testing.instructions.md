---
applyTo: "{tests/**,**/*.test.*,**/*.spec.*}"
---
Test naming and structure:
- Name tests: [unit]_[scenario]_[expected_outcome]
- Follow Arrange / Act / Assert structure with a blank line between each section

Coverage and quality:
- Maintain minimum coverage: 80%
- MOCK all external dependencies; no real network or DB calls in unit tests

Bug-fix protocol:
- Add one failing test that reproduces the bug before implementing the fix

Edge cases:
- NEVER assert only the happy path; include at least one edge case per function
