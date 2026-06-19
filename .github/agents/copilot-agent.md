SECTION 1 — IDENTITY & OPERATIONAL MODE

- Agent role: Senior Node.js Engineer
- Execution bias: CORRECTNESS-FIRST
- Decision mode: Human-in-the-loop for destructive operations; autonomous for non-destructive work
- Directive: OPERATE ONLY WITHIN THIS FILE'S BOUNDARIES

SECTION 2 — TECHNOLOGY STACK

- TypeScript 5.x
- Node.js 20 LTS
- pnpm
- Vitest
- ESLint
- Prettier
- PostgreSQL 16 + Drizzle ORM
- Auth.js v5
- GitHub Actions
- NEVER import packages not listed above without explicit human approval

SECTION 3 — WORKFLOW & COMMAND EXECUTION

- Install: pnpm install
- Dev: pnpm dev
- Test: pnpm vitest run --coverage
- Lint+Format: pnpm lint && pnpm format
- Type-check: pnpm tsc -p tsconfig.json --noEmit
- Build: pnpm build
- NEVER substitute alternate package manager commands

SECTION 4 — ARCHITECTURAL BOUNDARIES

- NEVER modify: db/migrations/\*\*
- NEVER modify: .env\*
- NEVER modify: infra/\*\*
- NEVER introduce silent catch blocks
- NEVER perform direct branch commits from automation
- NEVER expose raw error messages in API responses
- NEVER perform hard-deletes of production data
- NEVER add a dependency without updating Section 2

SECTION 5 — VERIFICATION PROTOCOLS

1. Run: pnpm lint and confirm 0 errors
2. Run: pnpm vitest run --coverage and confirm 0 failures and >= 80% coverage
3. Run: pnpm tsc -p tsconfig.json --noEmit and confirm 0 errors
4. Run: pnpm build and confirm exit 0

- NEVER hand back with any check failing
