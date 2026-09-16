# 14 — Clean Architecture Structure

Thirteen branches built the pieces of a layered app. They were all filed
by what kind of Dart file they were — `entities/`, `models/`, `cubits/`,
`widgets/`. Open `lib/` and you learned the language, not the app.

That filing also hid the layers already there. `RecipesRepository` and
`RecipesRepositoryImpl` sat side by side in `repositories/`, one an
interface naming no dependency and one parsing JSON from Dio — the most
important boundary in the app, with nothing in the tree saying so.

## The two questions

Every file was asked two things, in order. **Shared, or owned by one
feature?** Shared goes to `core/`. **If it's a feature's, which layer?**

```
lib/
├── core/            # anything a second feature would use unchanged
│   ├── base/        # BaseCubit
│   ├── error/       # AppException, Failure, mapAppException
│   ├── result/      # Result
│   ├── network/     # ApiClient + interceptors
│   ├── router/      # AppRouter, AppRoutes
│   ├── style/       # AppTheme
│   ├── extensions/  # BuildContext extensions
│   ├── helpers/     # logging, toasts
│   └── widgets/     # LoadingDots, NetworkImageWithShimmer, EmptyView
│
└── features/recipes/
    ├── domain/         # entities, params, RecipesRepository (abstract)
    ├── data/           # models, mappers, RecipesRepositoryImpl
    └── presentation/   # cubits, pages, recipe widgets
```

There is one feature, and that is enough — the split is about where the
next one goes, not how many exist today.

## The calls worth explaining

`SortTabs` looked shared and is not: it takes a `RecipeSort`. A widget
that names a domain type belongs to that domain. Same test kept
`RecipesErrorView` in the feature.

`Result` got its own folder instead of joining `error/`. It is not an
error type — it wraps success and failure together, and `Success` is half
of it. It still imports `Failure`, since its error branch is typed rather
than generic; making it `Result<T, E>` would cut that link, but that
changes the type, not where the file lives.

`lib/l10n` and `lib/generated` stayed put: `flutter_intl` regenerates
them from fixed default paths.

The dependency direction is now readable in the imports themselves.
`data` and `presentation` both import `domain`; `domain` imports neither,
pulling in only Equatable and `Result`.

## The one place core points the wrong way

`AppRouter` lives in `core/router/` and imports three recipe pages by
name. That is backwards — core is meant to be what a second feature takes
unchanged, and this file would need editing to add one.

Left alone on purpose. Fixing it means changing how routes are registered,
which is a design decision, not a file move. Named here so it reads as
known debt rather than an oversight.

## Nothing else changed

Every commit is a move plus the import lines that follow it. `dart fix`
re-sorted the import blocks because the paths shifted under them. No
logic, no signature, no widget, no network call.

## Still not solved

`domain/` has no `usecases/` and `data/` has no `datasources/`, because
there is no code for them yet — a cubit still calls the repository
directly, and `RecipesRepositoryImpl` still hands query parameters
straight to `ApiClient`. Both folders arrive when the code that fills them
does. An empty folder teaches nothing.

Every page still wires its own dependencies by hand.
