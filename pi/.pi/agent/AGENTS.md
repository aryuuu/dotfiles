# Global Agent Instructions

## Version Control
- Use `jj` when `.jj/` exists in the project root. Default to `git` otherwise.
- Check for `justfile` or `Makefile` before inventing build commands.
- Never commit unless explicitly asked.

## Tool Preferences
- Prefer the `edit` tool over bash `sed`/`awk` rewrites for file changes.
- Use `rg` (ripgrep) over `grep` when available.
- Read relevant local files first. Research online only if the answer isn't in the codebase.

## Code Style
- Match existing project conventions — don't impose new patterns.
- Prefer explicit error handling over silent failures.
- No `console.log` / `print` debugging left in committed code.
- No type error suppression (`as any`, `@ts-ignore`, `# type: ignore`).

## Interaction
- Explain risky edits and destructive commands before executing.
- Summarize what changed, not what you planned to do.
- Fix minimally when debugging — don't refactor while fixing bugs.
