import 'package:flutter/material.dart';
import 'package:flutter_clean_architecture_steps/entities/recipe_entity.dart';
import 'package:flutter_clean_architecture_steps/widgets/recipe_grid_card.dart';
import 'package:skeletonizer/skeletonizer.dart';

/// The recipe grid, used by both the list page and the search page.
///
/// The skeleton is the same grid built from fake recipes, so the placeholder
/// keeps the exact shape of the content it stands in for.
class RecipesGrid extends StatelessWidget {
  const RecipesGrid({
    required this.recipes,
    required this.onRecipeTap,
    this.isLoading = false,
    this.scrollController,
    super.key,
  });

  final List<RecipeEntity> recipes;
  final void Function(RecipeEntity recipe) onRecipeTap;

  /// While true the grid shows skeleton cards, ignores [recipes], and stops
  /// responding to taps.
  final bool isLoading;

  /// Drives pagination on the list page; the search page has none.
  final ScrollController? scrollController;

  static const _placeholderCount = 6;

  @override
  Widget build(BuildContext context) {
    return Skeletonizer(
      enabled: isLoading,
      child: GridView.builder(
        controller: scrollController,
        // Always scrollable, so a pull-to-refresh above it works even when the
        // recipes do not fill the screen.
        physics: const AlwaysScrollableScrollPhysics(),
        padding: const EdgeInsets.all(16),
        gridDelegate: recipeGridDelegate,
        itemCount: isLoading ? _placeholderCount : recipes.length,
        itemBuilder: (context, index) {
          final recipe = isLoading ? placeholderRecipe(index) : recipes[index];
          return RecipeGridCard(
            recipe: recipe,
            onTap: isLoading ? null : () => onRecipeTap(recipe),
          );
        },
      ),
    );
  }
}
