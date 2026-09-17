import 'package:flutter/material.dart';
import 'package:flutter_clean_architecture_steps/core/router/app_routes.dart';
import 'package:flutter_clean_architecture_steps/core/router/route_not_found_page.dart';
import 'package:flutter_clean_architecture_steps/features/recipes/presentation/pages/recipe_details_page.dart';
import 'package:flutter_clean_architecture_steps/features/recipes/presentation/pages/recipe_list_page.dart';
import 'package:flutter_clean_architecture_steps/features/recipes/presentation/pages/search_recipe_page.dart';

/// Screens push names, never widgets, so no page needs to import another page
/// to navigate to it.
abstract final class AppRouter {
  /// Unknown names — and known names given the wrong arguments — fall through
  /// to [RouteNotFoundPage] rather than throwing.
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
