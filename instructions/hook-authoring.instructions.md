---
applyTo: "hooks/**"
---

# Hook Authoring Rules

Hooks model the feedback loops defined in PLANS.md Step 2.
Each hook file captures exactly one loop: when condition X occurs at agent A, trigger agent B to re-run a cycle.

## File location

```
hooks/[hook-name].md
```

Naming convention: `[source-agent-shortname]-[event]-feedback.md`
Examples: `qa-bug-feedback.md`, `security-finding-feedback.md`, `pr-score-fail-feedback.md`

## Required frontmatter

```yaml
---
trigger: [machine-readable event name, kebab-case]
from: [source agent role name, matches PLANS.md roster]
to: [destination agent role name, matches PLANS.md roster]
severity: critical | high | medium | low
---
```

## Required sections (in order)

### 1. Trigger Condition
One sentence. State the exact condition that fires this hook.
Be specific: name the artifact, threshold, or event (e.g. "A QA bug ticket at any severity level is raised and remains open").

### 2. Trigger Payload
Bulleted list of data the source agent must provide when firing this hook:
- What document or artifact contains the finding
- Severity or score
- Affected component or file
- Suggested assignee

### 3. Destination Action
Numbered list of steps the destination agent must take when it receives this hook.
Each step must be actionable and outcome-focused.

### 4. Resolution Criteria
Bulleted checklist. The hook is resolved (loop closed) when all items are checked.
Resolution must be verifiable — reference a tool, a checklist status, or a CI gate.

### 5. Escalation
Optional. Describe what happens if resolution criteria are not met within a sprint.

## Content rules

- Source and destination agents must both appear in the PLANS.md Agent Roster.
- Do not duplicate rule definitions from agent role cards; reference the role card by name.
- One hook file per distinct trigger event. If the same source fires two different events, create two hooks.
- Severity field drives priority of the re-triggered work item.

## Feedback loop reference (from PLANS.md)

| From | To | Trigger |
| ---- | -- | ------- |
| Automation Testing Engineer | Frontend / Backend Engineer | Code bugs in visual or API tests |
| Automation Testing Engineer | Tech Lead | Recurring failures — systemic quality issue |
| Performance Testing Engineer | Developer / Tech Lead | SLA breach or performance bottleneck |
| Performance Testing Engineer | Architecture Team | Bottleneck requiring architectural change |
| Security Engineer | Developer / Business Analyst | STRIDE finding → new requirement ticket |
| Security Engineer | Architecture Team | Design-level threat requiring architectural change |
| Tech Lead | Developer | PR score below gate threshold → bug ticket raised |
| Tech Lead ↔ Architecture Team | Each other | Technical debt resolution and alignment |
| DevOps | Tech Lead | Deployment failure requiring engineering changes |

## Template

Use `.github/templates/hook-definition.md` when creating a new hook from scratch.
