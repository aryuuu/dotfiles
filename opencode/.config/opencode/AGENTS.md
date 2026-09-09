# Global Agent Instructions

## Version Control
- Use `jj` when `.jj/` exists in the project root. Default to `git` otherwise.
- Check for `justfile` or `Makefile` before inventing build commands.
- Never commit unless explicitly asked.

## Tool Preferences
- Prefer dedicated tools (Read, Edit, Grep, Glob) over bash equivalents (cat, sed, grep, find).
- Use `rg` (ripgrep) over `grep` when shell search is needed.
- Check existing linter/formatter config before suggesting new ones.

## Code Style
- Match existing project conventions — don't impose new patterns.
- Prefer explicit error handling over silent failures.
- No `console.log` / `print` debugging left in committed code.
- No type error suppression (`as any`, `@ts-ignore`, `# type: ignore`).

## Interaction
- Ask before creating new files if the target directory is ambiguous.
- Summarize what changed, not what you planned to do.
- Fix minimally when debugging — don't refactor while fixing bugs.
