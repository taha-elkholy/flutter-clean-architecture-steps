# 07 — Context Extensions

## Problem

Two lookups were written out by hand everywhere, and neither one carries
any meaning of its own:

```dart
final theme = Theme.of(context);
final strings = S.of(context);
Theme.of(context).colorScheme.surfaceContainerHighest
```

Branch 04 centralized the colors and 05 centralized the strings, but both
left the reading side untouched. Every widget still names the machinery
it goes through — `Theme.of`, the generated `S` — before it gets to the
value it actually wants.

## What changed

`BuildContext` now carries the lookups, so a widget asks for the value
and nothing else:

```dart
final theme = context.theme;
final strings = context.strings;
context.colorScheme.surfaceContainerHighest
```

`ThemeExtensions` exposes `theme`, `textTheme` and `colorScheme` — the
whole theme where a widget needs more than one part, the specific part
where it doesn't. `LocalizationExtensions` exposes `strings`.

Both live in `build_context_extensions.dart`, next to the navigation
helpers from branch 06. The file is one per receiver, not one per
feature: several small extensions on `BuildContext`, each grouped around
its own subject.

## Where the old form stays

`S.delegate` in `main.dart` and `S.current` in the grid card's
placeholder helper are untouched. Neither is a context lookup — the
delegate configures `MaterialApp` before any context exists, and the
placeholder is a plain data function with no context to read from.

## Why not earlier

Both shorthands could have shipped with the branch that created what they
read. They didn't, because the point there was moving the values into one
place — proving that worked meant leaving the call sites obvious first.
The convenience is a separate change, and reads as one.
