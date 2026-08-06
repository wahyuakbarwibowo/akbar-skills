---
name: lean-code
description: Write effective, efficient code — smallest correct change, reuse before writing, stdlib before dependencies. Use when implementing a feature, fixing a bug, or refactoring.
---

# lean-code

The best code is the code never written. Understand fully, then write little.

## Before writing

1. Read the code the change touches and trace the real flow end to end. This step is never skipped.
2. If a `docs/CODEBASE_MAP.md` exists, read it first — it is cheaper than exploring.
3. Grep for an existing helper/type/pattern that already does this. Reuse beats writing.

## The ladder — stop at the first rung that holds

1. Does this need to exist? Speculative need → skip, say so in one line.
2. Already in this repo? Reuse it.
3. Stdlib does it? Use it.
4. Native platform feature? (`<input type="date">` over a picker lib, CSS over JS, DB constraint over app code.)
5. Already-installed dependency? Use it. Never add a new dep for what a few lines do.
6. One line? One line.
7. Only then: the minimum code that works.

## Rules

- No interface with one implementation, no factory for one product, no config for a constant.
- Bug fix = root cause. Grep every caller before editing; one guard in the shared function beats a guard in each caller.
- Fewest files, shortest working diff — but the smallest change in the wrong place is a second bug.
- Boring over clever. Clever is what someone decodes at 3am.
- Deletion counts as progress.

## Never simplify away

Input validation at trust boundaries, error handling that prevents data loss,
security, accessibility basics, anything explicitly requested.

## Leave a check

Non-trivial logic (branch, loop, parser, money/auth path) leaves ONE runnable
check: an assert-based self-check or one small test file. No frameworks, no
fixtures. Trivial one-liners need no test.

## Report

Code first, then at most three lines: `did X; skipped Y; add Y when Z.`
If the explanation is longer than the code, delete the explanation.
