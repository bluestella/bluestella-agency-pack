---
title: AGENTS.md — AI Tool Entry Point
description: First file AI tools should read before acting on this repository.
author: bluestella
date: 2026-06-20
version: 1.2.0
---

# AGENTS.md

> **AI tools: read this file first.** It describes what this repository is, how it is structured, which agent roles exist, how work flows between them, and what you must never touch. Subdirectory `AGENTS.override.md` files take precedence over this file for their directory.

> [!CAUTION]
> **Do NOT modify `.github/` in any way.** That folder is a GitHub AI runtime container managed exclusively by a sync script. All authoring happens in the root workspace folders (`agents/`, `instructions/`, `hooks/`, `skills/`, `templates/`, `docs/`).
>
> **Do NOT create, rename, or delete agent files** unless the human has explicitly asked you to do so in the current session. The agent roster is intentional and version-controlled.

---

## What this repository is

`bluestella-agency-pack` is a structured collection of AI agent role cards, skills, instructions, hooks, and templates that define a full software-delivery team. The agents span product management, business analysis, architecture, frontend, backend, quality, and DevOps. Each agent has a documented role card, a responsibilities list, a tool stack, and a Definition of Done.

The root folders (`agents/`, `instructions/`, `hooks/`, `skills/`, `templates/`, `docs/`) are the **source-of-truth workspace** — all authoring and editing happens here. `.github/` is the **GitHub AI runtime container**: it is read-only from an AI tool's perspective and is populated exclusively by a Python sync script that mirrors files from the root structure. `.vscode/` holds workspace editor settings.

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
├── CONTRIBUTING.md                    # Authoring guide: versioning, metrics, learning loop, PR conventions
├── LEARNINGS.md                       # Accumulated authoring learnings; updated by learning-loop-update hook
├── METRICS.md                         # Quality scoreboard for all agents, skills, hooks, instructions
├── INIT.md                            # Reference links for writing good agents, skills, and hooks
├── PLANS.md                           # Master implementation plan: agent roster, workflow, skills, artifacts
├── PLANS_Working Document.md          # Working draft of PLANS.md (do not treat as authoritative)
├── concept.excalidraw                 # Architecture concept diagram (visual only, do not edit via AI)
│
├── agents/                            # Agent role cards, nested by team
│   ├── management/
│   │   └── tech-lead.md              # Tech Lead role card + 7-gate PR scoring checklist
│   ├── analysis/
│   │   └── business-analyst.md       # Business Analyst role card
│   ├── architecture/
│   │   ├── solution-architect.md     # Solution Architect role card
│   │   ├── integration-architect.md  # Integration Architect role card
│   │   ├── data-architect.md         # Data Architect role card
│   │   └── security-architect.md     # Security Architect role card
│   ├── frontend/
│   │   ├── react-engineer.md         # React Engineer role card
│   │   ├── react-native-engineer.md  # React Native Engineer role card
│   │   ├── seo-engineer.md           # SEO Engineer role card
│   │   └── a11y-engineer.md          # Accessibility Engineer role card
│   ├── backend/
│   │   └── microservices-engineer.md # Microservices / Vercel Serverless Engineer role card
│   ├── quality/
│   │   ├── automation-testing-engineer.md   # Visual + API + unit test automation
│   │   ├── performance-testing-engineer.md  # Load, stress, Core Web Vitals
│   │   └── security-engineer.md             # STRIDE threat modelling + QA-phase security validation
│   ├── devops/
│   │   └── devops-engineer.md        # CI/CD, Vercel deployments, IaC
│   └── tools/
│       └── agency-pack-author.md     # Meta-agent: authors and maintains all pack artifacts
│
├── instructions/                      # Scoped how-to guides; each has applyTo glob in frontmatter
│   ├── agent-role-card.instructions.md   # Rules for authoring agent role cards
│   ├── skill-authoring.instructions.md   # Rules for authoring SKILL.md files
│   ├── hook-authoring.instructions.md    # Rules for authoring hook definitions
│   ├── plans-authoring.instructions.md   # Rules for maintaining PLANS.md
│   ├── api-patterns.instructions.md      # Route handler structure, Zod validation, soft-delete rules
│   ├── brd-authoring.instructions.md     # BRD authoring rules
│   ├── c4-diagramming.instructions.md    # C4 diagram authoring rules
│   ├── security.instructions.md          # Security coding standards
│   └── testing.instructions.md           # Test authoring standards
│
├── hooks/                             # Agent hand-off triggers and feedback loop definitions
│   ├── version-bump.md               # Versioning rules: patch/minor/major bump logic for all files
│   ├── low-score-flag.md             # Fires when an artifact scores below 7/10 → human review
│   ├── learning-loop-update.md       # Fires after any session with net-new authoring insights → LEARNINGS.md
│   ├── tech-lead-pr-score-to-developer.md
│   ├── qa-test-findings-to-developer.md
│   ├── qa-systemic-issues-to-tech-lead.md
│   ├── security-finding-to-ba-requirement.md
│   ├── security-findings-to-dev-architect.md
│   ├── performance-bottleneck-to-dev-architect.md
│   ├── developer-to-devops-deployment-readiness.md
│   ├── devops-to-security-infrastructure-audit.md
│   ├── deployment-failure-to-tech-lead.md
│   ├── tech-lead-to-architecture-technical-debt.md
│   ├── product-manager-tech-lead-roadmap-conflict.md
│   └── architecture-enforcement-api-compliance.md
│
├── skills/                            # Reusable prompt skills following agentskills.io specification
│   ├── README.md                      # Skill authoring guide and folder contract
│   ├── brd/                           # BRD generation skill
│   ├── role-card-generator/           # Agent role card generation skill
│   └── [skill-name]/                  # Each skill: SKILL.md + optional scripts/, references/, assets/
│
├── templates/                         # Cross-cutting scaffold templates (source of truth; .github/ is mirror)
│   ├── agent-role-card.md            # Role card scaffold
│   ├── skill-md.md                   # SKILL.md scaffold
│   ├── hook-definition.md            # Hook definition scaffold
│   ├── brd-epic.md                   # BRD Epic → Story → Task document scaffold
│   ├── api-endpoint.md               # TypeScript API route handler scaffold
│   ├── repository-pattern.md         # TypeScript repository class scaffold
│   └── test-file.md                  # Vitest test file scaffold
│
├── docs/                              # General documentation
│   ├── AI IDE Generation Standards including VSCode.md
│   └── AI_IDE_Generation_Templates.md
│
├── .github/                           # ⚠ GitHub AI runtime — READ ONLY for AI tools
│   │                                  # Managed by the root-to-.github sync script. DO NOT edit directly.
│   ├── AGENTS.md                      # Pointer → root AGENTS.md (sync script writes this; never edit here)
│   ├── copilot-instructions.md        # Copilot default discovery entry point
│   ├── agents/
│   │   ├── agency-pack-author.md     # Agency Pack Author spec for GitHub AI runtime
│   │   ├── copilot-agent.md          # Copilot full behavioral spec
│   │   ├── codex-agent.md            # Codex / ChatGPT behavioral spec
│   │   └── trae-agent.md             # Trae IDE behavioral spec
│   ├── instructions/                  # Scoped Copilot instructions (mirror of root instructions/)
│   ├── templates/                     # Mirror of root templates/
│   ├── skills/                        # Mirror of root skills/
│   ├── hooks/                         # Mirror of root hooks/
│   └── workflows/
│       └── ci.yml                    # GitHub Actions CI pipeline
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
| Analysis | Business Analyst | `agents/analysis/business-analyst.md` |
| Architecture | Solution Architect | `agents/architecture/solution-architect.md` |
| Architecture | Integration Architect | `agents/architecture/integration-architect.md` |
| Architecture | Data Architect | `agents/architecture/data-architect.md` |
| Architecture | Security Architect | `agents/architecture/security-architect.md` |
| Frontend | React Engineer | `agents/frontend/react-engineer.md` |
| Frontend | React Native Engineer | `agents/frontend/react-native-engineer.md` |
| Frontend | SEO Engineer | `agents/frontend/seo-engineer.md` |
| Frontend | A11y Engineer | `agents/frontend/a11y-engineer.md` |
| Backend | Microservices Engineer | `agents/backend/microservices-engineer.md` |
| Quality | Automation Testing Engineer | `agents/quality/automation-testing-engineer.md` |
| Quality | Performance Testing Engineer | `agents/quality/performance-testing-engineer.md` |
| Quality | Security Engineer | `agents/quality/security-engineer.md` |
| DevOps | DevOps / Platform Engineer | `agents/devops/devops-engineer.md` |
| Tools | Agency Pack Author | `agents/tools/agency-pack-author.md` |

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
| Agency Pack Author | Agency Pack Author | Learning loop update after any authoring session with new insights |
| Agency Pack Author | Human | Artifact score below 7/10 → `low-score-flag` hook → human review required |

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
team: management | analysis | architecture | frontend | backend | quality | devops | tools
version: 1.0.0
score: null          # filled by METRICS.md evaluation
last_evaluated: null # ISO date of last score review
needs_review: false  # true when score < 7 — human review required
skills:
  - skill-name
hooks:
  emits:
    - trigger-name
  receives:
    - trigger-name
---
```

Skills use the agentskills.io frontmatter schema (see `skills/README.md` and `templates/skill-md.md`).

### Folder structure contract

- `agents/` — role cards only. No scripts, no templates. Do not add files here without explicit instruction.
- `instructions/` — procedural how-to guides only. One file per task type. All files require `applyTo` glob in frontmatter.
- `hooks/` — trigger condition definitions only. One hook per distinct feedback loop.
- `skills/` — self-contained skill packages (`SKILL.md` + optional `scripts/`, `references/`, `assets/`).
- `templates/` — cross-cutting scaffold templates for agents, skills, hooks, BRDs, and code. Skill-specific templates live inside each skill's own `templates/` subdirectory.
- `docs/` — general documentation. Not agent specs.
- `METRICS.md` — quality scoreboard; updated after every artifact evaluation. Do not edit the Flagged Artifacts table without evaluating the artifact first.
- `LEARNINGS.md` — authoring learnings log; updated by the `learning-loop-update` hook only.
- `.github/` — **read-only for AI tools.** GitHub AI runtime container. Source of truth lives in root folders; the sync script populates `.github/`. Never write here directly.

---

## References

- [How to write a good agent — Phil Schmid](https://www.philschmid.de/writing-good-agents)
- [Awesome Copilot — GitHub](https://github.com/github/awesome-copilot/)
- [Agent Skills Specification — agentskills.io](https://agentskills.io/specification)
- [Epics, Stories and Themes — Atlassian](https://www.atlassian.com/agile/project-management/epics-stories-themes)

---

## Revision History

| Version | Date | Author | Change Summary |
| ------- | ---- | ------ | -------------- |
| 1.2.0 | 2026-06-20 | bluestella | Added templates/ directory, tools team, agency-pack-author, METRICS.md, LEARNINGS.md, versioning system, learning loop. Updated directory tree, roster, feedback loops, frontmatter schema, folder contract. |
| 1.1.0 | 2026-06-20 | bluestella | Previous update |
| 1.0.0 | 2026-06-19 | bluestella | Initial version |
