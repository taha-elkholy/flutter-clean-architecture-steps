# 18 — Dependency Injection with Injectable

Branch 17 put every dependency in one container, and wrote out by hand
sixty lines of what each class takes:

```dart
..registerLazySingleton<RecipesRepository>(
  () => RecipesRepositoryImpl(getIt(), getIt()),
)
..registerFactory<RecipesListCubit>(() => RecipesListCubit(getIt()))
```

The constructors already said this. The locator repeated it, in an order
a human had to keep correct — registering a class before what it is
built from fails at runtime, not at compile time. Adding a use case
meant editing two files.

## The fix

Annotate the class; generate the rest.

```dart
@injectable
class RecipesListCubit extends BaseCubit<RecipesListState> { ... }

@LazySingleton(as: RecipesRepository)
class RecipesRepositoryImpl implements RecipesRepository { ... }
```

`@injectable` is a factory, `@lazySingleton` is one instance, and `as:`
registers the implementation under the abstract type — the same three
decisions as branch 17, now written where the class is.

`setupServiceLocator` drops to two lines, and
`dart run build_runner build` writes `service_locator.config.dart`,
working out the registration order rather than trusting it.

## What changed

Nothing the app can see: the generated file registers the same eleven
things the same way, and is worth diffing against branch 17's locator.
The cost is a build step before a new dependency exists, and a generated
file in the repo.
