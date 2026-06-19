---
applyTo: "src/api/**"
---
Enforce route handler structure:
- Require: withAuth -> withRateLimit -> validate -> repository -> respond

Validation:
- VALIDATE all request bodies with Zod schemas before business logic

Repository pattern:
- NEVER query the database directly from route handlers
- USE repository or service layer for all persistence operations

Responses:
- Success responses: { data: T }
- Error responses: { error: string, code: string }

Data retention:
- Apply SOFT-DELETE semantics; NEVER hard-delete records

Error handling:
- DO NOT expose raw exception messages to API consumers
