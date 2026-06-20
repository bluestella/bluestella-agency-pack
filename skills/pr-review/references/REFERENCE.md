# PR Review Reference

## Gate Thresholds
- **Unit Test Coverage:** ≥ 90% (Vitest / Jest)
- **Type Safety:** Zero TypeScript errors (`tsc --noEmit`)
- **Linting:** Zero ESLint violations (`pnpm lint`)
- **Code Quality:** SonarCloud Quality Gate green
- **Security:** No critical/high CodeQL alerts; no vulnerable dependencies (Dependabot)
- **QA:** All acceptance criteria verified; no open critical/high bugs
- **Debug artifacts:** No `console.log`, `TODO`, `FIXME`, or commented-out code in diff

## Key Resources
- [SonarCloud docs](https://docs.sonarsource.com/sonarqube-cloud/)
- [GitHub CodeQL – JS/TS queries](https://docs.github.com/en/code-security/code-scanning/managing-your-code-scanning-configuration/javascript-typescript-built-in-queries)
- [Vitest coverage thresholds](https://vitest.dev/config/#coverage-thresholds)
- [Code Review Best Practices](https://www.codeant.ai/blogs/good-code-review-practices-guide)
