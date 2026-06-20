#!/usr/bin/env bash
#
# workspace-sync.sh
# ─────────────────
# Copies /agents, /skills, /hooks, /instructions from the current working
# directory into IDE-specific config folders.
#
# Default: DRY-RUN — writes into .test/ so you can inspect before committing.
# Pass --apply to write to the real IDE destinations.
#
# Usage
# ─────
#   ./workspace-sync.sh           # dry-run → .test/
#   ./workspace-sync.sh --apply   # real copy to IDE dirs
#

set -euo pipefail

# ── Source folders ─────────────────────────────────────────────────────────────
SOURCE_FOLDERS=("agents" "skills" "hooks" "instructions")

# ── ANSI colours ──────────────────────────────────────────────────────────────
if [[ -t 1 ]]; then
  C_GREEN=$'\033[32m'
  C_YELLOW=$'\033[33m'
  C_CYAN=$'\033[36m'
  C_RED=$'\033[31m'
  C_BOLD=$'\033[1m'
  C_DIM=$'\033[2m'
  C_RESET=$'\033[0m'
else
  C_GREEN=''; C_YELLOW=''; C_CYAN=''; C_RED=''; C_BOLD=''; C_DIM=''; C_RESET=''
fi

ok()     { printf "${C_GREEN}[OK]${C_RESET}  %s" "$*"; }
warn()   { printf "${C_YELLOW}[!!]${C_RESET}  %s" "$*"; }
err()    { printf "${C_RED}[ERR]${C_RESET} %s" "$*" >&2; }

# ── Box drawing ───────────────────────────────────────────────────────────────
BOX_INNER=48

box_top() { printf "  +"; printf '%0.s-' $(seq 1 $BOX_INNER); printf "+\n"; }
box_bot() { box_top; }
box_row() {
  local raw="$1"
  local visible
  visible="$(printf '%s' "$raw" | sed 's/\x1b\[[0-9;]*m//g')"
  local pad=$(( BOX_INNER - 2 - ${#visible} ))
  if (( pad < 0 )); then pad=0; fi
  printf "  | %s%*s |\n" "$raw" "$pad" ''
}

# ── IDE catalogue ─────────────────────────────────────────────────────────────
get_vscode_global() {
  if [[ "$OSTYPE" == "darwin"* ]]; then
    echo "${HOME}/Library/Application Support/Code/User"
  elif [[ "$OSTYPE" == "msys" || "$OSTYPE" == "cygwin" ]]; then
    local appdata="${APPDATA:-}"
    if [[ -n "$appdata" ]]; then
      if command -v cygpath >/dev/null 2>&1; then
        cygpath -u "$appdata/Code/User"
      else
        echo "$appdata/Code/User"
      fi
    else
      echo "${HOME}/AppData/Roaming/Code/User"
    fi
  else
    echo "${HOME}/.config/Code/User"
  fi
}

ALL_IDES=("Claude Code" "Cursor" "VS Code" "Windsurf" "Antigravity" "Trae" "GitHub")

detect_claude_code() { [[ -d "${HOME}/.claude" ]]; }
detect_cursor()      { command -v cursor >/dev/null 2>&1 || [[ -d "${HOME}/.cursor" ]]; }
detect_vscode()      { command -v code >/dev/null 2>&1 || [[ -d "${HOME}/Library/Application Support/Code" ]] || [[ -d "${HOME}/.config/Code" ]]; }
detect_windsurf()    { command -v windsurf >/dev/null 2>&1 || [[ -d "${HOME}/.codeium" ]] || [[ -d "${HOME}/.windsurf" ]]; }
detect_antigravity() { [[ -d "${HOME}/.gemini/antigravity-ide" ]] || [[ -d "${HOME}/.gemini/antigravity" ]]; }
detect_trae()        { [[ -d "${HOME}/.trae" ]] || [[ -d "/Applications/Trae.app" ]]; }
detect_github()      { [[ -d "${HOME}/.github" ]] || [[ -d ".github" ]]; }

is_detected() {
  case "$1" in
    "Claude Code")  detect_claude_code ;;
    "Cursor")       detect_cursor ;;
    "VS Code")      detect_vscode ;;
    "Windsurf")     detect_windsurf ;;
    "Antigravity")  detect_antigravity ;;
    "Trae")         detect_trae ;;
    "GitHub")       detect_github ;;
    *)              return 1 ;;
  esac
}

ide_label() {
  case "$1" in
    "Claude Code")  printf "%-14s  %s" "Claude Code"  "(.claude)" ;;
    "Cursor")       printf "%-14s  %s" "Cursor"       "(.cursor/rules)" ;;
    "VS Code")      printf "%-14s  %s" "VS Code"      "(.vscode)" ;;
    "Windsurf")     printf "%-14s  %s" "Windsurf"     "(.windsurf/rules)" ;;
    "Antigravity")  printf "%-14s  %s" "Antigravity"  "(prompted)" ;;
    "Trae")         printf "%-14s  %s" "Trae"         "(prompted)" ;;
    "GitHub")       printf "%-14s  %s" "GitHub"       "(.github)" ;;
  esac
}

# ── Helpers ───────────────────────────────────────────────────────────────────
resolve_project_root() {
  local name="$1"
  local lower_name
  lower_name="$(echo "$name" | tr '[:upper:]' '[:lower:]' | tr ' ' '-')"
  local default_val=".${lower_name}"
  
  printf "  Enter project config path for %s (relative to CWD) [%s]: " "$name" "$default_val" >&2
  local val
  read -r val </dev/tty
  val="$(echo "$val" | xargs)"
  if [[ -z "$val" ]]; then
    val="$default_val"
  fi
  echo "$val"
}

resolve_global_root() {
  local name="$1"
  local lower_name
  lower_name="$(echo "$name" | tr '[:upper:]' '[:lower:]' | tr ' ' '-')"
  local default_val="~/.${lower_name}"
  
  printf "  Enter global config path for %s (absolute or ~) [%s]: " "$name" "$default_val" >&2
  local val
  read -r val </dev/tty
  val="$(echo "$val" | xargs)"
  if [[ -z "$val" ]]; then
    val="$default_val"
  fi
  if [[ "$val" == "~"* ]]; then
    val="${HOME}${val#\~}"
  fi
  echo "$val"
}

resolve_dest_root() {
  local name="$1"
  local scope="$2"
  
  if [[ "$scope" == "project" ]]; then
    case "$name" in
      "Claude Code")   echo ".claude" ;;
      "Cursor")        echo ".cursor/rules" ;;
      "VS Code")       echo ".vscode" ;;
      "Windsurf")      echo ".windsurf/rules" ;;
      "GitHub")        echo ".github" ;;
      *)               resolve_project_root "$name" ;;
    esac
  else
    case "$name" in
      "Claude Code")   echo "${HOME}/.claude" ;;
      "Cursor")        echo "${HOME}/.cursor/rules" ;;
      "VS Code")       get_vscode_global ;;
      "Windsurf")      echo "${HOME}/.windsurf/rules" ;;
      "GitHub")        echo "${HOME}/.github" ;;
      *)               resolve_global_root "$name" ;;
    esac
  fi
}

confirm() {
  local msg="$1"
  printf "%s (y/n) [n]: " "$msg" >&2
  local ans
  read -r ans </dev/tty
  ans="$(echo "$ans" | tr '[:upper:]' '[:lower:]')"
  if [[ "$ans" == "y" || "$ans" == "yes" ]]; then
    return 0
  else
    return 1
  fi
}

# ── Interactive selector ──────────────────────────────────────────────────────
interactive_select() {
  declare -a selected=()
  declare -a detected_map=()

  local t
  for t in "${ALL_IDES[@]}"; do
    if is_detected "$t" 2>/dev/null; then
      selected+=(1)
      detected_map+=(1)
    else
      selected+=(0)
      detected_map+=(0)
    fi
  done

  while true; do
    printf "\n"
    box_top
    box_row "${C_BOLD}  workspace-sync -- Choose IDEs${C_RESET}"
    box_bot
    printf "\n"
    printf "  ${C_DIM}System scan:  [*] = detected on this machine${C_RESET}\n"
    printf "\n"

    local i=0
    for t in "${ALL_IDES[@]}"; do
      local num=$(( i + 1 ))
      local label; label="$(ide_label "$t")"
      local dot
      if [[ "${detected_map[$i]}" == "1" ]]; then
        dot="${C_GREEN}[*]${C_RESET}"
      else
        dot="${C_DIM}[ ]${C_RESET}"
      fi
      local chk
      if [[ "${selected[$i]}" == "1" ]]; then
        chk="${C_GREEN}[x]${C_RESET}"
      else
        chk="${C_DIM}[ ]${C_RESET}"
      fi
      printf "  %s  %s)  %s  %s\n" "$chk" "$num" "$dot" "$label"
      (( i++ )) || true
    done

    printf "\n"
    printf "  ------------------------------------------------\n"
    printf "  ${C_CYAN}[1-7]${C_RESET} toggle   ${C_CYAN}[a]${C_RESET} all   ${C_CYAN}[n]${C_RESET} none   ${C_CYAN}[d]${C_RESET} detected\n"
    printf "  ${C_GREEN}[Enter]${C_RESET} confirm   ${C_RED}[q]${C_RESET} quit\n"
    printf "\n"
    printf "  >> "
    read -r input </dev/tty

    case "$input" in
      q|Q)
        printf "\n"; ok "Aborted.\n"; exit 0 ;;
      a|A)
        for (( j=0; j<${#ALL_IDES[@]}; j++ )); do selected[$j]=1; done ;;
      n|N)
        for (( j=0; j<${#ALL_IDES[@]}; j++ )); do selected[$j]=0; done ;;
      d|D)
        for (( j=0; j<${#ALL_IDES[@]}; j++ )); do selected[$j]="${detected_map[$j]}"; done ;;
      "")
        local any=false
        local s
        for s in "${selected[@]}"; do [[ "$s" == "1" ]] && any=true && break; done
        if $any; then
          break
        else
          printf "  ${C_YELLOW}Nothing selected -- pick an IDE or press q to quit.${C_RESET}\n"
          sleep 1
        fi ;;
      *)
        local toggled=false
        local num
        for num in $input; do
          if [[ "$num" =~ ^[0-9]+$ ]]; then
            local idx=$(( num - 1 ))
            if (( idx >= 0 && idx < ${#ALL_IDES[@]} )); then
              if [[ "${selected[$idx]}" == "1" ]]; then
                selected[$idx]=0
              else
                selected[$idx]=1
              fi
              toggled=true
            fi
          fi
        done
        if ! $toggled; then
          printf "  ${C_RED}Invalid. Enter a number 1-%s, or command.${C_RESET}\n" "${#ALL_IDES[@]}"
          sleep 1
        fi ;;
    esac

    local lines=$(( ${#ALL_IDES[@]} + 12 ))
    local l
    for (( l=0; l<lines; l++ )); do printf '\033[1A\033[2K'; done
  done

  # Build selected IDEs list
  SELECTED_IDES=()
  local i=0
  for t in "${ALL_IDES[@]}"; do
    if [[ "${selected[$i]}" == "1" ]]; then
      SELECTED_IDES+=("$t")
    fi
    (( i++ )) || true
  done
}

# ── Copy logic ────────────────────────────────────────────────────────────────
copy_files() {
  local dest_root="$1"
  local dry_run="$2"
  
  for folder in "${SOURCE_FOLDERS[@]}"; do
    if [[ ! -d "$folder" ]]; then
      continue
    fi
    
    while IFS= read -r -d '' src_file; do
      local rel="${src_file#$folder/}"
      local dest_file
      
      if $dry_run; then
        local stripped_dest_root="$dest_root"
        if [[ "$stripped_dest_root" == /* ]]; then
          stripped_dest_root="${stripped_dest_root#/}"
        fi
        dest_file="${REPO_ROOT}/.test/${stripped_dest_root}/${folder}/${rel}"
      else
        dest_file="${dest_root}/${folder}/${rel}"
      fi
      
      if [[ -f "$dest_file" ]]; then
        printf "  %s  %s\n" "$(warn "SKIP")" "$dest_file"
        SKIPPED_COUNT=$(( SKIPPED_COUNT + 1 ))
        continue
      fi
      
      local dest_dir; dest_dir="$(dirname "$dest_file")"
      if mkdir -p "$dest_dir" 2>/dev/null && cp "$src_file" "$dest_file" 2>/dev/null; then
        printf "  %s  %s  →  %s\n" "$(ok "COPY")" "$src_file" "$dest_file"
        COPIED_COUNT=$(( COPIED_COUNT + 1 ))
      else
        printf "  %s  %s  →  %s\n" "$(err "ERR ")" "$src_file" "$dest_file"
        ERRORS_COUNT=$(( ERRORS_COUNT + 1 ))
      fi
    done < <(find "$folder" -type f -print0 2>/dev/null | sort -z)
  done
}

# ── Main ──────────────────────────────────────────────────────────────────────
main() {
  local dry_run=true

  while [[ $# -gt 0 ]]; do
    case "$1" in
      --apply)
        dry_run=false
        shift
        ;;
      --help|-h)
        printf "Usage: ./workspace-sync.sh [--apply] [--help]\n"
        exit 0
        ;;
      *)
        printf "%s\n" "$(err "Unknown option: $1")"
        exit 1
        ;;
    esac
  done

  REPO_ROOT="${PWD}"

  # ── Banner ──────────────────────────────────────────────────────────────────
  local mode_label
  if $dry_run; then
    mode_label="${C_YELLOW}DRY-RUN → .test/${C_RESET}"
  else
    mode_label="${C_GREEN}APPLY${C_RESET}"
  fi
  
  printf "\n${C_BOLD}workspace-sync${C_RESET}  [%s]\n\n" "$mode_label"
  printf "  Source root : %s\n" "$REPO_ROOT"
  if $dry_run; then
    printf "  Destination : %s (mirroring real paths)\n\n" "${REPO_ROOT}/.test"
  else
    printf "  Destination : real IDE config folders\n\n"
  fi

  # ── Discover source files ───────────────────────────────────────────────────
  local folders_found=0
  for folder in "${SOURCE_FOLDERS[@]}"; do
    if [[ -d "$folder" ]]; then
      local count
      count=$(find "$folder" -type f 2>/dev/null | wc -l | tr -d ' ')
      if (( count > 0 )); then
        folders_found=$(( folders_found + 1 ))
      fi
    fi
  done
  
  if (( folders_found == 0 )); then
    printf "%s\n" "$(err "No source folders found.")"
    printf "Expected at least one of: %s in %s\n" "${SOURCE_FOLDERS[*]}" "$REPO_ROOT"
    exit 1
  fi

  printf "${C_BOLD}Found source folders:${C_RESET}\n"
  for folder in "${SOURCE_FOLDERS[@]}"; do
    if [[ -d "$folder" ]]; then
      local count
      count=$(find "$folder" -type f 2>/dev/null | wc -l | tr -d ' ')
      if (( count > 0 )); then
        local suffix="s"
        if [[ "$count" == "1" ]]; then
          suffix=""
        fi
        printf "  /%s  (%s file%s)\n" "$folder" "$count" "$suffix"
      fi
    fi
  done
  printf "\n"

  # ── IDE selection ───────────────────────────────────────────────────────────
  SELECTED_IDES=()
  interactive_select

  # ── Scope selection ─────────────────────────────────────────────────────────
  printf "\n${C_BOLD}Install scope:${C_RESET}\n"
  printf "  1) Project  (relative to current working directory)\n"
  printf "  2) Global   (IDE-specific user-level directory)\n"
  printf "  3) Both\n"
  
  printf "Scope [1]: "
  local scope_choice
  read -r scope_choice </dev/tty
  scope_choice="$(echo "$scope_choice" | xargs)"
  if [[ -z "$scope_choice" ]]; then
    scope_choice="1"
  fi
  
  SCOPES=()
  if [[ "$scope_choice" == "1" ]]; then
    SCOPES+=("project")
  elif [[ "$scope_choice" == "2" ]]; then
    SCOPES+=("global")
  else
    SCOPES+=("project" "global")
  fi

  # ── Preview ─────────────────────────────────────────────────────────────────
  printf "\n${C_BOLD}Copy plan:${C_RESET}\n"
  local total_destinations=0
  
  for name in "${SELECTED_IDES[@]}"; do
    for scope in "${SCOPES[@]}"; do
      local clean_name; clean_name="$(echo "$name" | tr -cd 'a-zA-Z0-9')"
      local var_name="RESOLVED_${clean_name}_${scope}"
      local dest_root
      dest_root=$(resolve_dest_root "$name" "$scope")
      eval "$var_name=\"\$dest_root\""
      
      local effective="$dest_root"
      if $dry_run; then
        local stripped_dest_root="$dest_root"
        if [[ "$stripped_dest_root" == /* ]]; then
          stripped_dest_root="${stripped_dest_root#/}"
        fi
        effective="${REPO_ROOT}/.test/${stripped_dest_root}"
      fi
      printf "  %s [%s]  →  %s\n" "${C_CYAN}${name}${C_RESET}" "$scope" "$effective"
      total_destinations=$(( total_destinations + 1 ))
    done
  done

  local total_files=0
  for folder in "${SOURCE_FOLDERS[@]}"; do
    if [[ -d "$folder" ]]; then
      local count
      count=$(find "$folder" -type f 2>/dev/null | wc -l | tr -d ' ')
      total_files=$(( total_files + count ))
    fi
  done

  printf "\n  %s source file(s) × %s destination(s)\n\n" "$total_files" "$total_destinations"

  if ! $dry_run; then
    if ! confirm "${C_YELLOW}This will write to real IDE directories. Continue?${C_RESET}"; then
      printf "%s\n\n" "$(ok "Aborted.")"
      exit 0
    fi
  fi

  # ── Execute ─────────────────────────────────────────────────────────────────
  printf "\n${C_BOLD}Copying...${C_RESET}\n\n"
  
  local total_copied=0
  local total_skipped=0
  local total_errors=0

  # Reset these so they can be modified by copy_files function
  COPIED_COUNT=0
  SKIPPED_COUNT=0
  ERRORS_COUNT=0

  for name in "${SELECTED_IDES[@]}"; do
    for scope in "${SCOPES[@]}"; do
      printf "%s\n" "${C_CYAN}── ${name} [${scope}] ──${C_RESET}"
      
      local clean_name; clean_name="$(echo "$name" | tr -cd 'a-zA-Z0-9')"
      local var_name="RESOLVED_${clean_name}_${scope}"
      local dest_root="${!var_name}"
      
      COPIED_COUNT=0
      SKIPPED_COUNT=0
      ERRORS_COUNT=0
      
      copy_files "$dest_root" "$dry_run"
      
      total_copied=$(( total_copied + COPIED_COUNT ))
      total_skipped=$(( total_skipped + SKIPPED_COUNT ))
      total_errors=$(( total_errors + ERRORS_COUNT ))
      
      printf "\n"
    done
  done

  # ── Summary ─────────────────────────────────────────────────────────────────
  printf "${C_BOLD}Done.${C_RESET}\n"
  printf "  %s  : %s\n" "${C_GREEN}Copied${C_RESET}" "$total_copied"
  printf "  %s : %s  (already exist)\n" "${C_YELLOW}Skipped${C_RESET}" "$total_skipped"
  printf "  %s  : %s\n" "${C_RED}Errors${C_RESET}" "$total_errors"

  if $dry_run; then
    printf "\n%s Inspect %s then run:\n" "${C_YELLOW}Dry-run complete.${C_RESET}" "${REPO_ROOT}/.test"
    printf "  %s\n" "${C_CYAN}./workspace-sync.sh --apply${C_RESET}"
  fi
  printf "\n"
}

main "$@"
