# 13 — Result Pattern

`getRecipes` returned a `RecipesPageEntity`. Nothing in that signature
said the call could fail, so nothing forced a caller to handle it.

## A type with two cases

`Result<T>` is sealed over `Success` and `Error`. `fold` takes both
branches and the compiler checks that neither is missing, so the data
cannot be read without saying what happens when there is none. It
returns `R` rather than `void`, so the same method serves a caller that
wants a state back and one that only emits.

## The catch moved down

`_read` in the repository is now the only `catch` between Dio and the
screen: it maps the exception to a `Failure` and returns it as a value.

`mapFailure(mapAppException(error))` used to appear in seven `try/catch`
blocks across three cubits. It lives in one place now, and
`AppException` never leaves the repository.

## What the cubits look like

Each call site folds instead of catching. `onSuccess` builds the loaded
state, `onError` takes a `Failure` already phrased for the screen.

`refresh` and `loadMore` keep the recipes on screen when they fail, so
`_loadedOrEmpty` is split out of `_firstPage` — refresh reuses the
success mapping without the error branch that would replace the list.

## Still not solved

The repository calls `ApiClient` directly, with no data source between
them. Every page still wires its own dependencies by hand.
