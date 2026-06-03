#!/usr/bin/env bash
set -euo pipefail

REPO_NAME="Cyber_Matao"
REPO_DESC="遵循本人的嘱托，现将赛博永生！"
TAG_NAME="V1.0"
ASSET="release/matao_tone_pack_v1.0.zip"

if ! command -v gh >/dev/null 2>&1; then
  echo "gh is required. Install GitHub CLI and run gh auth login first."
  exit 1
fi

gh auth status >/dev/null

bash scripts/privacy_audit.sh

OWNER="$(gh api user --jq .login)"
REPO_FULL_NAME="$OWNER/$REPO_NAME"

if ! gh repo view "$REPO_FULL_NAME" >/dev/null 2>&1; then
  gh repo create "$REPO_FULL_NAME" \
    --public \
    --description "$REPO_DESC"
else
  gh repo edit "$REPO_FULL_NAME" \
    --description "$REPO_DESC" \
    --visibility public \
    --accept-visibility-change-consequences
fi

if git remote get-url origin >/dev/null 2>&1; then
  git remote set-url origin "https://github.com/$REPO_FULL_NAME.git"
else
  git remote add origin "https://github.com/$REPO_FULL_NAME.git"
fi

git push -u origin main

if gh release view "$TAG_NAME" --repo "$REPO_FULL_NAME" >/dev/null 2>&1; then
  gh release upload "$TAG_NAME" "$ASSET" \
    --repo "$REPO_FULL_NAME" \
    --clobber
else
  gh release create "$TAG_NAME" "$ASSET" \
    --repo "$REPO_FULL_NAME" \
    --title "$TAG_NAME" \
    --notes-file RELEASE_NOTES_V1.0.md
fi

echo "Published https://github.com/$REPO_FULL_NAME"
echo "Release https://github.com/$REPO_FULL_NAME/releases/tag/$TAG_NAME"
