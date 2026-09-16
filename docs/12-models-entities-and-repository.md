# 12 — Models, Entities and Repository

The cubits called `ApiClient` themselves and read an untyped `Map`. A
typo in `recipe['nmae']` compiled, shipped, and failed on screen.

## Two types for one recipe

`RecipeModel` is the server's shape: every field nullable, `fromMap` and
`toMap`, no opinion about missing data. `RecipeEntity` is the app's
shape: nothing nullable, Equatable, safe to read without asking. The list
and details endpoints return different records, so each gets its own pair.

A `toEntity()` extension on each model turns null into the empty value of
its own type — `0`, `''`, `const []`. One place decides what a missing
field means, so no screen has to.

## The repository

`RecipesRepository` is abstract: three questions, said without naming
Dio, a url, or a json map. `RecipesRepositoryImpl` answers them with the
`ApiClient` it is handed, owning the paths, the query parameters and the
parsing. Both live in `repositories/` — there is no `data/` or `domain/`
split yet.

`getRecipes` takes a `GetRecipesParams` — the rule for any call whose
parameters span more than one type.

## Equality came back

The states hold entities, so `props` compares the recipes themselves.
Comparing `recipes.length` was a workaround for maps having no equality,
and it was wrong: a refresh returning ten different recipes never redrew.

## The wiring got worse on purpose

A cubit takes a repository, so it no longer builds or closes a client.
Each page builds an `ApiClient`, wraps it in a `RecipesRepositoryImpl`,
hands that to the cubit, and closes the client in `dispose` — which made
two stateless pages stateful for no other reason.

Three pages, three clients, three near-identical `create` blocks — the
dependency injection branch's problem, made visible here first.

`strict-casts` and `avoid_dynamic_calls` are back on in
`analysis_options.yaml`, off since the first branch.

## Still not solved

The repository calls `ApiClient` directly, with no data source between
them. Every page wires its own dependencies by hand.
