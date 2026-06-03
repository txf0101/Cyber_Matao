#!/usr/bin/env bash
set -euo pipefail

TARGET_DIR="${1:-$PWD}"
PACK_DIR="$(cd "$(dirname "$0")/.." && pwd)"
DEST_DIR="$TARGET_DIR/.matao_tone_pack"

mkdir -p "$DEST_DIR"
cp "$PACK_DIR/tone_pack/PROMPT_BLOCK.md" "$DEST_DIR/PROMPT_BLOCK.md"
cp "$PACK_DIR/README.md" "$DEST_DIR/README.md"
cp "$PACK_DIR/LICENSE.md" "$DEST_DIR/LICENSE.md"
cp "$PACK_DIR/PRIVACY.md" "$DEST_DIR/PRIVACY.md"

append_once() {
  local file="$1"
  local fragment="$2"
  local marker="MATAO_TONE_PACK_BEGIN"

  if [ -f "$file" ] && grep -q "$marker" "$file"; then
    return 0
  fi

  if [ -f "$file" ]; then
    printf '\n\n' >> "$file"
  fi

  cat "$fragment" >> "$file"
}

append_once "$TARGET_DIR/AGENTS.md" "$PACK_DIR/install/AGENTS.fragment.md"
append_once "$TARGET_DIR/CLAUDE.md" "$PACK_DIR/install/CLAUDE.fragment.md"

printf 'Installed privacy-preserving matao tone pack into %s\n' "$DEST_DIR"
printf 'Activation phrase: 用马涛的口吻和我说话\n'
printf 'Reset phrase: 做回你自己\n'

