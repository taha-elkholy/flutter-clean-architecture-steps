# 01 — Stricter Analysis

The project used Flutter's default lint rules, which are loose by design
so they're safe for any project. That's the wrong default for a codebase
about to be restructured — loose rules let problems drift instead of
surfacing them.

## What changed

Switched to a stricter, well-known rule set
([`very_good_analysis`](https://pub.dev/packages/very_good_analysis)).

What it flagged split in two. The mechanical findings got fixed right
away. The rest were pointing at problems a later branch is meant to
solve, so those rules are disabled for now — `analysis_options.yaml`
says which, and why.
