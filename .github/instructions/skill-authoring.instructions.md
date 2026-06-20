---
applyTo: "skills/**"
---

# Skill Authoring Rules

Spec reference: https://agentskills.io/specification

## Directory structure

```
skills/[skill-name]/
├── SKILL.md          # Required
├── scripts/          # Optional: executable code
├── references/       # Optional: reference docs (REFERENCE.md, domain-specific .md files)
└── assets/           # Optional: templates, data files, images
```

The directory name must exactly match the `name` field in SKILL.md frontmatter.

## SKILL.md frontmatter

Required fields:

```yaml
---
name: skill-name           # lowercase, hyphens only, no consecutive hyphens, matches directory name
description: >             # 1–1024 chars; must state WHAT it does AND WHEN to use it
  [Verb phrase describing output]. Use when [trigger keywords and phrases].
---
```

Optional fields:

```yaml
license: MIT
compatibility: Requires git and internet access
metadata:
  author: bluestella
  version: "1.0"
allowed-tools: Bash(git:*) Read Write
```

## description field rules

- Must include trigger keywords so agents activate the skill correctly.
- Must state the output format (e.g. "Generates a BRD markdown document").
- Must state the trigger condition (e.g. "Use when the user asks to write requirements or an epic").
- 1024 character hard limit — trim aggressively.

## SKILL.md body content

Recommended sections (in order):

### Overview
One paragraph: what this skill produces and why.

### Steps
Numbered list. Each step is a discrete action the agent takes.
Be specific: name the template, reference file, or output path used in each step.

### Output Format
Describe the structure of the output (headers, tables, checklists, file paths).
Reference the relevant template from `.github/templates/` if one exists.

### Examples
At least one input → output example.
For complex skills, show the happy path and one edge case.

### Edge Cases
Bullet list of conditions that change the output or require human input.

## Size limits

- SKILL.md body: under 500 lines.
- Move detailed reference material to `references/REFERENCE.md` or domain-specific files.
- Move executable logic to `scripts/`.
- Reference sub-files with relative paths from the skill root.

## Progressive disclosure

Agents load skills in three layers:
1. Metadata (name + description) — loaded at startup for all skills.
2. SKILL.md body — loaded when skill is activated.
3. References and scripts — loaded on demand.

Design accordingly: keep the body focused on step-by-step execution; move deep reference content to `references/`.

## Validation

Name field rules:
- 1–64 characters
- Lowercase alphanumeric and hyphens only
- Must not start or end with a hyphen
- Must not contain consecutive hyphens (`--`)
- Must match the parent directory name exactly

## Template

Use `.github/templates/skill-md.md` when creating a new skill from scratch.
