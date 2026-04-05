#!/usr/bin/env bash
# SessionStart hook: reads harness.json and emits additionalContext status line
# Pattern: superpowers hookSpecificOutput.additionalContext

set -uo pipefail

CONFIG_PATH="$HOME/.claude/yap-personal-harness.json"
DEFAULT_PATH="${CLAUDE_PLUGIN_ROOT}/config/harness.default.json"

# Fallback: auto-create config if missing
if [ ! -f "$CONFIG_PATH" ]; then
  cp "$DEFAULT_PATH" "$CONFIG_PATH" 2>/dev/null || true
fi

# Read provider values via node (available on all platforms with Claude Code)
MEMORY_PROVIDER=$(node -e "
  try {
    const c = JSON.parse(require('fs').readFileSync('$CONFIG_PATH', 'utf8'));
    console.log((c.memory && c.memory.provider) || 'claude-mem');
  } catch(e) { console.log('claude-mem'); }
" 2>/dev/null || echo "claude-mem")

PLANNING_PROVIDER=$(node -e "
  try {
    const c = JSON.parse(require('fs').readFileSync('$CONFIG_PATH', 'utf8'));
    console.log((c.planning && c.planning.provider) || 'yap-plan');
  } catch(e) { console.log('yap-plan'); }
" 2>/dev/null || echo "yap-plan")

STATUS="yap-personal-harness active | Memory: ${MEMORY_PROVIDER} | Planning: ${PLANNING_PROVIDER} | /yap status for details"

# Escape for JSON string
escape_json() {
  local s="$1"
  s="${s//\\/\\\\}"
  s="${s//\"/\\\"}"
  printf '%s' "$s"
}

STATUS_ESCAPED=$(escape_json "$STATUS")

cat <<EOF
{
  "hookSpecificOutput": {
    "hookEventName": "SessionStart",
    "additionalContext": "${STATUS_ESCAPED}"
  }
}
EOF

exit 0
