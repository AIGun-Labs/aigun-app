#!/bin/bash
set -euo pipefail

# 提取 CHANGELOG 中指定版本的内容
# 用法: ./extract-changelog.sh <version> <zh|en>

VERSION="$1"
LANG="${2:-zh}"

# 语言配置
case "$LANG" in
  zh)
    FILE="CHANGELOG_zh.md"
    DEFAULT_MSG="- 修复已知问题"
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

# 提取 changelog
extract() {
  local file="$1"
  local version="$2"
  local default="$3"
  
  if [ ! -f "$file" ]; then
    echo "$default"
    return
  fi
  
  # 尝试格式：## [版本号]
  changelog=$(sed 's/\r$//' "$file" | awk "/## \[${version}\]/{found=1; next} found && /^## \[/{exit} found{print}")
  
  # 尝试格式：## 版本号
  if [ -z "$changelog" ]; then
    changelog=$(sed 's/\r$//' "$file" | awk "/## ${version}[^[]/{found=1; next} found && /^## /{exit} found{print}")
  fi
  
  # 使用默认消息
  if [ -z "$changelog" ]; then
    echo "$default"
  else
    echo "$changelog"
  fi
}

extract "$FILE" "$VERSION" "$DEFAULT_MSG"