# Project Context

## What this is

A personal, public Flutter (iOS + Android) project demonstrating a
progressive journey from an unstructured "dirty" app to a fully layered
Clean Architecture implementation. It's a teaching repo — anyone should be
able to fork it, walk the branches in order, and understand *why* each
architectural layer was introduced, not just copy the final result.

## Data source

[DummyJSON Recipes API](https://dummyjson.com/docs/recipes). No API key.
Endpoints in use: list with pagination (`limit`/`skip`), sorting
(`sortBy`/`order`, used for a "Top Rated" / "Most Reviewed" toggle instead
of a fabricated "trending" concept the API doesn't actually support),
search (`/recipes/search?q=`), and details by id (`/recipes/{id}`).

The list and search calls both pass `select=name,image,rating,cuisine,
difficulty`, so they return a deliberately lightweight model. The details
call returns the full recipe (ingredients, instructions, calories, timings).
This split is intentional: it makes the details fetch genuinely necessary,
and later justifies separate list-item and details models.

The API itself has no language or localization support, so any
localization in this app applies to UI strings only, never to recipe data.
English is the only supported language.

## Branch model

- `main` always reflects the current, most-progressed state of the app.
  It is never edited directly except for the very first commit (the dirty
  starting point). Every change after that happens on its own branch and
  merges into `main` through a PR.
- `00-initial-dirty-state` is a frozen snapshot of the original
  unstructured app. It never gets more commits — it exists purely as a
  permanent reference point, even after `main` has moved far past it.
- Every other branch is numbered sequentially (`01-...`, `02-...`, etc.)
  and named after the single problem it solves.
- Every branch has a matching `docs/<branch-name>.md` file describing the
  problem, the fix, and (optionally) a resource to study. A branch's docs
  folder only contains files for that branch and everything before it —
  never anything from branches that come later.

## Design principle

The app is deliberately good-looking at every stage, including the messy
ones. Visual polish is not what this repo teaches — the point is that a
nice-looking app can still be badly structured underneath. Never
"simplify" or degrade the UI to match the state of the architecture.

## Problems left unsolved on purpose

At any point in this journey there are known problems that have not been
fixed yet, because each one is the subject of its own upcoming branch.
They are not oversights and must not be silently fixed ahead of schedule.

To find out what is in scope right now, read the current branch's
`docs/<branch-name>.md` file. To see the full original list of problems
this journey started from, read `docs/00-initial-dirty-state.md`.

If something looks wrong but isn't described in the current branch's docs
file, assume it's intentional and raise it instead of fixing it.
