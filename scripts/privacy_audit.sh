#!/usr/bin/env bash
set -euo pipefail

ROOT_DIR="$(cd "$(dirname "$0")/.." && pwd)"

PUBLIC_FILES=()
while IFS= read -r file; do
  PUBLIC_FILES+=("$file")
done < <(git -C "$ROOT_DIR" ls-files --cached --others --exclude-standard)

if printf '%s\n' "${PUBLIC_FILES[@]}" | grep -E '(^|/)(comments_.*\.jsonl|.*\.jsonl)$' >/dev/null; then
  echo 'privacy audit failed: raw jsonl source material is present in public paths'
  exit 1
fi

SCAN_FILES=()
for file in "${PUBLIC_FILES[@]}"; do
  case "$file" in
    scripts/privacy_audit.sh|*.zip)
      ;;
    *)
      SCAN_FILES+=("$ROOT_DIR/$file")
      ;;
  esac
done

if [ "${#SCAN_FILES[@]}" -gt 0 ] && grep -InE '(^|[^[:alnum:]_])(user_id|user_name|ip|referenced_user|reply_id|bvid|pubdate|source_evidence|style_samples)([^[:alnum:]_]|$)' \
  "${SCAN_FILES[@]}"; then
  echo 'privacy audit failed: identifier or source-evidence terms found'
  exit 1
fi

for file in "${PUBLIC_FILES[@]}"; do
  case "$file" in
    *.zip)
      if unzip -l "$ROOT_DIR/$file" | grep -E 'comments_.*\.jsonl|\.jsonl|source_evidence|style_samples' >/dev/null; then
        echo "privacy audit failed: archive $file contains raw-source-style filenames"
        exit 1
      fi
      ;;
  esac
done

echo 'privacy audit passed'
