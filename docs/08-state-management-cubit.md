# 08 — State management with Cubit

## Problem

Every screen fetched its own data inside its own `State`, and described
what it was doing with loose booleans:

```dart
List<dynamic> results = [];
bool isLoading = false;
bool hasSearched = false;
```

The widget owns the data, so nothing outside it can read the data or test
the fetch. The booleans combine into four screens when only three are
real, and none of them can say the request failed.

## What changed

Three cubits — list, search, details — each created by the page that uses
it and disposed with it, and each `build` reduced to a builder over a
sealed state.

The boundary between cubits is lifetime, not the API they read. The three
screens appear and disappear at different times and never read each
other's results, so each one's data dies with its page and no cubit needs
a `clear` method.

## The states

Every state file is `sealed`, so adding a state breaks the build until
every screen handles it. Each arm of the switch is a ready-made widget
and its data; no widget is assembled inside a case.

The data lives in the states, never on the cubit: `RecipesSortLoaded`
holds the recipes, the `skip` and the `hasMore` flag, so the state
describes the screen on its own. Empty is a state too, not a length
check.

## The list state is composite

The list has two tabs reading two independent requests, so
`RecipesListState` holds a slot per sort, each slot a sealed state of its
own:

```dart
RecipesSortState sortOf(RecipeSort sort) => switch (sort) {
  RecipeSort.topRated => topRated,
  RecipeSort.mostReviewed => mostReviewed,
};
```

One tab loading or failing says nothing about the other, and a tab
already read is not fetched again. Search and details have one request
each, so they stay flat.

## A load-more failure is not an error state

The error arm replaces the whole body, which is right for a failed first
page and wrong for a failed second one. So a load-more failure travels as
a flag inside `RecipesSortLoaded`, beside the recipes still on screen,
and the page shows it from a `listener` gated on the transition:

```dart
listenWhen: (previous, current) =>
    !previous.sortOf(sortBy).loadMoreFailed &&
    current.sortOf(sortBy).loadMoreFailed,
```

Nothing clears the flag: the next `loadMore` clears it on its first emit.

## Not fixed here

Error states carry no reason, so `RecipesErrorView` shows one generic
message. A typed `Failure` is the error-handling branch's job; this
branch only makes the failure reach the screen.

`props` compares `recipes.length` and `identityHashCode(recipe)`, since
untyped maps have no equality of their own. Both go back to comparing the
recipe once it is an entity.

Branch 09: search runs on submit rather than debounced; both tabs build
eagerly instead of through an `IndexedStack`; `buildWhen` is doing a
`BlocSelector`'s job; and `emit` after `close` is unguarded.

## Resource

- [flutter_bloc — Cubit](https://bloclibrary.dev/bloc-concepts/#cubit) —
  why a cubit is the smaller half of bloc.
- [Dart — sealed classes](https://dart.dev/language/class-modifiers#sealed) —
  the compiler guarantee the state files are built on.
