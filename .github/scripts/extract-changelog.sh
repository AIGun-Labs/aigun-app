#!/bin/bash
set -euo pipefail

VERSION="$1"
LANG="${2:-zh}"
case "$LANG" in
  zh)
    FILE="CHANGELOG_zh.md"
    DEFAULT_MSG="- "
    ;;
  en)
    FILE="CHANGELOG_en.md"
    DEFAULT_MSG="- Fixed known issues"
    ;;
  *)
    echo "❌ Unsupported language: $LANG" >&2
    exit 1
    ;;
esac
extract() {
  local file="$1"
  local version="$2"
  local default="$3"
  
  if [ ! -f "$file" ]; then
    echo "$default"
    return
  fi
  changelog=$(sed 's/\r$//' "$file" | awk "/## \[${version}\]/{found=1; next} found && /^## \[/{exit} found{print}")
  if [ -z "$changelog" ]; then
    changelog=$(sed 's/\r$//' "$file" | awk "/## ${version}[^[]/{found=1; next} found && /^## /{exit} found{print}")
  fi
  if [ -z "$changelog" ]; then
    echo "$default"
  else
    echo "$changelog"
  fi
}

extract "$FILE" "$VERSION" "$DEFAULT_MSG"