---
name: yap-investigate
description: Four-phase root cause investigation methodology. Replaces gstack /investigate. Iron Law: no fix without identified root cause. Use when debugging errors, unexpected behavior, or system failures.
---

# yap-investigate

Replaces gstack `/investigate`. No telemetry.

**Iron Law**: Do not attempt a fix until Phase 3 (Hypothesize) is complete and a root cause has been identified.

## Phase 0 — Activate Sequential Thinking

Invoke `mcp__sequential-thinking__sequentialthinking` now to structure the investigation. Use it throughout all phases to track hypotheses, evidence, and reasoning chains. If unavailable, proceed natively.

## Phase 1 — Investigate

**Goal**: Gather all available evidence before forming any hypotheses.

Collect:
1. **Symptoms**: What exactly is broken? What does the user see?
2. **Reproduction**: Can it be reproduced reliably? Under what conditions?
3. **Error messages**: Full error text, stack traces, log output
4. **Recent changes**: What changed before this started? (`git log --oneline -20`)
5. **Environment**: OS, versions, config, environment variables

Do NOT form hypotheses yet. Only gather facts.

Output a structured symptom report:
```
SYMPTOMS:
- <symptom 1>
REPRODUCTION: <reliable / intermittent / not reproducible>
ERROR: <exact error text>
RECENT CHANGES: <list>
ENVIRONMENT: <relevant details>
```

## Phase 2 — Analyze

**Goal**: Identify patterns and narrow the root cause search space.

1. Look for correlations between symptoms and recent changes
2. Identify which components are involved
3. Rule out unlikely causes based on evidence
4. Map the data/control flow through affected components

Output:
```
CANDIDATE CAUSES (ranked by likelihood):
1. <most likely> — evidence: <why>
2. <second>      — evidence: <why>
3. <third>       — evidence: <why>

RULED OUT:
- <cause> — reason: <why ruled out>
```

## Phase 3 — Hypothesize

**Goal**: Select the most likely root cause and validate it.

1. Choose the top candidate from Phase 2
2. Form a testable hypothesis: "If X is the root cause, then Y should be true"
3. Verify the hypothesis by reading code, running queries, or checking logs
4. If hypothesis is confirmed → proceed to Phase 4
5. If hypothesis is wrong → return to Phase 2 with new evidence

Output:
```
ROOT CAUSE: <specific, precise statement>
EVIDENCE: <what confirms it>
CONFIDENCE: high / medium / low
```

**Do not proceed to Phase 4 if confidence is low.** Return to Phase 2.

## Phase 4 — Implement

**Goal**: Minimal, targeted fix.

Constraints:
- Fix must be ≤20 lines changed (if larger, it's probably not minimal enough)
- Fix must address the root cause, not the symptom
- Fix must not introduce new risks

Steps:
1. Describe the fix in one sentence before writing code
2. Implement the fix
3. Verify: run tests or manually confirm the symptom is resolved
4. Output a brief post-mortem:
   ```
   ROOT CAUSE: <1 sentence>
   FIX: <1 sentence>
   PREVENTION: <how to avoid this class of bug in future>
   ```
