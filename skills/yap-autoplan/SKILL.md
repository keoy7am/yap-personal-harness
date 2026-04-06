---
name: yap-autoplan
description: Sequential multi-perspective plan review pipeline (CEO → Eng → DX). Replaces /autoplan. Each reviewer receives prior context. Appends REVIEW REPORT to the plan file and outputs a VERDICT.
---

# yap-autoplan

Sequential review pipeline. Replaces gstack `/autoplan`.

**Critical**: Reviews run SEQUENTIALLY. Each phase receives the output of the previous phase. Do NOT run in parallel — parallel reviews produce contradictory findings without shared context.

## Step 0 — Activate MCP Tools

Invoke `mcp__sequential-thinking__sequentialthinking` to structure the multi-phase review process. Use it to track cross-phase findings and ensure consistency between CEO → Eng → DX reviews. If unavailable, proceed natively.

## Step 1 — Find Plan File

Look for the most recent plan file in `~/.claude/plans/`. If multiple exist, ask the user which one to review.

Read the full plan content.

## Step 2 — Detect UI

Check if the plan mentions UI components, frontend, design system, or user-facing interfaces. Set `HAS_UI = true/false`.

## Step 3 — CEO Review (Phase 1)

Launch Agent: `yap-personal-harness:plan-ceo-reviewer`

Pass: full plan content + task "Review this plan from a CEO/strategy perspective"

Wait for completion. Store CEO review output.

## Step 4 — Eng Review (Phase 2)

Launch Agent: `yap-personal-harness:plan-eng-reviewer`

Pass: full plan content + CEO review output + task "Review this plan from an engineering/architecture perspective, taking CEO's scope decisions into account"

Wait for completion. Store Eng review output.

## Step 5 — DX Review (Phase 3)

Launch Agent: `yap-personal-harness:plan-devex-reviewer`

Pass: full plan content + CEO review + Eng review + task "Review this plan from a developer experience perspective, taking architecture decisions into account"

Wait for completion. Store DX review output.

## Step 6 — Design Review (Phase 4, conditional)

Only if `HAS_UI = true`:

Launch Agent: `yap-personal-harness:plan-design-reviewer`

Pass: full plan content + all prior reviews + task "Review the UI/UX aspects of this plan"

Wait for completion.

## Step 7 — Compile Report

Append to the plan file:

```markdown
## YAP AUTOPLAN REVIEW REPORT

| Review | Runs | VERDICT | Critical | High | Medium |
|--------|------|---------|----------|------|--------|
| CEO Review | 1 | <verdict> | <n> | <n> | <n> |
| Eng Review | 1 | <verdict> | <n> | <n> | <n> |
| DX Review  | 1 | <verdict> | <n> | <n> | <n> |
| Design Review | <0 or 1> | <verdict or skipped> | — | — | — |

**OVERALL VERDICT: <APPROVED | NEEDS_REVISION | BLOCKED>**

<If NEEDS_REVISION or BLOCKED, list the required changes>
```

## Step 8 — Output

Print the OVERALL VERDICT and the top 3 most critical findings.
