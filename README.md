<h1 align="center">Flutter Clean Architecture Steps</h1>

<p align="center">
  A working Flutter app refactored from a messy single file into full Clean Architecture —<br/>
  one problem, one branch, one lesson at a time.
</p>

<p align="center">
  <img src="https://img.shields.io/badge/Flutter-3.x-02569B?logo=flutter&logoColor=white" alt="Flutter"/>
  <img src="https://img.shields.io/badge/Dart-3.x-0175C2?logo=dart&logoColor=white" alt="Dart"/>
  <img src="https://img.shields.io/badge/platforms-iOS%20%7C%20Android-lightgrey" alt="Platforms"/>
  <img src="https://img.shields.io/badge/license-MIT-green" alt="License"/>
</p>

<p align="center">
  <img src="screenshots/demo.gif" width="280" alt="App demo"/>
</p>

---

## The idea

Most Clean Architecture repos start clean. You get the finished folder
structure, a diagram, and no idea which real problem any of it solves.

This one starts messy on purpose — a genuinely working recipes app with
pagination, search, sorting, skeleton loading and pull-to-refresh, all
crammed into a single `main.dart` with hardcoded colors and zero error
handling. The kind of code a real deadline produces.

Then each branch fixes exactly one thing, and explains why.

**Almost none of it is visible to the user.** Nineteen branches in, the
screens look the same as they did on day one — that's the point:
architecture isn't what the user sees, it's what the next developer
inherits.

The exceptions are the few places where structure buys real behavior, and
each one is named in its own branch's write-up: the app now answers from a
local cache when the network is gone, keeps both sort tabs alive instead of
rebuilding them, searches as you type instead of on submit, caches recipe
images to disk, and tells you *what* failed instead of "Something went
wrong".

## How to use this repo

**Want the finished app?** You're on it — `main` always holds the latest
merged state.

**Want to learn from it?** Walk the branches in order:

```bash
git clone https://github.com/taha-elkholy/flutter-clean-architecture-steps.git
cd flutter-clean-architecture-steps
flutter pub get

# start at the beginning
git checkout 00-initial-dirty-state
```

Then for each branch:

1. Read `docs/<branch-name>.md` — what's wrong, why it matters, how it
   gets fixed, and where to read more.
2. Try fixing it yourself before looking at the diff.
3. Compare against the branch, then move to the next number.

Every branch carries the docs for itself and everything before it, so
whatever branch you're on, the folder reads as the story so far.

| Where | What you'll find |
|---|---|
| `main` | Latest state of the app |
| `00-initial-dirty-state` | The original messy version, frozen forever |
| `docs/` | One markdown file per step, with resources |

## The steps

Each row is a branch and a `docs/` file. Read them in order — every one
picks up a problem the one before it left behind.

| # | Branch | The problem it solves |
|---|---|---|
| 00 | `initial-dirty-state` | The starting point: one file, no structure |
| 01 | `very-good-analysis` | Default lints are too loose to catch drift |
| 02 | `split-pages-and-widgets` | Every screen and widget in one `main.dart` |
| 03 | `widget-classes-not-builders` | A function returning a `Widget` isn't a widget |
| 04 | `theming` | Hardcoded colors and inline `TextStyle`s everywhere |
| 05 | `localization` | User-facing strings buried in the widgets that draw them |
| 06 | `router` | `Navigator.push` building destinations by hand |
| 07 | `context-extensions` | Every widget naming the machinery before the value |
| 08 | `state-management-cubit` | Screens owning their own data and loose booleans |
| 09 | `cubit-enhancements` | `emit` after close, lost scroll, search on submit |
| 10 | `dio-interceptors` | The cubit owns the request, and `http` has no hooks |
| 11 | `exceptions-and-failures` | Every error says the same thing |
| 12 | `models-entities-and-repository` | Untyped maps and magic string keys |
| 13 | `result-pattern` | Nothing in the signature says the call can fail |
| 14 | `clean-architecture-structure` | Filed by file type, so the layers are invisible |
| 15 | `use-cases` | Business rules living inside cubits |
| 16 | `data-sources-and-caching` | One class doing three jobs, and no offline story |
| 17 | `dependency-injection-getit` | Every page building six constructors deep |
| 18 | `dependency-injection-injectable` | The container repeating what constructors already say |
| 19 | `review-and-cleanup` | A pass back over all of it |

## Tech stack

Where it ends up, and which branch introduces each piece:

| Layer | What's used |
|---|---|
| **Architecture** | Clean Architecture — `data` / `domain` / `presentation` per feature, shared code in `core/` (14) |
| **State** | `flutter_bloc` Cubits over sealed states, `rxdart` for the search stream (08, 09) |
| **Networking** | `dio` with connectivity and logging interceptors (10) |
| **Error handling** | Sealed `AppException` → `Failure`, returned as a sealed `Result<T>` (11, 13) |
| **Local cache** | `drift` over SQLite, plus `cached_network_image` for photos (16) |
| **DI** | `get_it` + `injectable` code generation (17, 18) |
| **UI** | Material 3 `ColorScheme` / `TextTheme`, `skeletonizer` loading (04) |
| **Strings** | `intl` ARB files through a generated `S` class (05) |
| **Lints** | `very_good_analysis` (01) |

## The app

A recipes browser built on the free [DummyJSON Recipes API](https://dummyjson.com/docs/recipes)
— no API key, no signup, clone and run.

- Paginated grid with `limit` / `skip`
- Sorting toggle (Top Rated / Most Reviewed), both tabs kept alive
- Search as you type, debounced, with stale responses cancelled
- Details screen
- Skeleton loading and pull-to-refresh
- Reads from a local cache when the network is unreachable

The list intentionally requests a lightweight payload, so the details
screen genuinely needs its own call — which makes the caching and data
layer lessons real instead of theoretical.

## Getting started

Built and verified on **Flutter 3.47.2** (stable, Dart SDK `^3.12.0`).
Anything newer on stable should work; older SDKs won't, because the code
uses recent language features.

```bash
flutter --version          # expect 3.47.2 or newer on stable
flutter pub get
flutter run
```

No API key, no `.env`, no backend to start — the app talks to a public
endpoint and runs as soon as it builds. iOS and Android both.

**If you fork it**, that's everything. Nothing else is configured.

Two things in `lib/` are generated and already committed, so a clone runs
without a build step. You only need to regenerate after changing their
sources:

| If you change | Run |
|---|---|
| `@injectable` annotations, or drift tables | `dart run build_runner build --delete-conflicting-outputs` |
| `lib/l10n/intl_en.arb` | The [Flutter Intl](https://marketplace.visualstudio.com/items?itemName=localizely.flutter-intl) extension regenerates on save |

## License

MIT — use it, fork it, teach with it.

---

<p align="center">
  Built by <a href="https://github.com/taha-elkholy">Taha Elkholy</a> ·
  <a href="https://www.linkedin.com/in/taha-elkholy/">LinkedIn</a>
</p>