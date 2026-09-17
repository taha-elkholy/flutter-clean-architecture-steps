# 09 — Cubit Enhancements

Four problems branch 08 left behind, each one in how the cubits and the
screens meet.

## emit after close

A request outlives the page that started it, and `emit` on a closed
cubit throws. `BaseCubit` guards it once, and all three cubits extend
it:

```dart
@override
void emit(State state) {
  if (isClosed) return;
  super.emit(state);
}
```

## A tab is a widget

The page built only the selected tab, so switching rebuilt the other one
and lost its scroll position. Both now live in an `IndexedStack`.

`RecipesSortTab` takes a `RecipeSort` and owns everything belonging to
it: its scroll controller, its grid, its dots, the tap that opens a
recipe, and its own `fetchIfNeeded`. The page keeps the sort chips and
the index, reads nothing from the cubit, and so provides it and sits
above it at once — no separate view widget.

Both tabs build on the first frame, so the app opens with two requests
instead of one. That is what keeping them alive costs.

## Selecting instead of filtering by hand

`buildWhen` compared the whole slot, and `loadMoreFailed` is inside it,
so flipping that flag rebuilt the grid with the recipes it already had.
The switch needs the state, not just the recipes, so the selector
returns the state with the load-more flags dropped:

```dart
RecipesSortState get gridState => switch (this) {
  RecipesSortLoaded(:final recipes, :final skip, :final hasMore) =>
    RecipesSortLoaded(recipes: recipes, skip: skip, hasMore: hasMore),
  _ => this,
};
```

The dots select `isLoadingMore` straight. The toast stays a listener, so
the `BlocConsumer` splits into a `BlocListener` around a `BlocSelector`.

## Search as a stream

Search ran on submit. It now runs on every keystroke, which needs three
operators, and all three belong to the cubit:

```dart
Rx.merge<String>([
  _queries.debounceTime(_debounce).distinct(),
  _retries,
]).switchMap(_search).listen(emit);
```

`switchMap` cancels a request the moment a newer one arrives, so a slow
early result can never land after a later one — which also means
`_search` is a `Stream`, since a `Future` cannot be cancelled.

Retry enters past the debounce on its own subject: it repeats the same
query on purpose, which is what `distinct` would swallow. Both paths
meet in the same `switchMap`, so they cannot race.
