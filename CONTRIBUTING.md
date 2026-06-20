# Contributing to Bluestella Agency Pack

Thank you for contributing to the **Bluestella Agency Pack**! This document outlines the standards, structural patterns, and authoring guidelines for extending our AI-agent software delivery team.

Please read this guide thoroughly before creating or modifying any cards, skills, hooks, instructions, or templates.

---

## Critical Contribution Boundaries

Before drafting changes, keep these hard constraints in mind:

1. **Never modify `.github/**` directly during execution.** The `.github` folder is a read-only runtime mirror managed by synchronization scripts. All authoring and manual edits must happen in the root folders (`agents/`, `skills/`, `hooks/`, `instructions/`, `templates/`).
2. **Never create, rename, or delete agent cards** under `agents/` unless explicitly instructed by a human. The roster is intentional and version-controlled.
3. **Always use kebab-case** for file naming (e.g., `react-native-engineer.md`, `qa-bug-feedback.md`).
4. **Mandatory YAML Frontmatter**: Every file (agent, skill, hook, instruction, plan) must include a YAML frontmatter block with at minimum: `version`, and the artifact-type-specific required fields below.
5. **Version every file you touch.** See Section 6 — Versioning for the bump rules.
6. **Score new artifacts** in `METRICS.md` before closing a session. See Section 7 — Metrics & Scoring.
7. **Source of truth is always root.** When any conflict exists between a root file and a `.github/` mirror, the root file wins.

---

## 1. Authoring Agent Role Cards

Agent role cards define the behaviors, scope of ownership, tool stack, and quality gates for each team role.

- **File Location**: `agents/[team]/[agent-name].md`
- **Valid Team Folder values**: `management` | `analysis` | `architecture` | `frontend` | `backend` | `quality` | `devops` | `tools`
- **Scoped System Guidelines**: `instructions/agent-role-card.instructions.md`
- **Markdown Template**: `templates/agent-role-card.md`

### Frontmatter Schema

```yaml
---
title: Human-readable role name (e.g., React Native Engineer)
team: [team value from list above]
version: 1.0.0
score: null          # set by METRICS.md evaluation
last_evaluated: null # ISO date of last score review
needs_review: false  # set true when score < 7
skills:
  - [skill-name]        # flat list of folders under skills/ this agent can invoke
hooks:
  emits:
    - [trigger-name]    # hook triggers this agent fires
  receives:
    - [trigger-name]    # hook triggers this agent listens for
---
```

### Required Sections

1. **Role & Overview**: One paragraph stating what this agent owns, its pipeline position, and value.
2. **Responsibilities**: An outcome-focused bulleted list starting with active verbs. Avoid vague descriptions.
3. **Tools & Stack**: A markdown table (`Tool | Purpose | Cost`) containing only tools this agent uses.
4. **Definition of Done (DoD)**: A paragraph describing the finished state, followed by a measurable Metrics & Scoring Checklist.

---

## 2. Authoring Skills

Skills are modular, reusable prompt packages following the `agentskills.io` specification.

- **Folder Structure**:
  ```
  skills/[skill-name]/
  ├── SKILL.md          # Required: metadata + instructions (all caps)
  ├── scripts/          # Optional: executable script helpers
  ├── references/       # Optional: REFERENCE.md and domain docs
  └── assets/           # Optional: templates and static resources
  ```
- **Scoped System Guidelines**: `instructions/skill-authoring.instructions.md`
- **Markdown Template**: `templates/skill-md.md`

### Name Validation Rules

- Directory name must exactly match the `name` field in `SKILL.md` frontmatter.
- 1–64 characters, lowercase alphanumeric and hyphens only.
- No consecutive hyphens (`--`); cannot start or end with a hyphen.

### SKILL.md Frontmatter Schema

```yaml
---
name: skill-name-kebab-case
description: >
  [Verb phrase describing output]. Use when [trigger keywords and phrases].
instructions:
  - [instruction-filename]  # without .instructions.md suffix
agents:
  - [agent-name]            # agents that invoke this skill
triggers: []                # hook trigger names this skill fires
license: MIT
metadata:
  author: bluestella
  version: "1.0"
  score: null
  last_evaluated: null
  needs_review: false
---
```

### Required Sections

1. **Overview**: What the skill produces, input it expects, output format.
2. **Steps**: Actionable numbered list; each step names the tool, command, or file used.
3. **Output Format**: Code blocks or schemas showing the final artifact structure.
4. **Examples**: At least one happy path example; optionally one edge case.
5. **Edge Cases**: Scenarios requiring human input or specific fallbacks.

> **Progressive Disclosure Pattern:** Keep `SKILL.md` under 500 lines. Move heavy reference material to `references/REFERENCE.md` and logic to `scripts/`.

---

## 3. Authoring Hooks (Feedback Loops)

Hooks capture the trigger boundaries modeling the workflow loops defined in `PLANS.md` Step 2.

- **File Location**: `hooks/[source-agent-shortname]-[event].md`
- **Scoped System Guidelines**: `instructions/hook-authoring.instructions.md`
- **Markdown Template**: `templates/hook-definition.md`

### Frontmatter Schema

```yaml
---
trigger: [machine-readable-event-name, kebab-case]
from: [Source Agent Role Name]
to: [Destination Agent Role Name]
severity: critical | high | medium | low
version: 1.0.0
score: null
last_evaluated: null
needs_review: false
---
```

### Required Sections

1. **Trigger Condition**: Exactly when this feedback loop initiates.
2. **Trigger Payload**: Data the source agent must provide.
3. **Destination Action**: Numbered list of steps the receiver must execute.
4. **Resolution Criteria**: Checkbox list to verify closure.
5. **Escalation**: Action paths if SLAs are breached.

---

## 4. Authoring Scoped Instructions

Coding guidelines and standards live in the root `instructions/` directory.

- **File Location**: `instructions/[instruction-name].instructions.md`

### Frontmatter Schema

```yaml
---
applyTo: "glob/**"  # required glob pattern
title: "Instruction Title"
description: "One-line description"
version: 1.0.0
---
```

---

## 5. Authoring Templates

Cross-cutting templates live in `templates/` at the repository root. Skill-specific templates live inside each skill's `templates/` subdirectory.

- **Root cross-cutting templates**: `templates/[template-name].md`
- **Skill-specific templates**: `skills/[skill-name]/templates/[template-name].md`

Current root templates:

| Template | Purpose |
| -------- | ------- |
| `templates/agent-role-card.md` | Scaffold for new agent role cards |
| `templates/skill-md.md` | Scaffold for new SKILL.md files |
| `templates/hook-definition.md` | Scaffold for new hook files |
| `templates/brd-epic.md` | BRD Epic document structure |
| `templates/api-endpoint.md` | TypeScript API route handler scaffold |
| `templates/repository-pattern.md` | TypeScript repository class scaffold |
| `templates/test-file.md` | Vitest test file scaffold |

---

## 6. Versioning (Revision History)

**Every governed file must be versioned.** Version numbers follow Semantic Versioning (`MAJOR.MINOR.PATCH`). The rules are enforced by `hooks/version-bump.md`.

### Bump Rules

| Change size | When | Example |
| ----------- | ---- | ------- |
| **Patch** `+0.0.1` | < 50% of file lines changed | Small fixes, additions, typo corrections |
| **Minor** `+0.1.0` (reset patch) | 50–80% of file lines changed | Significant section rewrites, new sections added |
| **Major** `+1.0.0` (reset minor + patch) | > 80% of file lines changed | Full rewrite, structural overhaul |

### How to Apply

1. Count total lines in the file before your edit.
2. Count lines added + deleted in your diff.
3. Change % = (lines changed) / (total lines before × 2) × 100.
4. Apply the appropriate bump to the `version` field in frontmatter.
5. Append a row to the `## Revision History` table at the bottom of the file.

### Revision History Table Format

Every governed file must have this table at the bottom:

```markdown
## Revision History

| Version | Date | Author | Change Summary |
| ------- | ---- | ------ | -------------- |
| 1.0.1 | 2026-06-20 | bluestella | Added edge case for vague goal inputs |
| 1.0.0 | 2026-06-01 | bluestella | Initial version |
```

### Scope

Version bumps apply to: `agents/**`, `skills/**/SKILL.md`, `hooks/**`, `instructions/**`, `templates/**`, `AGENTS.md`, `PLANS.md`, `CONTRIBUTING.md`, `METRICS.md`, `LEARNINGS.md`.

Do NOT version: `.github/**`, `*.excalidraw`, `.gitignore`, `.vscode/**`, `docs/**`.

---

## 7. Metrics & Scoring

**Every new artifact must be scored before closing the authoring session.** Scores are tracked in `METRICS.md` and written to each artifact's frontmatter.

### Scoring Thresholds

| Score | Action |
| ----- | ------ |
| 8.0 – 10.0 | Excellent. No action needed. |
| 7.0 – 7.9 | Acceptable. Monitor for improvement. |
| Below 7.0 | **Flag required.** Set `needs_review: true` in frontmatter, add to Flagged Artifacts table in `METRICS.md`, fire `low-score-flag` hook. |
| Below 5.0 | **Critical flag.** Human must review before artifact is used in any session. |

### Scoring Workflow

1. After authoring or modifying an artifact, score it using the METRICS.md criteria for its type (agent, skill, hook, or instruction).
2. Write `score`, `last_evaluated` (today's ISO date), and `needs_review` to the artifact's frontmatter.
3. Update the artifact's row in the METRICS.md Full Scoreboard.
4. If score < 7.0: add to Flagged Artifacts table, fire `low-score-flag` hook.
5. Bump `METRICS.md` version (patch).

---

## 8. Learning Loop

After any authoring session that produces a net-new insight about the pack's structure, authoring patterns, or quality conventions:

1. Fire the `learning-loop-update` hook.
2. Add an entry to `LEARNINGS.md` in the appropriate category.
3. If the learning implies a change to an instruction, template, or CONTRIBUTING.md — apply that change in the same session.

---

## 9. Testing & Mirroring Changes

Once modifications are written in the root source directories, synchronize them to `.github/` using `workspace-sync.sh`:

```bash
# 1. Dry-run — verify output structure
./workspace-sync.sh

# 2. Apply — mirror changes to .github/
./workspace-sync.sh --apply
```

---

## 10. Step-by-Step Contribution Pipeline

1. **Update the Plan**: If adding a new agent or skill, update `PLANS.md` following `instructions/plans-authoring.instructions.md`.
2. **Draft the Files**: Create Markdown files in root folders using the appropriate `templates/` scaffold.
3. **Version the File**: Apply the correct semver bump per Section 6.
4. **Score the Artifact**: Evaluate and record the score per Section 7.
5. **Log Learnings**: Fire `learning-loop-update` hook if insights emerged per Section 8.
6. **Synchronize**: Run `workspace-sync.sh --apply` to mirror to `.github/`.
7. **Pull Request**: Title format: `feat(scope): ...`, `fix(scope): ...`, `docs(scope): ...`. Body must include Summary, Motivation, and Review Checklist.

---

## Revision History

| Version | Date | Author | Change Summary |
| ------- | ---- | ------ | -------------- |
| 2.0.0 | 2026-06-20 | bluestella | Added versioning system, metrics/scoring, learning loop, templates/ root directory, tools team bucket. Full structural rewrite. |
| 1.0.0 | 2026-06-19 | bluestella | Initial version |
