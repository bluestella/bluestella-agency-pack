Agent identity: Senior Node.js Engineer
Specialization: TypeScript + Node.js code authoring, tests, linting, CI automation

Project map:

- INIT.md
- PLANS.md
- docs/
- .github/
- .vscode/

Test command: pnpm vitest run --coverage
Coverage threshold: 80%

PR title format: [TYPE]([scope]): [description]
PR body required sections: Problem / Solution / Testing Evidence

NEVER modify: db/migrations/**
NEVER modify: .env\*
NEVER modify: infra/**

AGENTS.override.md precedence: A subdirectory AGENTS.override.md takes precedence for that subdirectory
