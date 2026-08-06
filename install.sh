#!/usr/bin/env bash
# Install the skills into claude / codex / opencode / kilocode.
# Usage: ./install.sh [claude|codex|opencode|kilocode|all]   (default: all)
# Global installs except kilocode, which is per-project (run from the project root).
set -euo pipefail

SRC="$(cd "$(dirname "$0")/skills" && pwd)"
SKILLS=(codebase-map lean-code)
TARGET="${1:-all}"

# ponytail: copy, not symlink — kilocode/codex read plain files and symlinks
# break when this repo moves. Re-run install.sh to update.
put() { mkdir -p "$(dirname "$2")"; cp "$1" "$2"; echo "  $2"; }

for s in "${SKILLS[@]}"; do
  f="$SRC/$s/SKILL.md"
  case "$TARGET" in claude|all)   put "$f" "$HOME/.claude/skills/$s/SKILL.md" ;; esac
  case "$TARGET" in codex|all)    put "$f" "$HOME/.codex/prompts/$s.md" ;; esac
  case "$TARGET" in opencode|all) put "$f" "$HOME/.config/opencode/skill/$s/SKILL.md" ;; esac
  case "$TARGET" in kilocode|all) put "$f" "$PWD/.kilocode/workflows/$s.md" ;; esac
done

echo "done. claude: auto-loaded by description. codex/kilocode: /$s. opencode: skill tool."
