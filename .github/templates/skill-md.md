---
name: [skill-name]
description: >
  [Verb phrase: what this skill produces.]
  Use when [trigger keywords and phrases — be specific so agents activate correctly].
license: [MIT | Apache-2.0 | Proprietary | omit if not applicable]
compatibility: [e.g. "Requires internet access" | omit if no special requirements]
metadata:
  author: bluestella
  version: "1.0"
---

# [Skill Display Name]

## Overview

[One paragraph. State what this skill produces, the input it expects, and the output format it delivers. Mention the template or reference file it uses.]

## Steps

1. [Step 1 — discrete, actionable. Name the tool, command, or file used.]
2. [Step 2]
3. [Step 3]
4. [Continue as needed. Each step should move the agent closer to the final output.]

## Output Format

[Describe the structure of the output. Use a code block, table, or bullet list to show the shape.]

Example output structure:

```
[Show the output skeleton with placeholder values]
```

Reference template: [`.github/templates/[template-name].md` — if applicable]

## Examples

### Example 1 — [Happy path label]

**Input:** [What the user or agent provides]

**Output:**

```
[Show the expected output for this input]
```

### Example 2 — [Edge case label]

**Input:** [Edge case input]

**Output / Behaviour:** [What the skill does differently for this input]

## Edge Cases

- [Condition that changes output or requires human input — e.g. "If no tech stack is defined, prompt the human for Tools & Stack before generating."]
- [Edge case 2]
- [Edge case 3]

## References

See [references/REFERENCE.md](references/REFERENCE.md) for detailed specification links and extended documentation.
