# 02 — Split Pages and Widgets

## Problem

Every screen, every widget, and the theme all lived in one `main.dart`.
Touching any single part meant scrolling through all of it, and every
future branch would have kept editing the same giant file.

## What changed

No architecture was introduced here. This is a filing exercise, not a
design decision — the code moved, none of the logic did.

Each page and each widget got its own file, grouped into `pages/` and
`widgets/`, with the theme pulled out on its own too. `main.dart` now
only wires the app together.

This just makes it possible to work on one piece at a time going
forward, and makes it obvious what a given file is responsible for.

## Resources

- [Effective Dart: file and library organization](https://dart.dev/effective-dart/usage#imports)