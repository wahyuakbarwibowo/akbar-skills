---
name: codebase-map
description: Read an existing codebase and write a durable map artifact (CODEBASE_MAP.md) that other agents can load instead of re-exploring. Use when joining an unfamiliar repo, when asked to "understand/explain this codebase", or when the map is stale.
---

# codebase-map

Goal: one file, `docs/CODEBASE_MAP.md`, that lets a cold agent act correctly
without re-reading the repo. Written for machines, not for a README audience.

## Read order (stop when you can answer the questions below)

1. Entry points: manifests (`package.json`, `pyproject.toml`, `go.mod`, `Cargo.toml`, `Makefile`), `main`/`index`/`cmd/`, CI config.
2. Directory shape: `git ls-files | sed 's|/[^/]*$||' | sort | uniq -c | sort -rn | head -40` (fall back to `find` if not a git repo). Ignore vendor/build dirs.
3. The 5-10 biggest / most-imported files. Those are the real architecture.
4. One end-to-end trace of the primary flow (request → handler → service → data). Follow it with grep, do not guess.
5. Tests: how they run, what they cover, what they don't.

Do not read every file. Stop when the map answers its questions.

## Output template

```markdown
# Codebase Map — <repo>
Generated <YYYY-MM-DD> · commit <sha> · regenerate with the codebase-map skill

## What it is
<2 sentences: what it does, who calls it.>

## Stack
Language/runtime, framework, datastore, key deps (only ones that shape design).

## Layout
| Path | Role | Touch when |
|---|---|---|

## Primary flow
<entry> → <file:sym> → <file:sym> → <store>. One line per hop, with real paths.

## Key files
`path:sym` — why it matters. (max 15)

## Conventions
Naming, error handling, logging, config, auth — as actually practiced, with one
example path each. Note where the codebase contradicts itself.

## Commands
build / test / lint / run — copy-pasteable, verified to exist in manifests or CI.

## Landmines
Things that look safe and are not. Global state, implicit ordering, generated
files, anything with a "do not edit" comment.

## Unknowns
What you did not read and what would answer it.
```

## Rules

- Every claim cites a path. No path, cut the line.
- Facts only: no advice, no refactor proposals, no praise.
- If it's derivable in 5 seconds from the file tree, leave it out.
- Regenerating: update in place, keep the file one file. Do not append a v2.
- Stale beats absent, but mark the commit sha so staleness is visible.
