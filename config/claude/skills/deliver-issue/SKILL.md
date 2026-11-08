---
name: deliver-issue
description: Use when given a GitHub issue number to implement and deliver as a pull request.
---

# Delivering an Issue

## Overview

Take a GitHub issue from its number to a reviewed PR that is lint clean and
expected to pass CI. Everything published (code comments, commit messages, the
PR) describes the change as it stands, not the session that produced it.

There are two gates. Stop and wait for the user's approval before splitting an
issue, and before publishing the PR. Earlier approval does not carry over to a
later gate.

## Steps

1. **Read.** Run `gh issue view <N> --comments`. Take the lint, test and CI
   commands from the project's `CLAUDE.md` or `AGENTS.md`. If neither
   documents them, ask.

2. **Size.** Judge whether the issue fits in one session. If it does not,
   propose sub-issues that each fit in one session, with the dependencies
   between them. **Stop and wait for approval.** Once approved, create them,
   link them, and stop. Each sub-issue is delivered in its own session.

   ```bash
   # Prints the new issue's number and id; the linking API takes ids.
   gh api repos/{owner}/{repo}/issues -f title="..." \
     -f body="Part of #<N>. Depends on #<M>. ..." --jq '"\(.number) \(.id)"'
   gh api repos/{owner}/{repo}/issues/<N>/sub_issues -F sub_issue_id=<child id>
   gh api repos/{owner}/{repo}/issues/<child>/dependencies/blocked_by -F issue_id=<blocker id>
   ```

   If linking fails, the `Part of`/`Depends on` lines still record the
   structure.

3. **Branch** off the default branch.

4. **Implement in incremental commits.** Commit each self-contained step once
   its tests pass. Use the relevant skills: superpowers:writing-plans for
   multi-step work, superpowers:test-driven-development, and
   superpowers:systematic-debugging when something fails. Before each commit,
   read `git diff --cached` and check its comments against the user's rules.

5. **Clean up and verify.** Invoke the `simplify` skill, then `code-review`,
   and fix the findings in commits of their own. Then follow
   superpowers:verification-before-completion with the commands from step 1.
   Their output is the PR's evidence.

6. **Draft the PR.** Use a short imperative title. The body has exactly these
   parts:

   ```markdown
   <What the change does and why, in a few sentences, readable by someone
   who has seen neither the issue nor the branch.>

   ## Evidence

   <Commands run and their results; before/after behaviour.>

   ## Risk

   <Only if other components are affected: which, and how.>

   Closes #<N>
   ```

   Work the PR leaves undone goes into a new issue, not the body. Offer to
   create one at the gate.

7. **Gate.** Show the title, the body and `git log --oneline` for the branch.
   **Stop and wait for approval.**

8. **Publish** here rather than through
   superpowers:finishing-a-development-branch. Run `git push -u origin HEAD`,
   then `gh pr create --title "..." --body-file <file>`. If `gh` is
   unavailable, print the title and body for the user to paste.

9. **Hand off.** Wait with `gh pr checks --watch >/dev/null`, then read the
   result once with `gh pr checks`. If no checks are reported but the repo has
   CI workflows, they have not started yet, so retry shortly. Fix any failures
   in new commits, and use `gh pr edit` if a fix changes what the body says.
   Report the PR URL and the check status.
