# yap-personal-harness

A personal [Claude Code](https://claude.ai/code) plugin implementing the [IMPACT Framework](https://www.youtube.com/watch?v=6Vf4BVFNbKI) for agent harness architecture.

## What This Does

Fills the remaining gaps in a Claude Code workflow and replaces gstack dependency (due to telemetry concerns):

| Gap | Solution |
|-----|---------|
| Memory fragmentation (claude-mem vs serena) | `harness-memory-router` — unified provider interface |
| Manual phase transitions | `harness-workflow-chain` — research→plan→implement→review |
| gstack telemetry dependency | `yap-plan`, `yap-autoplan`, `yap-ship`, `yap-investigate` |

## Installation

1. Add to your local marketplace (`~/.claude/plugins/repos/.claude-plugin/marketplace.json`):
```json
{
  "name": "yap-personal-harness",
  "version": "1.0.0",
  "source": "./yap-personal-harness",
  "description": "Personal Harness: pluggable memory, session lifecycle, workflow chaining, gstack-replacement planning/review/ship"
}
```

2. Enable in `~/.claude/settings.json`:
```json
"yap-personal-harness@yap-local": true
```

3. On first session start, `~/.claude/yap-personal-harness.json` is auto-created.

## Commands

| Command | Description |
|---------|-------------|
| `/yap` | Show harness status |
| `/yap config set memory.provider serena` | Switch memory provider |
| `/yap workflow` | Start 4-phase workflow |
| `/yap-plan [topic]` | Create structured plan (replaces `/gstack`) |
| `/yap-autoplan` | Sequential plan review: CEO → Eng → DX |
| `/yap-ship` | Commit + push + PR |
| `/yap-investigate [symptoms]` | 4-phase root cause analysis |

> Add global shortcuts by copying the files in `commands/` to `~/.claude/commands/`.

## Memory Providers

Configure in `~/.claude/yap-personal-harness.json`:

| Provider | Tools Used |
|----------|-----------|
| `claude-mem` | `mcp__plugin_claude-mem_mcp-search__*` |
| `serena` | `mcp__plugin_serena_serena__*_memory` |
| `local` | Read/Write `./memory/*.md` |
| `none` | Disabled |

## Architecture

```
SessionStart hook (type: command)
    └── session-start.sh → reads harness.json → emits additionalContext

Skills (on demand):
├── harness-memory-router   ← route save/query to correct MCP
├── harness-workflow-chain  ← 4-phase workflow orchestration
├── yap-plan                ← structured planning (replaces gstack)
├── yap-autoplan            ← sequential review: CEO→Eng→DX
├── yap-ship                ← safe commit + PR
└── yap-investigate         ← 4-phase root cause analysis

Agents (used by yap-autoplan):
├── plan-ceo-reviewer       ← strategy + scope + ROI
├── plan-eng-reviewer       ← architecture + technical risk
├── plan-devex-reviewer     ← developer experience
└── plan-design-reviewer    ← UI/UX (conditional)
```

## Why Not gstack?

gstack sends usage telemetry to a Supabase instance controlled by Garry Tan (YC CEO). The community raised concerns ([HN discussion](https://news.ycombinator.com/item?id=47355173)) about whether YC gains signal on what developers are building. This plugin provides equivalent planning/review/ship/investigate functionality with zero telemetry.

## License

MIT
