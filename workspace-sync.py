#!/usr/bin/env python3
"""
workspace-sync.py
─────────────────
Copies /agents, /skills, /hooks, /instructions from the current working
directory into IDE-specific config folders.

Default: DRY-RUN — writes into .test/ so you can inspect before committing.
Pass --apply to write to the real IDE destinations.

Usage
─────
  python workspace-sync.py           # dry-run → .test/
  python workspace-sync.py --apply   # real copy to IDE dirs
"""

import os
import sys
import shutil
import platform
import argparse
from pathlib import Path

# ── Source folders ─────────────────────────────────────────────────────────────
SOURCE_FOLDERS = ["agents", "skills", "hooks", "instructions"]

# ── ANSI colours ──────────────────────────────────────────────────────────────
GREEN  = "\033[32m"
YELLOW = "\033[33m"
CYAN   = "\033[36m"
RED    = "\033[31m"
BOLD   = "\033[1m"
RESET  = "\033[0m"

def c(colour, text): return f"{colour}{text}{RESET}"

# ── IDE catalogue ─────────────────────────────────────────────────────────────
def _vscode_global():
    """Return the VS Code global User directory for the current OS."""
    system = platform.system()
    if system == "Darwin":
        return Path.home() / "Library" / "Application Support" / "Code" / "User"
    elif system == "Windows":
        appdata = os.environ.get("APPDATA", "")
        return Path(appdata) / "Code" / "User"
    else:
        return Path.home() / ".config" / "Code" / "User"


# Each IDE entry:
#   name          – display name
#   project_root  – path relative to CWD for project-level install (str | None → prompt)
#   global_root   – callable returning Path for global install (callable | None → prompt)
IDES = [
    {
        "key": "1",
        "name": "Claude Code",
        "project_root": ".claude",
        "global_root": lambda: Path.home() / ".claude",
    },
    {
        "key": "2",
        "name": "Cursor",
        "project_root": os.path.join(".cursor", "rules"),
        "global_root": lambda: Path.home() / ".cursor" / "rules",
    },
    {
        "key": "3",
        "name": "VS Code",
        "project_root": ".vscode",
        "global_root": _vscode_global,
    },
    {
        "key": "4",
        "name": "Windsurf",
        "project_root": os.path.join(".windsurf", "rules"),
        "global_root": lambda: Path.home() / ".windsurf" / "rules",
    },
    {
        "key": "5",
        "name": "Antigravity",
        "project_root": None,   # prompted at runtime
        "global_root": None,
    },
    {
        "key": "6",
        "name": "Trae",
        "project_root": None,
        "global_root": None,
    },
]


# ── Helpers ───────────────────────────────────────────────────────────────────
def prompt(msg: str, default: str = "") -> str:
    """Prompt the user; return stripped input or default."""
    suffix = f" [{default}]" if default else ""
    try:
        raw = input(f"{msg}{suffix}: ").strip()
    except (EOFError, KeyboardInterrupt):
        print()
        sys.exit(0)
    return raw if raw else default


def confirm(msg: str) -> bool:
    raw = prompt(f"{msg} (y/n)", "n").lower()
    return raw in ("y", "yes")


def collect_source_files(cwd: Path) -> dict[str, list[Path]]:
    """Return {folder_name: [file_paths]} for each source folder found in cwd."""
    found: dict[str, list[Path]] = {}
    for folder in SOURCE_FOLDERS:
        src = cwd / folder
        if src.is_dir():
            files = [f for f in src.rglob("*") if f.is_file()]
            found[folder] = files
    return found


def resolve_dest_root(ide: dict, scope: str) -> Path:
    """Return the absolute destination root for an IDE + scope combo."""
    if scope == "project":
        root = ide["project_root"]
        if root is None:
            raw = prompt(
                f"  Enter project config path for {ide['name']} (relative to CWD)"
            )
            root = raw.strip().rstrip("/\\") or f".{ide['name'].lower()}"
        return Path(root).expanduser()
    else:
        fn = ide["global_root"]
        if fn is None:
            raw = prompt(
                f"  Enter global config path for {ide['name']} (absolute or ~)"
            )
            raw = raw.strip().rstrip("/\\") or f"~/.{ide['name'].lower()}"
            return Path(raw).expanduser()
        return fn()


def copy_files(
    source_files: dict[str, list[Path]],
    dest_root: Path,
    cwd: Path,
    dry_run_root: Path | None,
) -> tuple[int, int, int]:
    """
    Copy source files to dest_root (or dry_run_root/dest_root if in dry-run).
    Returns (copied, skipped, errors).
    """
    copied = skipped = errors = 0

    for folder, files in source_files.items():
        for src_file in files:
            rel = src_file.relative_to(cwd / folder)
            if dry_run_root is not None:
                # Mirror the real dest structure under .test/
                dest_file = dry_run_root / dest_root / folder / rel
            else:
                dest_file = dest_root / folder / rel

            if dest_file.exists():
                print(f"  {c(YELLOW, 'SKIP')}  {dest_file}")
                skipped += 1
                continue

            try:
                dest_file.parent.mkdir(parents=True, exist_ok=True)
                shutil.copy2(src_file, dest_file)
                print(f"  {c(GREEN, 'COPY')}  {src_file}  →  {dest_file}")
                copied += 1
            except Exception as e:
                print(f"  {c(RED, 'ERR ')}  {src_file}  →  {dest_file}  ({e})")
                errors += 1

    return copied, skipped, errors


# ── Main ──────────────────────────────────────────────────────────────────────
def main():
    parser = argparse.ArgumentParser(
        description="Copy workspace config folders into IDE config directories."
    )
    parser.add_argument(
        "--apply",
        action="store_true",
        help="Write to real IDE destinations (default: dry-run into .test/)",
    )
    args = parser.parse_args()

    cwd = Path.cwd()
    dry_run = not args.apply
    dry_run_root = cwd / ".test" if dry_run else None

    # ── Banner ────────────────────────────────────────────────────────────────
    mode_label = c(YELLOW, "DRY-RUN → .test/") if dry_run else c(GREEN, "APPLY")
    print(f"\n{c(BOLD, 'workspace-sync')}  [{mode_label}]\n")
    print(f"  Source root : {cwd}")
    if dry_run:
        print(f"  Destination : {cwd / '.test'} (mirroring real paths)\n")
    else:
        print(f"  Destination : real IDE config folders\n")

    # ── Discover source files ─────────────────────────────────────────────────
    source_files = collect_source_files(cwd)
    if not source_files:
        print(c(RED, "No source folders found."))
        print(f"Expected at least one of: {', '.join(SOURCE_FOLDERS)} in {cwd}")
        sys.exit(1)

    print(c(BOLD, "Found source folders:"))
    for folder, files in source_files.items():
        print(f"  /{folder}  ({len(files)} file{'s' if len(files) != 1 else ''})")
    print()

    # ── IDE selection ─────────────────────────────────────────────────────────
    print(c(BOLD, "Select IDE(s) — enter numbers separated by spaces or commas:"))
    for ide in IDES:
        print(f"  {ide['key']}) {ide['name']}")
    print()

    raw_ide = prompt("IDE selection").replace(",", " ")
    selected_keys = [k.strip() for k in raw_ide.split() if k.strip()]
    ide_map = {ide["key"]: ide for ide in IDES}
    selected_ides = [ide_map[k] for k in selected_keys if k in ide_map]

    if not selected_ides:
        print(c(RED, "No valid IDE selected. Exiting."))
        sys.exit(1)

    # ── Scope selection ───────────────────────────────────────────────────────
    print(f"\n{c(BOLD, 'Install scope:')}")
    print("  1) Project  (relative to current working directory)")
    print("  2) Global   (IDE-specific user-level directory)")
    print("  3) Both")
    scope_choice = prompt("Scope", "1")

    if scope_choice == "1":
        scopes = ["project"]
    elif scope_choice == "2":
        scopes = ["global"]
    else:
        scopes = ["project", "global"]

    # ── Build copy plan ───────────────────────────────────────────────────────
    plan: list[tuple[dict, str, Path]] = []  # (ide, scope, dest_root)
    print()
    for ide in selected_ides:
        for scope in scopes:
            dest_root = resolve_dest_root(ide, scope)
            plan.append((ide, scope, dest_root))

    # ── Preview ───────────────────────────────────────────────────────────────
    print(f"\n{c(BOLD, 'Copy plan:')}")
    for ide, scope, dest_root in plan:
        effective = (dry_run_root / dest_root) if dry_run else dest_root
        print(f"  {c(CYAN, ide['name'])} [{scope}]  →  {effective}")

    total_files = sum(len(v) for v in source_files.values())
    print(f"\n  {total_files} source file(s) × {len(plan)} destination(s)\n")

    if not dry_run:
        if not confirm(c(YELLOW, "This will write to real IDE directories. Continue?")):
            print("Aborted.")
            sys.exit(0)

    # ── Execute ───────────────────────────────────────────────────────────────
    print(f"\n{c(BOLD, 'Copying...')}\n")
    total_copied = total_skipped = total_errors = 0

    for ide, scope, dest_root in plan:
        print(c(CYAN, f"── {ide['name']} [{scope}] ──"))
        copied, skipped, errors = copy_files(
            source_files, dest_root, cwd, dry_run_root
        )
        total_copied  += copied
        total_skipped += skipped
        total_errors  += errors
        print()

    # ── Summary ───────────────────────────────────────────────────────────────
    print(c(BOLD, "Done."))
    print(f"  {c(GREEN,  'Copied')}  : {total_copied}")
    print(f"  {c(YELLOW, 'Skipped')} : {total_skipped}  (already exist)")
    print(f"  {c(RED,    'Errors')}  : {total_errors}")

    if dry_run:
        print(f"\n{c(YELLOW, 'Dry-run complete.')} Inspect {cwd / '.test'} then run:")
        print(f"  {c(CYAN, 'python workspace-sync.py --apply')}")
    print()


if __name__ == "__main__":
    main()
