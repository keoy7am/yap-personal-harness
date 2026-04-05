---
name: harness-workflow-chain
description: Execute the full 4-phase development workflow (research → plan → implement → review). Use when the user wants to start a new feature or task from scratch with the complete pipeline.
---

# harness-workflow-chain

Executes the 4-phase workflow defined in `~/.claude/yap-personal-harness.json`.

## Step 1 — Load Config

Read `~/.claude/yap-personal-harness.json`. Extract:
- `workflow.phases` (default: research, plan, implement, review)
- `workflow.review_command` (default: auto-review:multi-team)
- `workflow.confirm_between_phases` (default: true)
- `planning.provider` (determines which planning skill to use)

## Step 2 — Phase 1: Research

Invoke skill: `sc:research` with the user's topic.

If `confirm_between_phases` is true: pause and ask "Research complete. Proceed to planning?"

## Step 3 — Phase 2: Plan

If `planning.provider` is `yap-plan`: invoke `yap-personal-harness:yap-plan`
If `planning.provider` is `gstack`: suggest user runs `/gstack` manually (transitional)

Enter Plan Mode for structured planning.

If `confirm_between_phases` is true: pause and ask "Plan approved. Proceed to implementation?"

## Step 4 — Phase 3: Implement

Remind user: "Entering implementation. Ensure bypass permissions mode is active."

Proceed with implementation as directed by the plan.

If `confirm_between_phases` is true: pause and ask "Implementation complete. Proceed to review?"

## Step 5 — Phase 4: Review

Invoke the review command from config. Default: `auto-review:multi-team`

Output final status summary.
