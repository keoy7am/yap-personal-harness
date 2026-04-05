#!/usr/bin/env bash
# Setup hook: auto-copy harness.default.json to user config on first install

set -euo pipefail

CONFIG_PATH="$HOME/.claude/yap-personal-harness.json"
DEFAULT_PATH="${CLAUDE_PLUGIN_ROOT}/config/harness.default.json"

if [ ! -f "$CONFIG_PATH" ]; then
  cp "$DEFAULT_PATH" "$CONFIG_PATH"
  echo "yap-personal-harness: Config created at $CONFIG_PATH"
  echo "Edit it to change memory provider (claude-mem/serena/local/none) and other settings."
else
  echo "yap-personal-harness: Config already exists at $CONFIG_PATH"
fi
