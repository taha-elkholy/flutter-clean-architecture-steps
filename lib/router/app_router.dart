import 'package:flutter/material.dart';
import 'package:flutter_clean_architecture_steps/pages/recipe_details_page.dart';
import 'package:flutter_clean_architecture_steps/pages/recipe_list_page.dart';
import 'package:flutter_clean_architecture_steps/pages/search_recipe_page.dart';
import 'package:flutter_clean_architecture_steps/router/app_routes.dart';
import 'package:flutter_clean_architecture_steps/router/route_not_found_page.dart';

/// The single place that turns a route name into a screen.
///
/// Screens push names, never widgets, so no page needs to import another page
/// to navigate to it, and the whole navigation map of the app is readable in
/// one file.
abstract final class AppRouter {
  /// Wired into `MaterialApp.onGenerateRoute`.
  ///
  /// Unknown names — and known names given the wrong arguments — fall through
  /// to [RouteNotFoundPage] at the bottom rather than throwing.
  static Route<dynamic> onGenerateRoute(RouteSettings settings) {
    switch (settings.name) {
      case AppRoutes.recipeList:
        return MaterialPageRoute<void>(
          builder: (context) => const RecipeListPage(),
          settings: settings,
        );

      case AppRoutes.searchRecipe:
        return MaterialPageRoute<void>(
          builder: (context) => const SearchRecipePage(),
          settings: settings,
        );

      case AppRoutes.recipeDetails:
        final recipeId = settings.arguments;
        if (recipeId is! int) return _notFound(settings);
        return MaterialPageRoute<void>(
          builder: (context) => RecipeDetailsPage(recipeId: recipeId),
          settings: settings,
        );

      default:
        return _notFound(settings);
    }
  }

  static Route<dynamic> _notFound(RouteSettings settings) {
    return MaterialPageRoute<void>(
      builder: (context) => RouteNotFoundPage(routeName: settings.name ?? ''),
      settings: settings,
    );
  }
}
