---
title: AGENTS.md — AI Tool Entry Point
description: First file AI tools should read before acting on this repository.
author: bluestella
date: 2026-06-20
version: 1.1.0
---

# AGENTS.md

> **AI tools: read this file first.** It describes what this repository is, how it is structured, which agent roles exist, how work flows between them, and what you must never touch. Subdirectory `AGENTS.override.md` files take precedence over this file for their directory.

> [!CAUTION]
> **Do NOT modify `.github/` in any way.** That folder is a GitHub AI runtime container managed exclusively by a sync script. All authoring happens in the root workspace folders (`agents/`, `instructions/`, `hooks/`, `skills/`, `docs/`).
>
> **Do NOT create, rename, or delete agent files** unless the human has explicitly asked you to do so in the current session. The agent roster is intentional and version-controlled.

---

## What this repository is

`bluestella-agency-pack` is a structured collection of AI agent role cards, skills, instructions, hooks, and templates that define a full software-delivery team. The agents span product management, business analysis, architecture, frontend, backend, quality, and DevOps. Each agent has a documented role card, a responsibilities list, a tool stack, and a Definition of Done.

The root folders (`agents/`, `instructions/`, `hooks/`, `skills/`, `docs/`) are the **source-of-truth workspace** — all authoring and editing happens here. `.github/` is the **GitHub AI runtime container**: it is read-only from an AI tool's perspective and is populated exclusively by a Python sync script that mirrors files from the root structure. `.vscode/` holds workspace editor settings.

---

## AI Tool Discovery Map

Different tools look in different places. Use the table below to find the right config file for your tool.

| Tool | Entry point | Full config |
| ---- | ----------- | ----------- |
| **Claude (Anthropic)** | `AGENTS.md` (this file) | This file is the full spec. Subdirectory `AGENTS.override.md` overrides for that path. |
| **GitHub Copilot** | `.github/copilot-instructions.md` | `.github/agents/copilot-agent.md`, `.github/instructions/*.instructions.md` |
| **OpenAI Codex** | `.github/agents/codex-agent.md` | Same file |
| **Trae / Cursor / Windsurf** | `.github/agents/trae-agent.md` | Same file |

> **Do not modify `.github/copilot-instructions.md` without explicit human approval.**

---

## Repository Directory Tree

```
bluestella-agency-pack/
│
├── AGENTS.md                          # This file — AI tool entry point (root source of truth)
├── INIT.md                            # Reference links for writing good agents, skills, and hooks
├── PLANS.md                           # Master implementation plan: agent roster, workflow, skills, artifacts
├── PLANS_Working Document.md          # Working draft of PLANS.md (do not treat as authoritative)
├── concept.excalidraw                 # Architecture concept diagram (visual only, do not edit via AI)
│
├── agents/                            # Agent role cards, nested by team
│   ├── management/
│   │   └── tech-lead.md              # Tech Lead role card + 7-gate PR scoring checklist
│   ├── analysis/                      # (planned) Business Analyst role card
│   ├── architecture/                  # (planned) Solution, Integration, Data, Security Architect cards
│   ├── frontend/
│   │   ├── react-engineer.md         # React Engineer role card
│   │   └── react-native-engineer.md  # React Native Engineer role card
│   ├── backend/
│   │   └── microservices-engineer.md # Microservices / Vercel Serverless Engineer role card
│   ├── quality/
│   │   ├── automation-testing-engineer.md   # Visual + API + unit test automation
│   │   ├── performance-testing-engineer.md  # Load, stress, Core Web Vitals
│   │   └── security-engineer.md             # STRIDE threat modelling + QA-phase security validation
│   └── devops/
│       └── devops-engineer.md        # CI/CD, Vercel deployments, IaC
│
├── instructions/                      # (planned) Step-by-step how-to guides for recurring tasks per agent/team
│
├── hooks/                             # (planned) Trigger conditions for agent hand-offs and feedback loop re-runs
│
├── skills/                            # Reusable prompt skills following agentskills.io specification
│   ├── README.md                      # Skill authoring guide and folder contract
│   ├── templates/                     # (planned) Document templates: BRD, ADR, test plan, bug report
│   ├── references/                    # (planned) External docs, standards, and best-practice links per skill
│   ├── scripts/                       # (planned) Executable skill scripts
│   └── resources/                     # Skill assets and supporting files
│
├── docs/                              # General documentation
│   ├── AI IDE Generation Standards including VSCode.md   # Standards for AI-assisted code generation in IDEs
│   └── AI_IDE_Generation_Templates.md                   # Templates used by AI IDE generation workflows
│
├── .github/                           # ⚠ GitHub AI runtime — READ ONLY for AI tools
│   │                                  # Managed by the root-to-.github sync script. DO NOT edit directly.
│   ├── AGENTS.md                      # Pointer → root AGENTS.md (sync script writes this; never edit here)
│   ├── copilot-instructions.md        # Copilot default discovery entry point
│   ├── agents/
│   │   ├── copilot-agent.md          # Copilot full behavioral spec (identity, stack, workflow, boundaries)
│   │   ├── codex-agent.md            # Codex / ChatGPT behavioral spec
│   │   └── trae-agent.md             # Trae IDE behavioral spec
│   ├── instructions/                  # Scoped Copilot instructions (applyTo glob patterns)
│   │   ├── api-patterns.instructions.md   # Route handler structure, Zod validation, soft-delete rules
│   │   ├── security.instructions.md       # Security coding standards
│   │   └── testing.instructions.md        # Test authoring standards
│   ├── templates/                     # Code and document templates
│   │   ├── api-endpoint.md           # API endpoint scaffold
│   │   ├── repository-pattern.md     # Repository layer scaffold
│   │   └── test-file.md              # Test file scaffold
│   └── workflows/
│       └── ci.yml                    # GitHub Actions CI pipeline (lint → test → type-check → build)
│
└── .vscode/
    └── settings.json                  # VS Code workspace settings
```

---

## Agent Roster

All agents follow the **Role Card** format: Role & Overview · Responsibilities · Tools & Stack · Definition of Done. Files live at `agents/[team]/[agent-name].md`.

| Team | Agent | File |
| ---- | ----- | ---- |
| Management | Tech Lead | `agents/management/tech-lead.md` |
| Analysis | Business Analyst | `agents/analysis/business-analyst.md` *(planned)* |
| Architecture | Solution Architect | `agents/architecture/solution-architect.md` *(planned)* |
| Architecture | Integration Architect | `agents/architecture/integration-architect.md` *(planned)* |
| Architecture | Data Architect | `agents/architecture/data-architect.md` *(planned)* |
| Architecture | Security Architect | `agents/architecture/security-architect.md` *(planned)* |
| Frontend | React Engineer | `agents/frontend/react-engineer.md` |
| Frontend | React Native Engineer | `agents/frontend/react-native-engineer.md` |
| Frontend | SEO Engineer | `agents/frontend/seo-engineer.md` *(planned)* |
| Frontend | A11y Engineer | `agents/frontend/a11y-engineer.md` *(planned)* |
| Backend | Microservices Engineer | `agents/backend/microservices-engineer.md` |
| Quality | Automation Testing Engineer | `agents/quality/automation-testing-engineer.md` |
| Quality | Performance Testing Engineer | `agents/quality/performance-testing-engineer.md` |
| Quality | Security Engineer | `agents/quality/security-engineer.md` |
| DevOps | DevOps / Platform Engineer | `agents/devops/devops-engineer.md` |

---

## Agent Workflow & Hierarchy

Work flows top-down through the pipeline and loops back upstream when issues are found.

```
Product Manager
  └─ Business Analyst          (BRD → Epics → User Stories → Tasks → Sub-tasks)
       └─ Architecture Team    (led by Solution Architect)
            ├─ Solution Architect      → unified tech stack + C4 diagrams
            ├─ Integration Architect   → API contracts, event flows, sequence diagrams
            ├─ Data Architect          → schemas, governance, data lineage
            └─ Security Architect      → auth, encryption, compliance, incident response
                 │
                 ▼  architecture blueprint
            Tech Lead                  (orchestrates engineering; reviews + scores all PRs)
            ◄──────────────────────────── alignment loop (Tech Lead ↔ Architecture Team)
                 │
          ┌──────┴──────┐
     Frontend Team   Backend Team
     - React          - Microservices Engineer
     - React Native
     - SEO Engineer
     - A11y Engineer
          │               │
          └──────┬─────────┘
                 ▼
           Quality Team              (validates against requirements; raises bug checklists)
           - Automation Testing Engineer  (visual, API, unit, integration)
           - Performance Testing Engineer (load, stress, Core Web Vitals)
           - Security Engineer            (STRIDE threat modelling)
                 │
                 ▼
           DevOps / Platform Engineer     (CI/CD → Vercel → Production)
```

### Feedback Loops

Issues discovered at any stage re-trigger the appropriate upstream agent:

| From | To | Trigger |
| ---- | -- | ------- |
| Automation Testing Engineer | Frontend / Backend Engineer | Code bugs in visual or API tests |
| Automation Testing Engineer | Tech Lead | Recurring failures indicating systemic quality issues |
| Performance Testing Engineer | Developer / Tech Lead | SLA breach or performance bottleneck |
| Performance Testing Engineer | Architecture Team | Bottleneck requiring architectural change |
| Security Engineer | Developer / Business Analyst | STRIDE finding → new requirement ticket |
| Security Engineer | Architecture Team | Design-level threat requiring architectural change |
| Tech Lead | Developer | PR score below gate threshold → bug ticket raised and reassigned |
| Tech Lead ↔ Architecture Team | Each other | Technical debt resolution and alignment |
| DevOps | Tech Lead | Deployment failure requiring engineering changes |

---

## Quality Gates (Tech Lead Scoring Checklist)

Every PR must pass all applicable gates. One red gate = bug ticket raised + PR reassigned. Full details in `agents/management/tech-lead.md`.

| Gate | Metric | Threshold | Tool |
| ---- | ------ | --------- | ---- |
| 1 — Unit Test Coverage | Statement / Line / Branch / Function | ≥ 90% each | Vitest `--coverage` + Codecov |
| 2 — Type Safety | TypeScript compile errors | 0 | `tsc --noEmit` |
| 3 — Linting | ESLint errors; warnings on enforced rules | 0 | ESLint + `@typescript-eslint` |
| 4 — Code Quality | SonarCloud Blocker / Critical / Major issues; duplication; cognitive complexity | 0 issues; < 3% dupe; ≤ 15 complexity | SonarCloud |
| 5 — Security Vulnerabilities | Dependency CVEs (any severity); SAST findings; hardcoded secrets | 0 open | `pnpm audit` + CodeQL + GitHub Secret Scanning |
| 6 — QA Bug Checklist | Open bugs at any severity (P0–P3) | 0 open | GitHub Issues (`bug:*` labels) |
| 7 — No Debug Artifacts | `console.log`, `debugger`, untracked TODO/FIXME | 0 | ESLint `no-console` / `no-debugger` |

**Pass** = all applicable gates green → approve and merge.
**Fail** = any gate red → raise bug ticket → reassign to responsible engineer.

---

## Technology Stack

| Layer | Technology |
| ----- | ---------- |
| Language | TypeScript 5.x |
| Runtime | Node.js 20 LTS |
| Package manager | pnpm *(never substitute npm or yarn)* |
| Frontend | React, React Native |
| Backend | Vercel Serverless Functions |
| Database | PostgreSQL 16 + Drizzle ORM |
| Auth | Auth.js v5 |
| Testing | Vitest (unit/coverage), Playwright (E2E + visual) |
| Linting | ESLint + `@typescript-eslint`, Prettier |
| CI | GitHub Actions |
| Deployment | Vercel (preview + production) |
| Code quality | SonarCloud, GitHub CodeQL, Codecov, Dependabot |

**Do not introduce packages not listed above without explicit human approval.**

### CI Pipeline Order

```
lint  →  test  →  type-check  →  build
```

All jobs must be green before merge. Commands:

```bash
pnpm install                          # install dependencies
pnpm lint                             # ESLint — must exit 0
pnpm vitest run --coverage            # tests + coverage — must exit 0, coverage ≥ 90%
pnpm tsc -p tsconfig.json --noEmit    # type-check — must exit 0
pnpm build                            # build — must exit 0
```

---

## Hard Boundaries — NEVER Touch

### Repository structure

```
.github/**                # GitHub AI runtime — READ ONLY. Managed by sync script. Never create,
                          # edit, rename, or delete any file here unless explicitly instructed.
db/migrations/**          # database migration files — never modify
.env*                     # environment files — never read or modify
infra/**                  # infrastructure-as-code — never modify
```

### Agent roster

Do not create, rename, or delete agent files under `agents/` unless the human has **explicitly requested it in the current session**. The roster is intentional. If a planned agent is missing, leave it as-is; do not scaffold it speculatively.

### Code rules

- **Never** import a package not in the approved stack without explicit human approval.
- **Never** commit directly to `main` from automation.
- **Never** expose raw exception messages in API responses.
- **Never** perform hard-deletes on production data (soft-delete only).
- **Never** introduce a silent `catch` block.
- **Never** query the database directly from route handlers (use the repository/service layer).
- **Never** hand back work with any CI check failing.

---

## PR & Commit Conventions

### PR Title Format

```
feat(scope): short description
fix(scope): short description
chore(scope): short description
refactor(scope): short description
test(scope): short description
docs(scope): short description
```

### Required PR Body Sections

```markdown
## Summary
<!-- What was changed and why -->

## Motivation
<!-- Business or technical reason for the change -->

## Test Plan
<!-- How the change was tested (commands run, coverage output) -->

## Checklist
- [ ] All CI jobs pass
- [ ] Coverage ≥ 90%
- [ ] No TypeScript errors
- [ ] No ESLint errors
- [ ] No hardcoded secrets or debug artifacts
- [ ] `AGENTS.override.md` updated if new subdirectory constraints apply
```

### CI Gate

All CI jobs (`lint`, `test`, `type-check`, `build`) must pass before merge. Branch protection enforces this — no exceptions.

---

## Filename & Formatting Conventions

### File naming

- All markdown files: **kebab-case** — e.g. `react-engineer.md`, `api-patterns.instructions.md`
- Agent role cards: `agents/[team]/[agent-name].md`
- Scoped Copilot instructions: `[topic].instructions.md` (with `applyTo` glob in frontmatter)
- Skill directories: `skills/[skill-name]/SKILL.md` (SKILL.md in all-caps per agentskills.io spec)
- Subdirectory overrides: `AGENTS.override.md` (takes precedence over root `AGENTS.md`)

### Frontmatter

Every agent role card and planning document must include YAML frontmatter:

```yaml
---
title: Human-readable title
team: management | analysis | architecture | frontend | backend | quality | devops
version: 1.0.0
---
```

Skills use the agentskills.io frontmatter schema (see `skills/README.md`).

### Folder structure contract

- `agents/` — role cards only. No scripts, no templates. Do not add files here without explicit instruction.
- `instructions/` — procedural how-to guides only. One file per task type.
- `hooks/` — trigger condition definitions only.
- `skills/` — self-contained skill packages (`SKILL.md` + optional `scripts/`, `references/`, `assets/`).
- `docs/` — general documentation. Not agent specs.
- `.github/` — **read-only for AI tools.** GitHub AI runtime container. Source of truth lives in root folders; the sync script populates `.github/`. Never write here directly.

---

## References

- [How to write a good agent — Phil Schmid](https://www.philschmid.de/writing-good-agents)
- [Awesome Copilot — GitHub](https://github.com/github/awesome-copilot/)
- [Agent Skills Specification — agentskills.io](https://agentskills.io/specification)
- [Epics, Stories and Themes — Atlassian](https://www.atlassian.com/agile/project-management/epics-stories-themes)
