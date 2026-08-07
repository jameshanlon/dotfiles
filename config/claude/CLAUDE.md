# CLAUDE.md

Global rules for Claude Code, applied across all projects.

## Comments

- Keep comments short and concise.
- Do not add commentary about the process of development (what changed, why it
  was changed, what it replaced).
- Prefer high-level explanations of intent over restating the code or naming
  specific identifiers and structure.
- Always document public API functions, methods and classes with an appropriate
  docstring or Doxygen comment.
- In Python, put the `"""` delimiters of a docstring on their own lines.

## Code

- Prefer relative paths over `$PWD` or absolute paths, so that scripts and
  permission rules stay portable.
- Do not add fragile tests, such as those that duplicate constant values from
  the code under test.

## Commits

- Keep commit messages short, concise and self-contained.
- Do not include commentary about the development process, or cross-references
  to prototype or throwaway code.
- Do not add `Co-authored-by:` trailers or any other signature.
- Do not commit planning or review documents unless asked to.

## Workflow

- Once a change is complete, review the patch in detail for opportunities to
  simplify: run `/simplify`, then `/code-review`.

## Output

- Format code snippets, identifiers, file names and commands as monospace.
