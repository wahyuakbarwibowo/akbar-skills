# Portable agent skills

Two skills, one `SKILL.md` each, installable into four agents.

- **codebase-map** — read an existing codebase, write `docs/CODEBASE_MAP.md` as a durable artifact other agents load instead of re-exploring.
- **lean-code** — write the smallest correct change: reuse → stdlib → native → one line.

## Install

```bash
npx akbar-skills         # all four, no clone
# or, from a clone:
./install.sh             # all four
./install.sh claude      # or codex | opencode | kilocode
```

Claude Code, as a plugin marketplace:

```
/plugin marketplace add wahyuakbarwibowo/akbar-skills
/plugin install akbar-skills@akbar-skills
```

| Agent | Path | Invoke |
|---|---|---|
| Claude Code | `~/.claude/skills/<name>/SKILL.md` | auto (matched on description) or `/<name>` |
| Codex | `~/.codex/prompts/<name>.md` | `/<name>` |
| opencode | `~/.config/opencode/skill/<name>/SKILL.md` | skill tool / by description |
| Kilo Code | `<project>/.kilocode/workflows/<name>.md` | `/<name>` — per project, run from repo root |

Edit `skills/<name>/SKILL.md` and re-run `install.sh` to update everywhere.

## The artifact

`codebase-map` writes `docs/CODEBASE_MAP.md` into the target repo — plain
markdown, every claim citing a path, stamped with the commit sha. Any agent
reads it directly; commit it so the next session starts warm.
