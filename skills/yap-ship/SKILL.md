---
name: yap-ship
description: Safely commit, push, and create a PR. Replaces gstack /ship. Runs pre-flight checks, tests, version bump, and creates a PR with a conventional commit message.
---

# yap-ship

Replaces gstack `/ship`. No telemetry.

## Step 1 — Pre-flight Checks

```bash
git branch --show-current
```

If on `main` or `master`: STOP and warn "You're on the main branch. Create a feature branch first."

Check for uncommitted changes:
```bash
git status --short
git diff --stat
```

If working tree is clean: inform user "Nothing to commit. Did you forget to save changes?"

## Step 2 — Run Tests (if available)

Check for test runner in order:
1. `package.json` → run `npm test` or `bun test`
2. `Makefile` with `test` target → run `make test`
3. `go.mod` → run `go test ./...`
4. No tests found → skip with notice

If tests fail: STOP and report failures. Do not proceed.

## Step 3 — Review Changes

Show:
```bash
git diff --stat HEAD
git diff HEAD
```

Ask user to confirm the diff is correct before proceeding.

## Step 4 — Version Bump (optional)

If `package.json` exists and has a `version` field:
Ask: "Bump version? (patch / minor / major / skip)"

Apply bump if requested using `npm version` or manual edit.

## Step 5 — Commit

Generate a conventional commit message based on the diff:
- `feat:` for new features
- `fix:` for bug fixes
- `refactor:` for refactoring
- `docs:` for documentation
- `chore:` for maintenance

```bash
git add -A
git commit -m "<type>: <description>"
```

## Step 6 — Push + PR

```bash
git push -u origin <branch>
```

Create PR:
```bash
gh pr create --title "<commit title>" --body "$(cat <<'EOF'
## Summary
<bullet points from commit>

## Test plan
- [ ] Tests pass
- [ ] Manual verification: <describe>
EOF
)"
```

## Step 7 — Output

Print the PR URL.
