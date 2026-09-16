# 15 — Use Cases

A use case is the layer between a cubit and a repository. It exists so that logic belonging to neither has somewhere to live.

This branch adds three of them, and only one turned out to have logic.
That is the lesson, not a shortfall.

## What went in, and what didn't

`GetRecipeListUseCase` owns the page size. A cubit asking for "the next page" should not be the thing deciding a page is ten recipes — that is a rule about reading recipes, not about drawing a list. It moved out of `RecipesListCubit`.

`SearchRecipesUseCase` and `GetRecipeDetailsUseCase` own nothing. Both forward a call and return its `Result` unchanged.

Two things were considered for the list use case and rejected:

- **The sort mapping.** `RecipeSort` already carries its own `queryValue`
  (`rating`, `reviewCount`). Moving that into a use case would mean
  replacing a self-describing enum with a `switch` — undoing something
  that already works.
- **`order: 'desc'`.** That is not a business rule, it is how DummyJSON spells "highest first". It belongs in the data layer, next to the rest of the query.

Search briefly got a rule of its own — refuse an empty query — and it came back out. The cubit never sends one: an empty box is no search at all, so nothing is asked for. Guarding a call that cannot happen meant inventing an empty page to return, and a value with no meaning is the tell that a rule is in the wrong place.

## So why keep the empty ones

Because the layer is optional, and it is the choice that matters here.

Once the seam exists, a cubit depends on one small callable instead of a repository with three methods — a test fakes the call it uses and nothing else. And when a rule does appear, it has an obvious home. Adding the layer later means touching every cubit again.

The alternative is just as defensible: skip the pass-throughs, add a use case the day there is something for it to do. This repo keeps all three so the shape is consistent, and says plainly that two of them are style.

Inventing work to justify a file is the failure mode. An honest
pass-through is not.

## Still not solved

Every page now builds a repository, wraps it in a use case, and hands that to a cubit — one more link in a chain still wired by hand.
