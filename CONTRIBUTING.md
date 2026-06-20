# 🤝 Contributing to Bluestella Agency Pack

Thank you for contributing to the **Bluestella Agency Pack**! This document outlines the standards, structural patterns, and authoring guidelines for extending our AI-agent software delivery team. 

Please read this guide thoroughly before creating or modifying any cards, skills, hooks, instructions, or templates.

---

## 🚫 Critical Contribution Boundaries

Before drafting changes, keep these hard constraints in mind:

1. **Never modify `.github/**` directly during execution.** The `.github` folder is a read-only runtime mirror managed by synchronization scripts. All authoring and manual edits must happen in the root folders (`agents/`, `skills/`, `hooks/`, `instructions/`).
2. **Never create, rename, or delete agent cards** under [agents/](agents) unless explicitly instructed by a human. The roster is intentional and version-controlled.
3. **Always use kebab-case** for file naming (e.g., `react-native-engineer.md`, `qa-bug-feedback.md`).
4. **Mandatory YAML Frontmatter**: Every file (agent, skill, hook, instruction, plan) must include a YAML frontmatter block.

---

## 👥 1. Authoring Agent Role Cards

Agent role cards define the behaviors, scope of ownership, tool stack, and quality gates for each team role.

* **File Location**: `agents/[team]/[agent-name].md`
* **Valid Team Folder values**: `management` | `analysis` | `architecture` | `frontend` | `backend` | `quality` | `devops`
* **Templates & Guidelines**:
  * Scoped System Guidelines: [agent-role-card.instructions.md](.github/instructions/agent-role-card.instructions.md)
  * Markdown Template: [agent-role-card.md](.github/templates/agent-role-card.md)

### Frontmatter Schema

```yaml
---
title: Human-readable role name (e.g., React Native Engineer)
team: [team value from list above]
version: 1.0.0
skills:
  - [skill-name]        # flat list of folders under skills/ this agent is allowed to invoke
hooks:
  emits:
    - [trigger-name]    # hook triggers this agent fires (matches `trigger:` in hook files)
  receives:
    - [trigger-name]    # hook triggers this agent listens for (matches `trigger:` in hook files)
---
```

### Required Sections

1. **Role & Overview**: One paragraph stating what this agent owns, its pipeline position, and value. Keep the focus only on this role.
2. **Responsibilities**: An outcome-focused bulleted list starting with active verbs (e.g., *"Design service boundaries..."*). Avoid vague descriptions like *"Help frontend team"*.
3. **Tools & Stack**: A markdown table (`Tool | Purpose | Cost`) containing only tools explicitly used by this agent.
4. **Definition of Done (DoD)**: A descriptive paragraph of the finished state, followed by a measurable **Metrics & Scoring Checklist** (e.g., code coverage $\ge 90\%$, 0 compilation errors, zero open P0-P3 bugs).

---

## ⚡ 2. Authoring Skills

Skills are modular, reusable prompt packages following the `agentskills.io` specification.

* **Folder Structure**:
  ```
  skills/[skill-name]/
  ├── SKILL.md          # Required: metadata + instructions (all caps)
  ├── scripts/          # Optional: executable script helpers
  ├── references/       # Optional: specs and documents (REFERENCE.md)
  └── assets/           # Optional: templates and static resources
  ```
* **Templates & Guidelines**:
  * Scoped System Guidelines: [skill-authoring.instructions.md](.github/instructions/skill-authoring.instructions.md)
  * Markdown Template: [skill-md.md](.github/templates/skill-md.md)

### Name Validation Rules
* The directory name must exactly match the `name` field in `SKILL.md`'s frontmatter.
* 1–64 characters, lowercase alphanumeric and hyphens only (e.g., `database-schema-design`).
* No consecutive hyphens (`--`), and cannot start or end with a hyphen.

### SKILL.md Frontmatter Schema

```yaml
---
name: skill-name-kebab-case
description: >
  [Verb phrase describing output]. Use when [trigger keywords and phrases].
license: MIT
compatibility: [e.g., Requires internet access]
metadata:
  author: bluestella
  version: "1.0"
---
```

### Required Sections

1. **Overview**: Description of what the skill produces, its inputs, and expected outputs.
2. **Steps**: Actionable numbered list detailing what tool or template the agent must use.
3. **Output Format**: Code blocks or schemas showing the structure of the final artifact.
4. **Examples**: Provide at least one complete example (happy path) and optionally one edge case.
5. **Edge Cases**: Bulleted list of scenarios requiring human interaction or specific fallbacks.

> [!TIP]
> **Progressive Disclosure Pattern**
> Keep `SKILL.md` under 500 lines. Move heavy reference materials to `references/REFERENCE.md` and logic code to `scripts/`. Agents read metadata first, then the body, and load references only on demand.

---

## 🔄 3. Authoring Hooks (Feedback Loops)

Hooks capture the trigger boundaries modeling the workflow loops defined in [PLANS.md](PLANS.md) Step 2.

* **File Location**: `hooks/[source-agent-shortname]-[event]-feedback.md`
* **Templates & Guidelines**:
  * Scoped System Guidelines: [hook-authoring.instructions.md](.github/instructions/hook-authoring.instructions.md)
  * Markdown Template: [hook-definition.md](.github/templates/hook-definition.md)

### Frontmatter Schema

```yaml
---
trigger: [machine-readable-event-name, kebab-case]
from: [Source Agent Role Name]
to: [Destination Agent Role Name]
severity: critical | high | medium | low
---
```

### Required Sections

1. **Trigger Condition**: Exactly when this feedback loop initiates.
2. **Trigger Payload**: Data provided by the source agent (e.g., bug report link, severity, component, assignee).
3. **Destination Action**: Actionable numbered list of steps the receiver must execute to correct the defect.
4. **Resolution Criteria**: A checkbox list to verify closure of the hook (e.g., green CI pipeline, ticket closed).
5. **Escalation**: Action paths if SLAs are breached.

---

## 📖 4. Authoring Scoped Instructions

Developer-facing coding guidelines and standards live in the root [instructions/](instructions) directory. These files govern code patterns, validation strategies, and testing requirements across directories.

* **File Location**: `instructions/[instruction-name].instructions.md`
* **Example**: [api-patterns.instructions.md](instructions/api-patterns.instructions.md)

### Frontmatter Schema

Every instruction file requires an `applyTo` glob pattern. IDE integrations parse this pattern to inject rules into the agent's context when working within matching file structures:

```yaml
---
applyTo: "src/api/**" # Glob target path
title: "API Pattern Standards"
description: "Enforce consistent API route handler structures and validation"
---
```

---

## 📄 5. Authoring Templates

Code scaffolds and document boilerplate structures reside under the template directories. 

* **File Location**: `.github/templates/[template-name].md`
* **Exemplary Templates**:
  * Architecture Epic: [brd-epic.md](.github/templates/brd-epic.md)
  * API Endpoint Boilerplate: [api-endpoint.md](.github/templates/api-endpoint.md)
  * Data Persistence Layer: [repository-pattern.md](.github/templates/repository-pattern.md)
  * Testing Scaffolds: [test-file.md](.github/templates/test-file.md)

Keep template files clear, well-commented, and heavily focused on code conventions so that code generation agents can easily parse and utilize them.

---

## ⚙️ 6. Testing & Mirroring Changes

Once modifications are written in the root source directories (`agents/`, `skills/`, `hooks/`, `instructions/`), synchronize them using [workspace-sync.sh](workspace-sync.sh).

```bash
# 1. Run a Dry-Run and verify output structure under .test/
./workspace-sync.sh

# 2. Mirror changes to active project/global IDE config folders
./workspace-sync.sh --apply
```

---

## 🚀 7. Step-by-Step Contribution Pipeline

1. **Update the Plan**: If adding a new agent or skill, update [PLANS.md](PLANS.md) following the [plans-authoring.instructions.md](.github/instructions/plans-authoring.instructions.md) rules.
2. **Draft the Files**: Create the required Markdown files in the root folders using the appropriate templates.
3. **Synchronize**: Run `workspace-sync.sh` to mirror files locally.
4. **Pull Request Submission**: Follow the PR title and description conventions specified in the master repository guidelines:
   * Title format: `feat(scope): ...`, `fix(scope): ...`, `docs(scope): ...`
   * Body must include **Summary**, **Motivation**, **Test Plan**, and the standard **Review Checklist**.
