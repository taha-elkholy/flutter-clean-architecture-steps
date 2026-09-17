# 17 — Dependency Injection with GetIt

Every page built its own dependencies — six constructors deep, to show a
list of recipes, and all three pages wrote the same six lines.

```dart
create: (_) => RecipesListCubit(
  GetRecipeListUseCase(
    RecipesRepositoryImpl(
      RecipesRemoteDataSourceImpl(client),
      RecipesLocalDataSourceImpl(CacheDatabase.instance),
    ),
  ),
),
```

That chain is the architecture of the app, written out in a widget. It
cost three HTTP clients, one per page; a `static` `CacheDatabase`,
because a second connection to the same file would not see the first
one's writes and nothing else could enforce one; and no seam at all,
since every page named `RecipesRepositoryImpl` directly — leaving the
abstract `RecipesRepository` from branch 12 a contract nobody depended
on.

## The fix

One container, registered in `lib/core/di/service_locator.dart` and
called before `runApp`. Pages ask for what they need —
`getIt<RecipesListCubit>()` — and registering against the abstract type
is what makes the seam real: `RecipesRepositoryImpl` is now named on one
line in the whole app.

Two pages stopped being `StatefulWidget`s, having been stateful only to
close the client they owned.

## Singleton or factory

Ownership decides, not cost. **Lazy singletons** for the connections,
where one `CacheDatabase` is correctness rather than thrift.
**Factories** for the cubits, since a screen closes the one it was given
and a shared cubit would be dead after the first pop. Use cases are
factories too, though singletons would work: one style per layer is
worth the object.

## Where close went

`ApiClient.close()` was deleted — not because nothing called it, but
because nobody owns the client now. It lives as long as the app, so
`close()` had no correct caller left, and a method with no correct
caller is a trap. Nothing accumulates either: Dio's adapter gives its
`HttpClient` a three-second `idleTimeout`, so idle connections close
themselves.

## Still not solved

Sixty hand-written lines saying what each class takes, which the
constructors already said. Next branch: `injectable` generates them.
