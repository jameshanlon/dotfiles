---
description: Manage a project's task backlog stored as one markdown file per task. Use when the user wants to add, list, prioritize, update, complete, or search backlog tasks, or asks what to work on next.
---

# Backlog skill

Tasks live in `.claude/backlog/tasks/` at the root of the current repo, one markdown file per task. This directory is per-project (git-tracked alongside the code), even though this plugin itself is installed globally and works the same way in every repo.

## File naming

`<id>-<slug>.md`, e.g. `0007-fix-auth-redirect-loop.md`.

- `id` is a zero-padded 4-digit number, monotonically increasing. To pick the next id, list existing files in `.claude/backlog/tasks/`, take the highest numeric prefix, and increment. If the directory doesn't exist yet, create it and start at `0001`.
- `slug` is the title, lowercased, spaces to hyphens, stripped of punctuation.

## File format

Each task file is YAML frontmatter plus free-text notes:

```markdown
---
id: 0007
title: Fix auth redirect loop
status: open
priority: medium
tags: [bug, auth]
created: 2026-08-13
updated: 2026-08-13
---

Free-text notes, context, acceptance criteria, links. Optional.
```

Field rules:
- `status`: one of `open`, `in-progress`, `blocked`, `done`. Default `open` on creation.
- `priority`: one of `low`, `medium`, `high`. Default `medium` if the user doesn't specify.
- `tags`: a YAML list, may be empty (`[]`).
- `created`: set once, on file creation, `YYYY-MM-DD`.
- `updated`: bump to today's date any time any field or the notes body changes.

## Operations

**Add a task**: create a new file following the naming and format rules above. Ask the user for title at minimum; infer or ask for priority/tags only if it's ambiguous — don't interrogate for a simple add.

**List tasks**: read all files in `.claude/backlog/tasks/`, parse frontmatter, and present as a table grouped by `status` (open, in-progress, blocked, then done last or omitted unless asked). Sort within a group by priority (high → low).

**Update a task**: locate by id or by matching title text, edit the relevant frontmatter field(s), bump `updated`.

**Complete a task**: set `status: done`, bump `updated`.

**What's next**: pick the highest-priority `open` task (ties broken by lowest id / oldest), and say why it's next.

**Search**: grep tasks by tag, title, or notes content when the user asks about a topic.

Keep responses to backlog operations concise — a short confirmation or table, not a restatement of the whole file.
