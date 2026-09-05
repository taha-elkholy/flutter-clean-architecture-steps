# 05 — Localization

## Problem

Every user-facing string was hardcoded inside the widget that drew it.
Strings were scattered across files with no single place to find them,
the same wording could drift apart between screens, and supporting a
second language would mean editing every file in the app.

## What changed

All user-facing strings now live in `lib/l10n/intl_en.arb` and are read
through the generated `S` class:

- Keys are ordered the way the app is used — list page, then its
  widgets, then search, then details — and each one carries a
  `description` for context.
- Widgets look their strings up themselves, with
  `final strings = S.of(context);` once at the top of `build`.
  `S.current` is used only where there is no `BuildContext`.
- Lines that mix text and data are single keys with placeholders, not
  strings glued together in Dart, so word order and separators stay part
  of the translation.

## Generated code and the linter

The generated `S` class lives in `lib/generated/`, and the analyzer
flagged it heavily — `intl` imports, missing type annotations, lint
rules the generator doesn't follow. None of that is fixable by hand,
since the whole folder is rewritten on every build.

So `lib/generated/**` is excluded in `analysis_options.yaml`, and stays
excluded for anything generated later. The one real finding was kept:
`intl` was being used through `flutter_localizations` instead of being
declared, so it's now a direct dependency.

## Why there is no second language

The DummyJSON Recipes API only returns English. Translating the app's
own strings would leave every recipe on screen in English anyway, and a
half-translated screen is worse than an honestly English one.

Localization is still here because hardcoded strings are a structural
problem on their own. Centralizing them now means adding a language
later is one new ARB file and nothing else.

## Resource

- [Flutter Intl (VS Code extension)](https://marketplace.visualstudio.com/items?itemName=localizely.flutter-intl) —
  used instead of plain `flutter gen-l10n`. It watches the ARB files and
  regenerates `lib/generated/` on save.
