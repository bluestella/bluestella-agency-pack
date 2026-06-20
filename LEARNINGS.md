---
title: LEARNINGS.md — Agency Pack Authoring Learnings Log
description: Accumulated learnings about how to create, improve, and maintain agents, skills, hooks, and instructions in this repository.
author: bluestella
date: 2026-06-20
version: 1.0.0
---

# LEARNINGS.md

> **Purpose:** This file captures lessons learned from authoring sessions — patterns that worked, anti-patterns to avoid, and process improvements for creating agents, skills, hooks, and instructions in this repository. The `learning-loop-update` hook triggers an update here after any session that produces net-new insights.

---

## How to Add a Learning

1. Add a new entry under the correct category below.
2. Follow the format: `### [YYYY-MM-DD] [Short title]` with `**What happened:**`, `**What we learned:**`, `**Change applied:**`.
3. Bump the `version` in the frontmatter (patch for a new entry, minor for a structural change).
4. Reference the affected artifact (agent, skill, hook, or instruction file) where applicable.

---

## Agent Role Card Learnings

### [2026-06-20] tools/ team bucket needed for meta-agents

**What happened:** The `agency-pack-author.md` agent (a meta-agent that authors other agents) did not fit any existing team bucket (`management`, `analysis`, `architecture`, `frontend`, `backend`, `quality`, `devops`).

**What we learned:** Meta-agents and tool-specific agents (Copilot, Codex, Trae) need a separate `tools` team bucket. Adding it to the `team` field valid values prevents file placement ambiguity.

**Change applied:** Added `tools` as a valid team value in `templates/agent-role-card.md` and `instructions/agent-role-card.instructions.md`. Created `agents/tools/agency-pack-author.md`.

---

### [2026-06-20] Frontmatter skills/hooks arrays missing from many existing role cards

**What happened:** When syncing `.github/agents/` content to root, several existing role cards lacked `skills` and `hooks` frontmatter arrays defined in `instructions/agent-role-card.instructions.md`.

**What we learned:** The instructions file was written before the frontmatter spec was fully adopted. Existing role cards should be audited and updated to include these fields.

**Change applied:** `templates/agent-role-card.md` updated to include `skills`, `hooks.emits`, and `hooks.receives` in the frontmatter scaffold. Future role cards will be complete from creation.

---

## Skill Authoring Learnings

### [2026-06-20] .github/skills/ vs root skills/ — root is authoritative

**What happened:** Two versions of the `brd` skill existed: one in `.github/skills/brd/` and one in `skills/brd/`. The root version was more complete (referenced real templates, had `instructions`/`agents`/`triggers` frontmatter).

**What we learned:** The root workspace is always the source of truth. `.github/` is a read-only mirror for GitHub AI runtime tools. When a conflict exists, evaluate quality and retain the better version — biased strongly toward root.

**Change applied:** Root `skills/brd/SKILL.md` retained. `.github/skills/brd/` left as-is (managed by sync script). Documented in `CONTRIBUTING.md`.

---

### [2026-06-20] Template references should point to root templates/, not .github/templates/

**What happened:** Skill bodies referenced `.github/templates/[name].md`. Since `.github/` is read-only for AI tools, those references created confusion about where to look for templates.

**What we learned:** All template references in SKILL.md bodies, instructions, and CONTRIBUTING.md should point to `templates/[name].md` (root) not `.github/templates/`. The sync script keeps `.github/templates/` in sync.

**Change applied:** Updated `skills/role-card-generator/SKILL.md` and `templates/skill-md.md` to reference `templates/` instead of `.github/templates/`.

---

## Hook Authoring Learnings

### [2026-06-20] Avoid duplicate hooks across .github/ and root

**What happened:** The four `.github/hooks/` files (pr-score-fail-feedback, qa-bug-feedback, security-finding-feedback, devops-failure-feedback) all had root equivalents with more detail (JSON payloads, automation sections, gate tables).

**What we learned:** Hooks should only be authored once — in root. The `.github/hooks/` versions should be sync-script mirrors, not independent documents. When evaluating which version to keep, the root version wins unless the `.github/` version has unique content not present in root.

**Change applied:** Root hooks retained. No duplicate hooks added. Documented in this file and `CONTRIBUTING.md`.

---

## Instructions Authoring Learnings

### [2026-06-20] Four meta-authoring instruction files were missing from root

**What happened:** `instructions/agent-role-card.instructions.md`, `skill-authoring.instructions.md`, `hook-authoring.instructions.md`, and `plans-authoring.instructions.md` existed only in `.github/instructions/` — not in root.

**What we learned:** Instructions that govern how to author core artifact types (agents, skills, hooks, plans) must live in root `instructions/` because they are source-of-truth documents, not GitHub runtime configs. Root is where authoring happens.

**Change applied:** All four instruction files copied from `.github/instructions/` to root `instructions/`.

---

## Process & Structural Learnings

### [2026-06-20] Templates directory needed at root level

**What happened:** Templates (skill-md.md, agent-role-card.md, hook-definition.md, brd-epic.md, api-endpoint.md, repository-pattern.md, test-file.md) lived only in `.github/templates/`. Authors referencing them had to navigate to a read-only directory.

**What we learned:** Templates that define the structure of root workspace artifacts should live in a root `templates/` directory. Skill-specific templates (like `skills/adr/templates/`) remain inside their skill directory. Cross-cutting templates (those used by instructions, multiple skills, or code generation) belong at `templates/`.

**Change applied:** Created `templates/` root directory. All `.github/templates/` files copied there as the authoring source-of-truth.
