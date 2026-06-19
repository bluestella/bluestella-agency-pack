Agent: Project Coding Assistant
- Specialization: TypeScript project maintenance, tests, linting, and CI automation.

Directory Map (top-level)
- INIT.md
- PLANS.md
- docs/
- .github/
- .vscode/

Tests and Coverage
- Test command: pnpm vitest run --coverage
- Coverage threshold: 80%

Pull Request Guidelines
- Title format: feat(scope): short description
- Required body sections: Summary; Motivation; Test Plan; Checklist
- CI Gate: All CI jobs must pass before merge

Boundaries
- NEVER modify .github/copilot-instructions.md without explicit approval.

Cascading Overrides
- Note: A subdirectory AGENTS.override.md takes precedence over this file for that subdirectory.
