# AI IDE Generation Templates
> Based on: *Standardizing Autonomous AI Agent Behavior: Semantics, Scaffolding, and Implementation Patterns Across Modern IDEs*

These six template families cover the full governance surface of autonomous AI coding agents across Claude Code, Cursor, GitHub Copilot, OpenAI Codex, Trae, and Google Antigravity. Each template is annotated with the semantic rationale from the source research.

---

## TEMPLATE 1 — AGENTS

> **What this is:** An Agent is a specialized LLM persona equipped with a hyper-specific context and a limited set of tools. This template covers both the Claude Code `CLAUDE.md` pattern and the cross-platform `AGENTS.md` standard.

---

### 1A. CLAUDE.md — Claude Code Agent Definition

```markdown
# AGENT: [Agent Name]
# Version: 1.0.0
# Scope: [project-root | module-name | service-name]

---

## IDENTITY & MANDATE

You are a [Role Title] agent specialized in [Domain/Stack].
Your operational bias is [speed-first | correctness-first | security-first].
Decision-making mode: [autonomous | human-in-the-loop | gated].

DO NOT act as a generalist coding assistant. You operate exclusively within the
boundaries defined in this file.

---

## TECHNOLOGY STACK (Approved Only)

Language:     [e.g., TypeScript 5.x]
Runtime:      [e.g., Node.js 20 LTS]
Framework:    [e.g., Next.js 15 App Router — NOT Pages Router]
Database:     [e.g., PostgreSQL 16 via Drizzle ORM]
Package Mgr:  [e.g., pnpm — NEVER npm or yarn]
Test Runner:  [e.g., Vitest]
Linter:       [e.g., ESLint + Prettier]

NEVER import packages not listed above without explicit human approval.
NEVER use deprecated APIs from previous framework versions.

---

## SUBAGENT DEFINITIONS

### Investigation Subagent
Spawn when: log files exceed 500 lines, or dependency graph analysis is needed.
Task: Analyze and return a compressed summary (max 200 tokens) to the primary agent.
Command: claude --subagent "investigate: [task description]"

### Refactor Subagent
Spawn when: changes affect more than 3 files simultaneously.
Task: Isolate refactor scope, execute, and return a diff summary.
Command: claude --subagent "refactor: [scope description]"

---

## WORKFLOW & COMMAND EXECUTION

# Install dependencies
pnpm install

# Run development server
pnpm dev

# Run tests (ALWAYS use this exact command)
pnpm turbo run test

# Lint and format (ALWAYS before concluding a task)
pnpm run lint && npx prettier --write .

# Build for production
pnpm turbo run build

# Database migrations
pnpm drizzle-kit migrate

NEVER guess or substitute alternate commands. Execute exactly as defined above.

---

## ARCHITECTURAL BOUNDARIES

NEVER modify:
- /db/migrations/** (database migration history is immutable)
- /.env and /.env.* files (environment variables)
- /infra/** (infrastructure-as-code, requires separate approval)
- package.json > "engines" field

NEVER:
- Silently catch exceptions with empty catch blocks
- Commit directly to the main or production branch
- Expose secrets or tokens in log output
- Use console.log in production code (use the project logger instead)
- Execute rm -rf without explicit human confirmation

---

## VERIFICATION PROTOCOLS

Before concluding ANY task, execute in sequence:
1. pnpm run lint          → must return 0 errors
2. pnpm turbo run test    → must return 0 failures
3. npx tsc --noEmit       → must return 0 type errors

If any check fails: fix the issue and re-run the full sequence.
NEVER hand back to the human with failing checks.

---

## MCP INTEGRATIONS

@.claude/mcp/database.json    → Live schema queries
@.claude/mcp/github.json      → PR and issue context

# Import pattern for modular rules:
@.claude/rules/01-security.md
@.claude/rules/02-api-patterns.md
@.claude/rules/03-testing-standards.md
```

---

### 1B. AGENTS.md — Cross-Platform Agent Standard (OpenAI Codex / Trae)

```markdown
# AGENTS.md
# Scope: [global ~/.codex/ | project-root | module ./src/payments/]
# Priority: Files closer to the working directory override upstream rules.

---

## AGENT IDENTITY

Role: [e.g., Backend API Developer Agent]
Specialization: [e.g., RESTful APIs using FastAPI + PostgreSQL]
Decision Bias: [e.g., correctness-first, never sacrifice type safety for speed]

---

## PROJECT STRUCTURE

src/
  api/          → FastAPI route handlers (one file per domain)
  services/     → Business logic (Repository pattern only)
  models/       → SQLAlchemy ORM models
  schemas/      → Pydantic request/response schemas
tests/          → Pytest test suite, mirrors src/ structure
migrations/     → Alembic migration files (NEVER hand-edit)

---

## TESTING PROTOCOL

Framework: pytest
Run command: pytest tests/ -v --cov=src --cov-report=term-missing
Coverage threshold: 80% minimum before task completion
Naming convention: test_[unit_under_test]_[scenario]_[expected_outcome]

All new functions MUST have a corresponding test before marking task done.

---

## PULL REQUEST GUIDELINES

- Title format: [TYPE]: Short description (TYPE = feat|fix|refactor|chore|docs)
- PR body must include: Problem, Solution, Testing Evidence
- NEVER open a PR with failing CI checks
- Link the originating issue number in the PR description

---

## PROHIBITED ACTIONS

NEVER:
- Modify migration files in /migrations/
- Push to main, master, or production branches
- Hard-delete records (use soft-delete with deleted_at timestamp)
- Return raw exception messages to API consumers (sanitize all errors)
- Use SELECT * in production queries

---

## CASCADING OVERRIDE NOTICE

This file is overridden by AGENTS.override.md files found in subdirectories.
Module-level constraints take precedence over this root file.
```

---

### 1C. GitHub Copilot — Custom Agent (VSCode)

```markdown
<!-- .github/copilot-instructions.md -->
<!-- Activated via: github.copilot.chat.codeGeneration.useInstructionFiles: true -->

# Copilot Agent: [Agent Name]
# Participant: @[agent-handle] (invoked explicitly in Copilot Chat)

## Persona

You are a [e.g., Spring Boot Developer Agent] with deep expertise in:
- [Technology 1]
- [Technology 2]
- [Technology 3]

Respond with production-ready code. Skip explanations unless asked.

## Code Generation Rules

1. Use [Framework Version] APIs exclusively.
2. Apply [Design Pattern] for all [Layer] implementations.
3. Annotate all public methods with [Javadoc | JSDoc | docstring].
4. Generate unit tests alongside every implementation.

## Boundaries

Do not generate code that:
- Bypasses authentication middleware
- Writes directly to the database outside of the repository layer
- Uses deprecated [Framework] APIs

## Commit Message Format

[TYPE]([scope]): [Short imperative description]

Body: What changed and why (not how).
Footer: Refs #[issue-number]
```

---

## TEMPLATE 2 — SKILLS

> **What this is:** Skills are standardized tool capabilities attached to an agent. In Claude Code, a skill is a `SKILL.md` file in `.claude/skills/` that wraps a CLI operation in a descriptive, optionally human-gated interface.

---

### 2A. Claude Code SKILL.md — Standard Skill

```markdown
---
name: [skill-name]
description: >
  [One precise sentence describing what this skill does and when to trigger it.
  This text is machine-evaluated — be specific. Vague descriptions cause missed triggers.]
version: 1.0.0
disable-model-invocation: false  # Set true to require explicit human invocation only
---

# Skill: [Skill Name]

## Purpose

[One sentence: what problem does this skill solve?]

## Trigger Conditions

Use this skill when:
- [Condition 1 — be specific, e.g., "user asks to fix a GitHub issue by number"]
- [Condition 2]
- [Condition 3]

Do NOT use this skill when:
- [Anti-condition 1]
- [Anti-condition 2]

## Execution Steps

### Step 1: Gather Context
```bash
# [Describe what context to fetch first]
[command to fetch context, e.g., gh issue view {ISSUE_NUMBER} --json title,body,labels]
```

### Step 2: Analyze
[Instruction on what to look for in the output before acting]

### Step 3: Search Codebase
```bash
# [Describe the search strategy]
grep -r "[pattern]" src/ --include="*.ts" -l
```

### Step 4: Implement
[Instructions on how to implement the fix or feature]

### Step 5: Verify
```bash
pnpm turbo run test
pnpm run lint
```

## Output Contract

On success: [describe what the agent should return or report]
On failure: [describe how to handle and surface errors]

## Safety Constraints

NEVER:
- [Safety constraint 1]
- [Safety constraint 2]
```

---

### 2B. Investigator Skill (Subagent Pattern)

```markdown
---
name: investigate-logs
description: >
  Analyzes large log files or dependency graphs and returns a compressed,
  actionable summary to the primary agent. Spawn this as a subagent when
  log files exceed 500 lines or codebase dependency mapping is required.
version: 1.0.0
disable-model-invocation: false
---

# Skill: Investigate Logs

## Execution Steps

### Step 1: Determine Log Size
```bash
wc -l {LOG_FILE_PATH}
```

### Step 2: Extract Error Clusters
```bash
grep -E "(ERROR|FATAL|CRITICAL)" {LOG_FILE_PATH} | tail -100
grep -E "(WARN)" {LOG_FILE_PATH} | tail -50
```

### Step 3: Identify Root Cause Pattern
Analyze the error clusters. Group by:
1. Error type
2. Frequency (count occurrences)
3. Timeline (first vs. last occurrence)
4. Affected components (service names, file paths)

### Step 4: Return Compressed Summary
Format the summary as:
- Root cause (1 sentence)
- Top 3 contributing errors with counts
- Recommended action (1–2 sentences)
- Total tokens used: < 200

## Output Contract

Return a structured summary object, NOT raw log content.
```

---

### 2C. Google Antigravity / Global Skill (Plugin Pattern)

```yaml
# Location: ~/.gemini/config/skills/[skill-name].yaml  (global)
# OR: .agents/skills/[skill-name].yaml  (project-scoped)

name: [skill-name]
description: "[Precise description for the agent's tool selection algorithm]"
version: "1.0.0"

tools:
  - name: [tool-name]
    description: "[What this tool does]"
    command: "[exact CLI command with {PARAMETER} placeholders]"
    parameters:
      - name: PARAMETER
        description: "[What value goes here]"
        required: true

permissions:
  network: [true | false]
  filesystem: [read | write | none]
  cloud: [true | false]

on_error: "[Instruction for what the agent should do if this skill fails]"
```

---

## TEMPLATE 3 — INSTRUCTIONS

> **What this is:** Instructions are the primary behavioral contracts for an agent. Structured around five mandatory scaffold sections. Valid across Claude Code, Cursor (.mdc), Copilot (.instructions.md), and Trae (.trae/rules/).

---

### 3A. Universal Instructions Scaffold (All Platforms)

```markdown
# [Project Name] — Agent Instructions
# Format compatibility: CLAUDE.md | AGENTS.md | .instructions.md
# Token budget: Keep under 150 actionable directives total.
# Rule: Ruthlessly imperative. NO explanations. NO philosophy.

---

## SECTION 1 — IDENTITY & OPERATIONAL MODE

Agent role: [e.g., Senior Full-Stack Engineer]
Mandate: [e.g., Build features that are correct, tested, and secure]
Execution bias: [e.g., Correctness over speed. Type safety is non-negotiable.]
Persona: [e.g., Expert, terse. Skip preambles. Start with the solution.]

---

## SECTION 2 — CONTEXT & TECHNOLOGY STACK

Language:     [Language + Version]
Framework:    [Framework + Version + Router/Mode]
State:        [e.g., Zustand 4.x — NEVER Redux]
Styling:      [e.g., Tailwind CSS v4 — NEVER inline styles]
Auth:         [e.g., Auth.js v5]
Database:     [e.g., PostgreSQL 16 + Drizzle ORM]
Cache:        [e.g., Redis 7 via ioredis]
Package mgr:  [e.g., pnpm — NEVER npm]
Node version: [e.g., 20 LTS]

Approved external APIs:
- [API Name] — [purpose]
- [API Name] — [purpose]

NEVER introduce unlisted dependencies.

---

## SECTION 3 — WORKFLOW & COMMAND EXECUTION

# Setup
[setup command]

# Development
[dev command]

# Testing (EXACT command — do not guess alternates)
[test command]

# Lint + Format (run before EVERY task completion)
[lint command] && [format command]

# Build
[build command]

# Deployment (if applicable)
[deploy command]

Execute commands in the sequence above. NEVER substitute npm for pnpm, or vice versa.

---

## SECTION 4 — ARCHITECTURAL BOUNDARIES

NEVER modify:
- [Path 1] — [reason]
- [Path 2] — [reason]
- [Path 3] — [reason]

NEVER:
- Catch exceptions silently (empty catch blocks)
- Commit to [branch names]
- Expose [data type] in API responses
- Use [deprecated pattern]
- Skip type annotations on public functions

NEVER add a dependency without adding it to:
[ ] package.json
[ ] The approved stack list in Section 2 of this file

---

## SECTION 5 — VERIFICATION PROTOCOLS

Self-check sequence (execute in order before task handoff):

[ ] Step 1: [lint command]         → 0 errors
[ ] Step 2: [test command]         → 0 failures, >= [N]% coverage
[ ] Step 3: [type check command]   → 0 type errors
[ ] Step 4: [build command]        → exits 0

If any step fails: fix and restart the sequence from Step 1.
NEVER hand back to the human with any check unresolved.
```

---

### 3B. Cursor .mdc Rule File

```yaml
---
description: >
  [Precise machine-readable description. This is what the agent reads to decide
  if this rule is relevant. Be specific — vague descriptions cause rules to be ignored.
  Example: "Apply when working on API route handlers in src/api/ or when the user
  asks about REST endpoint structure or HTTP error handling."]
globs:
  - "src/api/**/*.ts"
  - "src/api/**/*.test.ts"
alwaysApply: false   # NEVER set true for broad rules — degrades Cursor performance
---

# [Rule Title]

## Mandate

[One imperative sentence describing what this rule enforces.]

## Requirements

- [Requirement 1 — imperative, specific]
- [Requirement 2]
- [Requirement 3]

## Prohibited Patterns

NEVER:
- [Anti-pattern 1]
- [Anti-pattern 2]

## Reference Pattern

```typescript
// CORRECT: [explanation]
[correct code example]

// WRONG: [explanation]
[wrong code example]
```

## Verification

Before completing any task covered by this rule:
[lint or test command to validate compliance]
```

> **Note on Cursor .mdc UI bugs:** The Cursor UI occasionally fails to render the top frontmatter block. Always edit .mdc files with an external editor to ensure frontmatter structural integrity.

---

### 3C. GitHub Copilot / VSCode Instructions File

```markdown
<!-- File: .github/copilot-instructions.md -->
<!-- OR custom path via: chat.instructionsFilesLocations in settings.json -->

# Copilot Instructions — [Project Name]

## Activation

Ensure `github.copilot.chat.codeGeneration.useInstructionFiles` is `true` in `.vscode/settings.json`.

## Code Style

- Use [language] [version] syntax.
- Prefer [pattern] for [use case].
- All functions must have [documentation format] annotations.

## Architecture Rules

- Follow [architecture pattern] for all [layer] code.
- New routes go in [path]; new services go in [path].
- NEVER bypass [middleware name] for authenticated routes.

## Testing

- Write [framework] tests for every new function.
- Mock external dependencies with [mocking library].
- Test file location: [path pattern]

## Git Commit Format

[TYPE]([scope]): [description]

Types: feat | fix | refactor | test | docs | chore
```

```json
// .vscode/settings.json
{
  "github.copilot.chat.codeGeneration.useInstructionFiles": true,
  "chat.instructionsFilesLocations": [
    ".github/copilot-instructions.md",
    ".github/instructions/api-patterns.instructions.md"
  ]
}
```

---

## TEMPLATE 4 — HOOKS

> **What this is:** Hooks are deterministic shell commands or HTTP endpoints that execute outside the AI's control at specific lifecycle events. They are the hard enforcement layer that wraps the non-deterministic agent. Defined in `.claude/settings.json` for Claude Code.

---

### 4A. Hooks Configuration — settings.json (Claude Code)

```json
{
  "hooks": {
    "PreToolUse": [
      {
        "matcher": "Bash",
        "hooks": [
          {
            "type": "command",
            "command": "/path/to/project/.claude/hooks/pre-tool-firewall.sh",
            "description": "Security firewall — blocks destructive commands before execution"
          }
        ]
      },
      {
        "matcher": "Write",
        "hooks": [
          {
            "type": "command",
            "command": "/path/to/project/.claude/hooks/pre-write-guard.sh",
            "description": "Blocks writes to protected paths (migrations, .env, infra/)"
          }
        ]
      }
    ],
    "PostToolUse": [
      {
        "matcher": "Write|Edit",
        "hooks": [
          {
            "type": "command",
            "command": "/path/to/project/.claude/hooks/post-write-format.sh",
            "description": "Auto-formats modified files with Prettier and ESLint"
          }
        ]
      }
    ],
    "Stop": [
      {
        "hooks": [
          {
            "type": "command",
            "command": "/path/to/project/.claude/hooks/stop-verify.sh",
            "description": "Runs full test suite — blocks agent stop if tests fail"
          }
        ]
      }
    ],
    "SessionStart": [
      {
        "hooks": [
          {
            "type": "command",
            "command": "/path/to/project/.claude/hooks/session-start-check.sh",
            "description": "Validates environment readiness before agent begins"
          }
        ]
      }
    ]
  }
}
```

---

### 4B. PreToolUse Hook — Security Firewall

```bash
#!/bin/bash
# .claude/hooks/pre-tool-firewall.sh
# Purpose: Block destructive shell commands before the agent executes them.
# Contract: Exit 0 = allow. Exit 2 = block (output is fed back to agent).

set -euo pipefail

# Read the proposed command from stdin (Claude Code passes it as JSON)
TOOL_INPUT=$(cat)
COMMAND=$(echo "$TOOL_INPUT" | jq -r '.command // ""')

# --- BLOCK LIST ---
BLOCKED_PATTERNS=(
  "rm -rf /"
  "rm -rf \*"
  "DROP TABLE"
  "DROP DATABASE"
  "DELETE FROM .* WHERE 1=1"
  "chmod 777"
  "curl.*|.*bash"
  "wget.*|.*sh"
  "> /dev/sda"
  "mkfs\."
  ":(){ :|:& };:"
)

for pattern in "${BLOCKED_PATTERNS[@]}"; do
  if echo "$COMMAND" | grep -qiE "$pattern"; then
    echo "BLOCKED: Command matches prohibited pattern: '$pattern'" >&2
    echo "Reason: This command is classified as destructive and requires explicit human execution." >&2
    echo "Action: Please perform this operation manually in your terminal." >&2
    exit 2
  fi
done

# --- PROTECTED PATH GUARD ---
PROTECTED_PATHS=(
  "db/migrations"
  ".env"
  "infra/"
  ".claude/settings.json"
)

for path in "${PROTECTED_PATHS[@]}"; do
  if echo "$COMMAND" | grep -q "$path"; then
    echo "BLOCKED: Attempted write to protected path: '$path'" >&2
    echo "Action: Modifications to this path require human review." >&2
    exit 2
  fi
done

# Allow the command to proceed
exit 0
```

---

### 4C. PreToolUse Hook — Write Path Guard

```bash
#!/bin/bash
# .claude/hooks/pre-write-guard.sh
# Purpose: Block file writes to immutable paths before Write/Edit tool executes.
# Contract: Exit 0 = allow. Exit 2 = block.

set -euo pipefail

TOOL_INPUT=$(cat)
FILE_PATH=$(echo "$TOOL_INPUT" | jq -r '.path // ""')

PROTECTED_DIRS=(
  "db/migrations/"
  "infra/"
  ".env"
  ".env.production"
  ".env.staging"
)

for dir in "${PROTECTED_DIRS[@]}"; do
  if [[ "$FILE_PATH" == *"$dir"* ]]; then
    echo "BLOCKED: Write attempt to protected path '$FILE_PATH'." >&2
    echo "Reason: '$dir' is an immutable path — changes require human review." >&2
    exit 2
  fi
done

exit 0
```

---

### 4D. PostToolUse Hook — Auto-Format on Write

```bash
#!/bin/bash
# .claude/hooks/post-write-format.sh
# Purpose: Auto-format any file the agent writes, without consuming LLM tokens.
# Contract: Always exit 0 (non-blocking). Formatting failures are warnings only.

set -euo pipefail

TOOL_INPUT=$(cat)
FILE_PATH=$(echo "$TOOL_INPUT" | jq -r '.path // ""')

if [[ -z "$FILE_PATH" ]] || [[ ! -f "$FILE_PATH" ]]; then
  exit 0
fi

EXT="${FILE_PATH##*.}"

case "$EXT" in
  ts|tsx|js|jsx|mjs|cjs|json|css|scss|md|yaml|yml)
    npx prettier --write "$FILE_PATH" --log-level silent || true
    ;;
esac

case "$EXT" in
  ts|tsx|js|jsx)
    npx eslint "$FILE_PATH" --fix --quiet || true
    ;;
esac

echo "PostToolUse: Formatted '$FILE_PATH' ($EXT)"
exit 0
```

---

### 4E. Stop Hook — Adversarial Verification Gate

```bash
#!/bin/bash
# .claude/hooks/stop-verify.sh
# Purpose: Force the agent to pass all tests before it can stop working.
# Contract: Exit 0 = agent may stop. Exit 2 = agent must continue until resolved.

set -euo pipefail

echo "Stop hook: Running verification suite before allowing agent to conclude..."

# Run tests
if ! pnpm turbo run test 2>&1; then
  echo "VERIFICATION FAILED: Test suite did not pass." >&2
  echo "Action required: Fix all failing tests before concluding this task." >&2
  exit 2
fi

# Run lint
if ! pnpm run lint 2>&1; then
  echo "VERIFICATION FAILED: Lint errors detected." >&2
  echo "Action required: Resolve all lint errors before concluding." >&2
  exit 2
fi

# Run type check
if ! npx tsc --noEmit 2>&1; then
  echo "VERIFICATION FAILED: TypeScript type errors detected." >&2
  echo "Action required: Resolve all type errors before concluding." >&2
  exit 2
fi

echo "All verification checks passed. Agent may conclude."

# Optional: Desktop notification
# osascript -e 'display notification "Claude Code: Task complete ✓" with title "Build Passed"'

exit 0
```

---

### 4F. SessionStart Hook — Environment Readiness Check

```bash
#!/bin/bash
# .claude/hooks/session-start-check.sh
# Purpose: Validate environment before the agent begins any work.
# Contract: Exit 0 = environment ready. Exit 2 = halt agent start.

set -euo pipefail

ERRORS=()

# Check required environment variables
REQUIRED_ENV_VARS=(
  "DATABASE_URL"
  "REDIS_URL"
  "JWT_SECRET"
)

for var in "${REQUIRED_ENV_VARS[@]}"; do
  if [[ -z "${!var:-}" ]]; then
    ERRORS+=("Missing required env var: $var")
  fi
done

# Check required services
if ! pg_isready -q 2>/dev/null; then
  ERRORS+=("PostgreSQL is not running. Start with: docker-compose up -d db")
fi

if ! redis-cli ping &>/dev/null; then
  ERRORS+=("Redis is not running. Start with: docker-compose up -d redis")
fi

# Check Node version
REQUIRED_NODE="20"
CURRENT_NODE=$(node -v | cut -d'.' -f1 | tr -d 'v')
if [[ "$CURRENT_NODE" -lt "$REQUIRED_NODE" ]]; then
  ERRORS+=("Node.js v$REQUIRED_NODE+ required. Current: $(node -v)")
fi

# Report
if [[ ${#ERRORS[@]} -gt 0 ]]; then
  echo "SessionStart: Environment not ready. Resolve these issues first:" >&2
  for err in "${ERRORS[@]}"; do
    echo "  ✗ $err" >&2
  done
  exit 2
fi

echo "SessionStart: Environment validated. All systems ready."
exit 0
```

---

## TEMPLATE 5 — TEMPLATES

> **What this is:** Reusable scaffolds for code components, API endpoints, and document structures. Named with hierarchical numbering (01-, 02-, 03-) and kept under 500 lines per file to preserve model attention. These instruct the agent to copy structure and fill in business logic.

---

### 5A. API Endpoint Template (TypeScript / Next.js App Router)

```typescript
// Template: src/api/[domain]/route.ts
// Usage: Copy this template, replace [DOMAIN] and [ENTITY] placeholders.
// Agent instruction: Fill business logic only. Do not alter the structural scaffold.

import { NextRequest, NextResponse } from "next/server";
import { z } from "zod";
import { [ENTITY]Repository } from "@/services/[domain]/[entity].repository";
import { withAuth } from "@/middleware/auth";
import { withRateLimit } from "@/middleware/rate-limit";
import { AppError, handleApiError } from "@/lib/errors";
import { logger } from "@/lib/logger";

// --- REQUEST SCHEMAS ---
const Create[ENTITY]Schema = z.object({
  // [Add fields here]
});

const Update[ENTITY]Schema = z.object({
  // [Add fields here]
}).partial();

// --- GET ---
export async function GET(
  request: NextRequest,
  { params }: { params: { id?: string } }
) {
  try {
    await withAuth(request);
    await withRateLimit(request, "read");

    const repo = new [ENTITY]Repository();

    if (params?.id) {
      const entity = await repo.findById(params.id);
      if (!entity) throw new AppError("NOT_FOUND", "[ENTITY] not found", 404);
      return NextResponse.json({ data: entity });
    }

    const { searchParams } = new URL(request.url);
    const page = parseInt(searchParams.get("page") ?? "1");
    const limit = Math.min(parseInt(searchParams.get("limit") ?? "20"), 100);

    const result = await repo.findMany({ page, limit });
    return NextResponse.json({ data: result.items, meta: result.meta });

  } catch (error) {
    return handleApiError(error);
  }
}

// --- POST ---
export async function POST(request: NextRequest) {
  try {
    await withAuth(request);
    await withRateLimit(request, "write");

    const body = await request.json();
    const validated = Create[ENTITY]Schema.parse(body);

    const repo = new [ENTITY]Repository();
    const entity = await repo.create(validated);

    logger.info("[ENTITY] created", { id: entity.id });
    return NextResponse.json({ data: entity }, { status: 201 });

  } catch (error) {
    return handleApiError(error);
  }
}

// --- PUT ---
export async function PUT(
  request: NextRequest,
  { params }: { params: { id: string } }
) {
  try {
    await withAuth(request);
    await withRateLimit(request, "write");

    const body = await request.json();
    const validated = Update[ENTITY]Schema.parse(body);

    const repo = new [ENTITY]Repository();
    const entity = await repo.update(params.id, validated);
    if (!entity) throw new AppError("NOT_FOUND", "[ENTITY] not found", 404);

    return NextResponse.json({ data: entity });

  } catch (error) {
    return handleApiError(error);
  }
}

// --- DELETE ---
export async function DELETE(
  request: NextRequest,
  { params }: { params: { id: string } }
) {
  try {
    await withAuth(request);
    await withRateLimit(request, "write");

    const repo = new [ENTITY]Repository();
    await repo.softDelete(params.id);  // NEVER hard-delete

    return NextResponse.json({ success: true }, { status: 200 });

  } catch (error) {
    return handleApiError(error);
  }
}
```

---

### 5B. Repository Pattern Template (Data Layer)

```typescript
// Template: src/services/[domain]/[entity].repository.ts
// Pattern: Repository — all data access goes through this class.
// Agent instruction: NEVER query the database directly from routes or services.

import { db } from "@/lib/db";
import { [entity]Table } from "@/db/schema/[entity]";
import { eq, and, desc, sql } from "drizzle-orm";
import type { Create[ENTITY]Input, Update[ENTITY]Input } from "./[entity].types";

export class [ENTITY]Repository {
  async findById(id: string) {
    const [record] = await db
      .select()
      .from([entity]Table)
      .where(and(eq([entity]Table.id, id), eq([entity]Table.deletedAt, null)))
      .limit(1);
    return record ?? null;
  }

  async findMany({ page = 1, limit = 20 }: { page?: number; limit?: number }) {
    const offset = (page - 1) * limit;

    const [items, [{ count }]] = await Promise.all([
      db
        .select()
        .from([entity]Table)
        .where(eq([entity]Table.deletedAt, null))
        .orderBy(desc([entity]Table.createdAt))
        .limit(limit)
        .offset(offset),
      db.select({ count: sql<number>`count(*)` }).from([entity]Table),
    ]);

    return {
      items,
      meta: { page, limit, total: count, pages: Math.ceil(count / limit) },
    };
  }

  async create(data: Create[ENTITY]Input) {
    const [record] = await db
      .insert([entity]Table)
      .values(data)
      .returning();
    return record;
  }

  async update(id: string, data: Update[ENTITY]Input) {
    const [record] = await db
      .update([entity]Table)
      .set({ ...data, updatedAt: new Date() })
      .where(eq([entity]Table.id, id))
      .returning();
    return record ?? null;
  }

  async softDelete(id: string) {
    await db
      .update([entity]Table)
      .set({ deletedAt: new Date() })
      .where(eq([entity]Table.id, id));
  }
}
```

---

### 5C. Test File Template (Vitest)

```typescript
// Template: tests/[domain]/[entity].test.ts
// Coverage requirement: >= 80% on all new code.
// Agent instruction: Generate this file for every new unit implemented.

import { describe, it, expect, vi, beforeEach, afterEach } from "vitest";
import { [ENTITY]Repository } from "@/services/[domain]/[entity].repository";

// --- MOCKS ---
vi.mock("@/lib/db", () => ({
  db: {
    select: vi.fn().mockReturnThis(),
    insert: vi.fn().mockReturnThis(),
    update: vi.fn().mockReturnThis(),
    from: vi.fn().mockReturnThis(),
    where: vi.fn().mockReturnThis(),
    limit: vi.fn().mockReturnThis(),
    offset: vi.fn().mockReturnThis(),
    orderBy: vi.fn().mockReturnThis(),
    returning: vi.fn().mockResolvedValue([]),
    values: vi.fn().mockReturnThis(),
    set: vi.fn().mockReturnThis(),
  },
}));

// --- FIXTURES ---
const mock[ENTITY] = {
  id: "test-id-001",
  // [Add fixture fields matching your schema]
  createdAt: new Date("2025-01-01"),
  updatedAt: new Date("2025-01-01"),
  deletedAt: null,
};

// --- TESTS ---
describe("[ENTITY]Repository", () => {
  let repo: [ENTITY]Repository;

  beforeEach(() => {
    repo = new [ENTITY]Repository();
    vi.clearAllMocks();
  });

  describe("findById", () => {
    it("returns the entity when found", async () => {
      // Arrange
      const { db } = await import("@/lib/db");
      (db.returning as any).mockResolvedValueOnce([mock[ENTITY]]);

      // Act
      const result = await repo.findById("test-id-001");

      // Assert
      expect(result).toEqual(mock[ENTITY]);
    });

    it("returns null when entity does not exist", async () => {
      const { db } = await import("@/lib/db");
      (db.returning as any).mockResolvedValueOnce([]);

      const result = await repo.findById("nonexistent-id");

      expect(result).toBeNull();
    });
  });

  describe("softDelete", () => {
    it("sets deletedAt without removing the record", async () => {
      const { db } = await import("@/lib/db");
      const setSpy = vi.spyOn(db, "set");

      await repo.softDelete("test-id-001");

      expect(setSpy).toHaveBeenCalledWith(
        expect.objectContaining({ deletedAt: expect.any(Date) })
      );
    });
  });
});
```

---

### 5D. Hierarchical Rule File Naming Convention

```
.cursor/rules/
  01-core.mdc                 → Always active: identity, stack, core constraints
  02-frontend.mdc             → Glob: src/components/**,src/app/**
  03-api-templates.mdc        → Glob: src/api/**
  04-database.mdc             → Glob: src/db/**,db/**
  05-testing.mdc              → Glob: tests/**,**/*.test.ts,**/*.spec.ts
  06-security.mdc             → Glob: src/middleware/**,src/auth/**

.claude/rules/
  01-core.md                  → @imported in CLAUDE.md always
  02-api-patterns.md          → @imported conditionally
  03-testing-standards.md     → @imported for test tasks

.trae/rules/
  api.rules                   → Applied when working in src/api/ (3-level nesting)
  database.rules              → Applied when working in src/db/
```

---

## TEMPLATE 6 — WORKFLOWS

> **What this is:** Deterministic, multi-step task orchestrations that combine agent instructions with hooks to guarantee safe, verifiable execution from start to finish.

---

### 6A. Feature Development Workflow

```markdown
# Workflow: Feature Development
# Trigger: "implement feature", "build feature", "add [feature name]"
# Safety: Hooks enforce formatting and test gates at each write operation.

---

## Phase 1 — Understand

1. Read the feature request or issue.
2. Identify affected files using the codebase graph.
3. Identify which architectural layers are touched:
   [ ] Route handler (src/api/)
   [ ] Repository (src/services/)
   [ ] Schema (src/db/)
   [ ] UI Component (src/components/)
   [ ] Test (tests/)

4. Spawn an Investigation Subagent if more than 5 files are involved.
5. Output: A brief implementation plan (3–5 bullet points). Do NOT begin coding yet.

---

## Phase 2 — Scaffold

6. Create the database schema change (if applicable):
   - Add to the relevant schema file in src/db/schema/
   - Generate migration: `pnpm drizzle-kit generate`
   - NEVER manually edit migration files

7. Create the Repository method(s) using the Repository template (Template 5B).

8. Create the Route handler using the API template (Template 5A).

9. Create the Test file using the Test template (Template 5C).

---

## Phase 3 — Implement

10. Fill in business logic in the Repository and Route handler.
11. Write assertions in the test file before writing implementation (TDD where possible).
12. PostToolUse hook auto-formats each file on write — no manual formatting needed.

---

## Phase 4 — Verify (Stop Hook enforces this)

13. Run: `pnpm turbo run test` → must return 0 failures
14. Run: `pnpm run lint` → must return 0 errors
15. Run: `npx tsc --noEmit` → must return 0 type errors
16. Run: `pnpm turbo run build` → must exit 0

If any step fails: fix and restart Phase 4 from step 13.

---

## Phase 5 — Document

17. Update the relevant OpenAPI spec comment in the route handler (if applicable).
18. Add an entry to CHANGELOG.md under the current version.
19. Output a task summary:
    - What was built
    - Files changed (list)
    - How to test manually
    - Any follow-up tasks identified
```

---

### 6B. Bug Fix Workflow

```markdown
# Workflow: Bug Fix
# Trigger: "fix bug", "fix issue #[N]", "there's a bug in [component]"
# Safety: PreToolUse hook blocks destructive writes. Stop hook gates completion.

---

## Phase 1 — Reproduce

1. Fetch the issue context:
   gh issue view {ISSUE_NUMBER} --json title,body,labels,comments

2. Identify the reproduction steps from the issue body.

3. Locate the failing code:
   grep -r "[error_string_or_function_name]" src/ --include="*.ts" -l

4. Confirm the bug exists before writing any fix.

---

## Phase 2 — Write a Failing Test First

5. Add a test case that reproduces the bug in tests/[relevant-domain]/.
6. Run the test — it MUST fail before proceeding.
   pnpm turbo run test -- --testPathPattern="[test-file]"

---

## Phase 3 — Fix

7. Implement the minimal fix — change only what is necessary.
8. NEVER refactor unrelated code during a bug fix.
9. PostToolUse hook formats automatically on each write.

---

## Phase 4 — Verify the Fix

10. Run the previously failing test — it MUST now pass.
11. Run the full test suite — no regressions permitted:
    pnpm turbo run test
12. Run lint and type check:
    pnpm run lint && npx tsc --noEmit

---

## Phase 5 — Close

13. Output a fix summary:
    - Root cause (1–2 sentences)
    - Fix applied (1–2 sentences)
    - Test added (file path and test name)
    - Issue number: #[N]
```

---

### 6C. Code Review / Adversarial Verification Workflow

```markdown
# Workflow: Self-Adversarial Code Review
# Trigger: "review my code", "check this PR", "adversarial review"
# Pattern: Agent reviews its own output as if it were a hostile reviewer.

---

## Phase 1 — Security Audit

1. Scan for hardcoded secrets or tokens:
   grep -rE "(password|secret|api_key|token)\s*=\s*['\"][^'\"]{6,}" src/

2. Check for unvalidated inputs at API boundaries.
3. Check for SQL injection vectors (raw string interpolation in queries).
4. Check for missing authentication guards on protected routes.

---

## Phase 2 — Logic Audit

5. Trace every execution path through the changed code.
6. Identify edge cases: null inputs, empty arrays, concurrent requests, network failures.
7. Verify error handling: no silent catches, no raw error messages exposed to clients.

---

## Phase 3 — Test Coverage Audit

8. Identify any new code path without a corresponding test.
9. Identify any test that only asserts the happy path.
10. Add missing edge-case tests.

---

## Phase 4 — Performance Audit

11. Check for N+1 query patterns in database access.
12. Check for unbounded queries (no LIMIT on database selects).
13. Check for missing indexes on frequently queried columns.

---

## Phase 5 — Final Verification Gate

14. Run full suite: pnpm turbo run test
15. Run lint: pnpm run lint
16. Run type check: npx tsc --noEmit
17. Run build: pnpm turbo run build

Output a review summary with findings grouped by:
[ ] Critical (must fix before merge)
[ ] Warning (should fix)
[ ] Suggestion (nice to have)
```

---

### 6D. MCP-Integrated Workflow (Dynamic Schema Query)

```markdown
# Workflow: MCP-Assisted Feature Build
# Trigger: When building database-touching features requiring live schema awareness
# Requires: MCP server configured in .claude/mcp/database.json

---

## Phase 1 — Query Live Schema via MCP

1. Connect to the MCP database server.
2. Fetch the current schema for the relevant table(s):
   [MCP tool call: schema.query({ tables: ["[table_name]"] })]

3. NEVER rely on static schema documentation — always query live state.
4. Identify:
   - Column names and types
   - Nullable vs required columns
   - Foreign key relationships
   - Existing indexes

---

## Phase 2 — Build Against Ground Truth

5. Generate the Drizzle ORM schema definition from the live query output.
6. Generate the Zod validation schema to match exactly.
7. Generate TypeScript types from both.

---

## Phase 3 — Standard Feature Workflow

8. Continue with Feature Development Workflow (Template 6A), Phase 2 onward.
   All code is now grounded in the verified live schema, not stale documentation.
```

---

## QUICK REFERENCE — Token Budget Rules

These limits come directly from the research and apply to ALL instruction files:

| Rule | Limit | Rationale |
|---|---|---|
| Max reliable instructions | 150–200 | Beyond this, models experience attention degradation |
| Available after IDE system prompt | ~100–150 | IDE uses ~50 instruction slots itself |
| Max file length | 500 lines | Longer files cause catastrophic instruction forgetting |
| Quotes or explanations | 0 | Pure imperatives only — "why" wastes tokens |
| `alwaysApply: true` files | Use sparingly | Globally active rules degrade Cursor performance |
| Formatting in instruction files | 1 command | Delegate to `prettier` + `eslint`, not natural language rules |

---

*Templates derived from: Standardizing Autonomous AI Agent Behavior — Semantics, Scaffolding, and Implementation Patterns Across Modern IDEs*
