/// Every route name in the app, in one place.
///
/// Screens never spell a route name as a string literal — they refer to a
/// constant here, so a rename is a single edit and a typo is a compile error
/// instead of a crash at runtime.
abstract final class AppRoutes {
  /// Recipe list. The app's initial route.
  static const String recipeList = '/';

  /// Recipe search.
  static const String searchRecipe = '/search';

  /// Recipe details. Expects the recipe id as an `int` argument.
  static const String recipeDetails = '/recipe-details';
}
