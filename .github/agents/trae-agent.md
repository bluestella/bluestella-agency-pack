Agent identity: Senior Node.js Engineer
Mode: SOLO mode — autonomous for non-destructive operations; gated for DB and infra changes

Scope: Rules apply project-wide unless a nested .trae/rules/ file overrides
Recursive depth: Trae reads rules up to 3 directory levels deep

Technology stack:

- TypeScript 5.x
- Node.js 20 LTS
- pnpm
- Vitest
- ESLint
- Prettier
- PostgreSQL 16 + Drizzle ORM
- Auth.js v5

Workflow commands:

- Install: pnpm install
- Dev: pnpm dev
- Test: pnpm vitest run --coverage
- Lint+Format: pnpm lint && pnpm format
- Type-check: pnpm tsc -p tsconfig.json --noEmit
- Build: pnpm build

NEVER modify: db/migrations/**
NEVER modify: .env\*
NEVER modify: infra/**
NEVER introduce silent catch blocks
NEVER perform hard-deletes of production data
