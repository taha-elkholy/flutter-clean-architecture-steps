# 00 — Initial Dirty State

## What this is

A working Flutter app (iOS + Android) that lists, sorts, searches, and shows
details for recipes from the [DummyJSON Recipes API](https://dummyjson.com/docs/recipes).
No API key is required.

The app genuinely works end to end — pagination, search, a sort toggle,
pull-to-refresh, skeleton loading, and a custom loading animation. The point
of this branch isn't that it's broken. It's that it's **unstructured**:
everything lives in one file, with the kind of shortcuts a real project takes
under time pressure.

This is the "before" picture for the rest of the journey. It stays frozen
here forever, so you can always come back and compare.

## Known problems in this state

- **Single file, no separation.** Every screen, every widget, and every
  network call lives in `main.dart`. There's no folder structure at all.
- **No Model classes.** API responses are handled as `dynamic` Maps with
  magic string keys (`recipe['name']`, `recipe['image']`, ...). Nothing is
  type-safe, and a mistyped key silently returns `null` at runtime instead
  of failing to compile.
- **No repository or data layer.** `http.get()` calls sit directly inside
  `State` classes (`HomePage`, `SearchPage`, `DetailsPage`), so networking
  and UI are fused together.
- **No error handling at all.** A failed request or a dropped connection
  throws an unhandled exception. There's no retry, no error state, no
  empty state.
- **Duplicated fetch logic.** The list, pagination, refresh, and search all
  build nearly identical URLs and parse nearly identical responses, in four
  separate places.
- **Hardcoded, duplicated styling.** The same raw colors appear over a
  dozen times across three classes. Spacing and text styles are inline
  everywhere. Only the scaffold background is set on `ThemeData`.
- **No localization setup.** Every visible string is hardcoded in English
  inside the widgets.
- **`http` instead of `Dio`.** No interceptors, no central logging, no
  timeout configuration.
- **Default lint rules only.** `flutter_lints` out of the box, nothing
  stricter.
- **`Image.network` with no caching.** Images are re-fetched instead of
  being cached to disk.
- **Search only fires on submit.** Typing does nothing until you hit enter,
  because search-as-you-type needs debouncing first.
- **The details screen hides everything behind a loader.** The list
  deliberately requests a lightweight payload
  (`select=name,image,rating,cuisine,difficulty`), so fetching the full
  recipe by id is genuinely necessary — but the fields already in hand
  could be shown instantly instead of waiting on the whole response.
- **`withOpacity` is used** even though it's deprecated in current Flutter.

Each of these becomes the subject of a later, focused branch — one problem
at a time, never several at once.

## What is deliberately *not* a problem

The app looks good, and that's on purpose. A polished UI on top of
unstructured code is exactly the situation this repo is about: the user
can't see architecture, so it's the first thing to get skipped and the
last thing anyone notices is missing.

None of the later branches change how the app looks.

## Worth reading before branch 01

[Architecting Flutter apps — official Flutter docs](https://docs.flutter.dev/app-architecture)

Read it now, while the code in front of you has none of it. The guide makes
much more sense when you can point at a concrete file and see exactly what
it's warning you about.
