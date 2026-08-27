# 04 — Theming

## Problem

Colors and text styles were hardcoded inside the pages and widgets
themselves. The same raw `Color(0xFF...)` appeared over a dozen times,
inline `TextStyle`s were written out on every `Text`, and each `AppBar`
repeated its own `backgroundColor` and `elevation`.

That makes two things painful. Changing a single color means hunting it
down in every file that happens to use it. And reusing a style means
copying and pasting it, so the "same" style slowly drifts apart across
screens. A second theme — a dark one, say — isn't even possible without
editing every widget in the app.

## What changed

The app now has a real theme, in `lib/style/app_theme.dart`:

- A `ColorScheme` holding every color the app draws with.
- A `TextTheme` holding every text style.
- A component theme (`AppBarTheme`) for the styling that should be
  constant everywhere that component appears.

Pages and widgets read what they need through `Theme.of(context)`, so
there are no color or `TextStyle` literals left in `lib/pages` or
`lib/widgets`.

This is what a theme is actually for. Adding a dark theme later means
adding a second `ThemeData` with its own `ColorScheme` — no widget
changes. And the first time a new component is used, such as a `Card` or
a `ListTile`, its theme goes here once and applies to every place that
widget is used.
