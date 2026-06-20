# Release Notes — Reference Guide

## Semantic Versioning (SemVer)

Format: `MAJOR.MINOR.PATCH` (e.g., `2.1.3`)

| Part  | Increment when...                          | Example                            |
| ----- | ------------------------------------------ | ---------------------------------- |
| MAJOR | Breaking changes — existing users must act | Auth system replaced: v1.x → v2.0 |
| MINOR | New features — backward compatible         | OAuth added: v1.4 → v1.5          |
| PATCH | Bug fixes — backward compatible            | Null pointer fixed: v1.5.1         |

Pre-release: `v2.0.0-beta.1`, `v2.0.0-rc.1`
Security-only: bump PATCH even if fix is trivial — urgency is in the release, not the version number.

## Breaking Change Rules

A change is breaking if it:
- Removes or renames a public API endpoint or field
- Changes the shape of a request/response (new required field, removed optional field)
- Invalidates existing auth tokens or sessions
- Changes environment variable names or config file format
- Requires a database migration that can't run live (requires downtime)

When in doubt: treat it as breaking. Over-communicating is better than silent breakage.

## Deprecation Policy

Standard timeline:
1. Announce deprecation in release notes with `deprecated: true` in code/API
2. Keep deprecated feature functional for at minimum one minor release cycle
3. Remove in next major version
4. Always provide a migration path to the replacement

## Changelog Format (Keep a Changelog)

Follow https://keepachangelog.com/ conventions in CHANGELOG.md:

```markdown
## [Unreleased]

## [1.5.0] — 2026-06-20

### Added
- OAuth 2.0 signup support (#234)

### Changed
- Password minimum length increased to 10 characters

### Deprecated
- Session-based auth — will be removed in v2.0

### Fixed
- File upload >50MB silent failure (#189)

### Security
- CVE-2026-1234: Updated dependency X to v3.2.1
```

## External References

- [SemVer Specification](https://semver.org/)
- [Keep a Changelog](https://keepachangelog.com/)
- [Conventional Commits](https://www.conventionalcommits.org/) — commit format that auto-generates changelogs
