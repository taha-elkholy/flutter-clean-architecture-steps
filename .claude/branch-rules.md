# Branch Rules

These are hard constraints, not suggestions. Without them, it's very easy
to "helpfully" fix five things at once and destroy the point of the repo,
which is that each branch teaches exactly one lesson.

## Before making any change

1. Read the current branch's `docs/<branch-name>.md` file. That file is
   the scope. If a change isn't described there, it doesn't belong in
   this branch.
2. Check `.claude/project-context.md` for what this project is, how the
   branch model works, and the principles behind it. It describes the
   journey, not where it currently stands.
3. If you need the full list of problems this journey started from, read
   `docs/00-initial-dirty-state.md`. Anything still on that list and not
   in the current branch's docs file is deliberately unsolved for now.

## Hard constraints

- **Touch only what the branch's problem requires.** If the branch is
  about theming, don't also add error handling, even if you notice it's
  missing. Note it if asked, but don't fix it silently.
- **Don't introduce a future branch's solution early.** If a package or
  pattern that belongs to a later branch would also solve something here,
  mention it instead of pulling it forward.
- **Don't rename, move, or restructure files outside the current
  branch's stated scope**, even if the reorganization seems clearly
  better. Ask first.
- **Never commit directly to `main`.** All work happens on a numbered
  branch and merges through a PR.
- **A correct fix is still out of scope if it wasn't asked for.** Being
  right about something (a deprecated API, a better default) doesn't make
  it this branch's job. `withOpacity` → `withValues` is a theming decision
  once colors are centralized — not something to slip in during a pure
  file-move branch, even though the replacement is technically correct.
- **Don't change visible behaviour while restructuring.** Most branches
  move code around rather than change what the user sees. If a refactor
  would alter the UI, the loading behaviour, or the number of network
  calls, say so before doing it.
- **Every branch ships with its own `docs/<branch-name>.md`.** If a
  change doesn't have a matching docs entry describing the problem and
  the fix, the branch isn't done yet.
- **When in doubt about scope, ask** instead of assuming a broader
  refactor is welcome.