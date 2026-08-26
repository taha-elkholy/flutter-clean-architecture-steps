# 01 — Stricter Analysis

## Problem

The project used Flutter's default lint rules, which are loose by design
so they're safe for any project. That's the wrong default for a codebase
about to be restructured — loose rules let problems drift instead of
surfacing them.

## What changed

Switched to a stricter, well-known rule set
([`very_good_analysis`](https://pub.dev/packages/very_good_analysis)).

Some of what it flagged got fixed right away — mechanical issues with no
design implications. Some got intentionally left disabled for now, because
they're really pointing at problems a later branch is meant to solve, not
something to patch around here. See `analysis_options.yaml` for exactly
what's disabled and why.

## Resources

- [`very_good_analysis` on pub.dev](https://pub.dev/packages/very_good_analysis)
- [Customizing static analysis — Dart docs](https://dart.dev/tools/analysis)
- [Dart linter rules](https://dart.dev/tools/linter-rules)