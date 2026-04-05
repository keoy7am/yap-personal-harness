---
name: harness-memory-router
description: Route memory operations (store/retrieve context) to the correct MCP tool based on memory.provider in ~/.claude/yap-personal-harness.json. Use this skill when you need to save a memory, search for past context, or retrieve stored information.
---

# harness-memory-router

Routes all memory operations to the correct provider based on `~/.claude/yap-personal-harness.json`.

## Step 1 — Read Config

Read `~/.claude/yap-personal-harness.json` and extract `memory.provider`.

If the file is missing, default to `claude-mem` and warn: "harness config not found, using claude-mem as default."

## Step 2 — Route by Provider

### Provider: `claude-mem`

**Query/Search:**
```
mcp__plugin_claude-mem_mcp-search__search
  query: <search terms>
```

**Save Memory:**
```
mcp__plugin_claude-mem_mcp-search__save_memory
  content: <memory content>
  tags: [relevant tags]
```

**Fallback if tool unavailable:** Warn "claude-mem MCP not available" → fall through to `local` provider.

---

### Provider: `serena`

**Query:**
```
mcp__plugin_serena_serena__list_memories
mcp__plugin_serena_serena__read_memory  name: <memory-name>
```

**Save:**
```
mcp__plugin_serena_serena__write_memory  name: <slug>  content: <content>
```

**Fallback if tool unavailable:** Warn "serena MCP not available" → fall through to `local` provider.

---

### Provider: `local`

Read `memory.local_memory_dir` from config (default: `./memory`).

**Query:** Read `<local_memory_dir>/<file>.md` files listed in `memory.local_auto_load`.

**Save:** Write/Edit `<local_memory_dir>/<slug>.md`.

**Fallback if directory missing:** Create `./memory/` and proceed.

---

### Provider: `none`

Output: "Memory layer is disabled (provider: none). To enable, run: /yap config set memory.provider claude-mem"

Do not attempt any memory operations.

---

## Step 3 — Fallback Chain

If the configured provider fails:
1. Try `local` provider as fallback
2. If local also fails, output a warning but do NOT block the user's actual task

## Output Format

After routing, briefly confirm:
```
[Memory: <provider>] <operation> → <result summary>
```
