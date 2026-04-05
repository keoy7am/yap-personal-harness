---
name: yap-plan
description: Structured planning skill replacing /gstack. Creates a comprehensive implementation plan using Architect + CEO dual perspective. Saves plan to ~/.claude/plans/<slug>.md. Use when starting any non-trivial task.
---

# yap-plan

Replaces `/gstack` planning. Creates structured implementation plans without telemetry.

## Step 1 — Context Gathering

1. Read `~/.claude/yap-personal-harness.json` for planning context
2. If `CLAUDE.md` exists in the project root, read it for architecture constraints
3. If a previous plan exists in `~/.claude/plans/`, check if it's still relevant

## Step 2 — Requirements Analysis

Understand the task through two lenses:

**Architect lens**: What are the technical constraints? What existing patterns must be respected? What are the risks?

**CEO lens**: Why is this being built? What is the minimal scope that delivers value? What should be deferred?

If requirements are unclear, ask ONE focused clarifying question before proceeding.

## Step 3 — Plan Generation

Generate a structured plan with this format:

```markdown
# <Task Title> — Implementation Plan

## Context
<Why this is being built. The problem it solves. What prompted it.>

## Approach
<The chosen approach and why. Alternatives considered and rejected.>

## Implementation Steps
1. <Step with specific file paths>
2. <Step with specific file paths>
...

## Critical Files
- `<path>` — <role>
- `<path>` — <role>

## Verification
<How to verify the implementation is correct. Commands to run, behaviors to check.>

## Out of Scope
<What is explicitly NOT being done in this plan.>
```

## Step 4 — Save Plan

Generate a URL-safe slug from the task title.
Save to `~/.claude/plans/<slug>.md`.

## Step 5 — Output Summary

Output a concise summary:
```
Plan saved: ~/.claude/plans/<slug>.md
Steps: <N>
Critical files: <list>
Next: approve plan → bypass permissions → implement
```
