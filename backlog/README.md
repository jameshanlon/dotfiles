# backlog

A Claude Code plugin for managing a project task backlog as one markdown file per task.

## What it does

- **Skill** (`skills/backlog`): teaches Claude the storage format and conventions, so it can act on natural requests like "add a task for the auth bug" or "what should I work on next" without you needing to remember exact syntax.
- **Commands**: `/backlog:add`, `/backlog:list`, `/backlog:done`, `/backlog:next` for quick, explicit actions.
- **Hook**: on session start, prints a one-line backlog summary (counts of open/in-progress/blocked) if the current repo has a backlog.

## Storage

Tasks are stored per-repo at `.claude/backlog/tasks/<id>-<slug>.md`, git-tracked alongside your code. The plugin itself is installed once and works the same way in every repo — but each repo keeps its own backlog.

Each task file:

```markdown
---
id: 0001
title: Fix auth redirect loop
status: open
priority: medium
tags: [bug, auth]
created: 2026-08-13
updated: 2026-08-13
---

Optional free-text notes.
```

## Install (works in every repo)

`setup.sh` in this repo symlinks the plugin to `~/.claude/skills/backlog`, from
where Claude Code auto-loads it as `backlog@skills-dir` in any session, in any
repo. Because it's a symlink, edits here take effect directly.

Run `/reload-plugins` to pick up changes without restarting, and
`claude plugin details backlog` to check what's loaded.

To try it without installing:

```bash
claude --plugin-dir ./backlog
```

## Try it

```
/backlog:add Fix auth redirect loop
/backlog:list
/backlog:next
/backlog:done 0001
```

Or just talk to it naturally: "add a high priority task to update the README", "what's blocked right now?", "mark the redirect loop bug as done".
