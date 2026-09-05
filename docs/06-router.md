# 06 — Router

## Problem

Every jump between screens was a `Navigator.push` building the
destination widget by hand:

```dart
Navigator.push(
  context,
  MaterialPageRoute<void>(
    builder: (context) => RecipeDetailsPage(recipeId: recipe['id']),
  ),
);
```

That shape means every screen imports the screens it opens, nothing
anywhere lists what screens exist, and a destination that doesn't
resolve has no fallback.

## What changed

`AppRoutes` holds the route names as constants, so a rename is one edit
and a typo is a compile error. `AppRouter.onGenerateRoute` is the single
switch from name to screen. `home:` is gone — the app starts at
`initialRoute`, so the first screen goes through the same path as the
rest.

Arguments are checked in the router, not at the call site, and a bad one
falls through instead of building a broken page:

```dart
case AppRoutes.recipeDetails:
  final recipeId = settings.arguments;
  if (recipeId is! int) return _notFound(settings);
```

At the bottom of the switch, `default` returns `RouteNotFoundPage` — a
real Scaffold naming the failed route, instead of a thrown route error.

## The context extension

`context.push(AppRoutes.recipeDetails, arguments: recipe['id'])` keeps
the call site down to the intent. It holds `push` and `pop` only — the
two operations this app performs.

The file is named for the receiver, `BuildContext`, because later
branches will hang more conveniences off it. Navigation is the first
section, not the whole file.

## Not fixed here

Route arguments are still `Object?` cast in the router — as type-safe as
`onGenerateRoute` gets on its own. Typed argument objects belong with the
models branch, where the recipe stops being a `dynamic` map.

## Resource

- [`onGenerateRoute` API docs](https://api.flutter.dev/flutter/material/MaterialApp/onGenerateRoute.html) —
  why it's preferred over the `routes:` map once routes take arguments.
