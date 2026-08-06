# CLAUDE.md

This file provides guidance to Claude Code (claude.ai/code) when working with code in this repository.

## What this is

A content repo, not an application. Two agent skills (`skills/codebase-map`,
`skills/lean-code`), each a single `SKILL.md`, plus `install.sh` that copies them
into four agent runtimes. No build, no tests, no dependencies.

## Architecture

The source of truth for each skill is `skills/<name>/SKILL.md`. Everything else is
distribution. `install.sh` copies (never symlinks — see the `ponytail:` comment there)
that one file to four destinations with different naming conventions:

| Agent | Path |
|---|---|
| Claude Code | `~/.claude/skills/<name>/SKILL.md` |
| Codex | `~/.codex/prompts/<name>.md` |
| opencode | `~/.config/opencode/skill/<name>/SKILL.md` |
| Kilo Code | `$PWD/.kilocode/workflows/<name>.md` (per-project, run from that repo's root) |

Consequence: a `SKILL.md` must work as a Claude auto-loaded skill *and* as a bare
`/slash` prompt. Keep it self-contained — no relative links to other repo files.

The YAML frontmatter `description` is how Claude Code and opencode decide whether to
load a skill; it is load-bearing, not documentation. Write it as trigger conditions.

Adding a skill = new `skills/<name>/SKILL.md` + append the name to the `SKILLS` array
in `install.sh` + a row in `README.md`.

## Distribution channels

Two, and they read the same `skills/` dir:

- **Plugin manifests** — `.claude-plugin/marketplace.json` + `plugin.json` make this repo
  its own Claude Code marketplace (`/plugin marketplace add wahyuakbarwibowo/akbar-skills`).
  `.codex-plugin/plugin.json` mirrors it for Codex. Both auto-discover `skills/`, so a new
  skill needs no manifest edit — but bump `version` in all three manifests together.
- **`npx akbar-skills`** — `package.json` `bin` points at `install.sh`; this is the only
  channel that reaches opencode and Kilo Code, which have no self-hostable marketplace
  (opencode plugins are npm packages, Kilo's marketplace is a PR to `Kilo-Org/kilocode-marketplace`).

## Commands

```bash
./install.sh            # install both skills into all four agents
./install.sh claude     # or codex | opencode | kilocode
```

Edit a `SKILL.md`, re-run `install.sh` to propagate. Verify a change by reading the
installed copy, e.g. `~/.claude/skills/lean-code/SKILL.md`.
