/// Screens never spell a route name as a string literal, so a typo is a
/// compile error instead of a crash at runtime.
abstract final class AppRoutes {
  /// The app's initial route.
  static const String recipeList = '/';

  static const String searchRecipe = '/search';

  /// Expects the recipe id as an `int` argument.
  static const String recipeDetails = '/recipe-details';
}
