import 'package:flutter/material.dart';
import 'package:flutter_clean_architecture_steps/widgets/recipe_grid_card.dart';
import 'package:skeletonizer/skeletonizer.dart';

/// The recipe grid, used by both the list page and the search page.
///
/// Loading is a state of the grid rather than a separate widget: the skeleton
/// is the same grid built from fake recipes, so the placeholder always has the
/// exact shape of the content it stands in for, and the caller never writes a
/// conditional to choose between the two.
class RecipesGrid extends StatelessWidget {
  const RecipesGrid({
    required this.recipes,
    required this.onRecipeTap,
    this.isLoading = false,
    this.scrollController,
    this.physics,
    super.key,
  });

  final List<dynamic> recipes;
  final void Function(dynamic recipe) onRecipeTap;

  /// While true the grid shows [_placeholderCount] skeleton cards and ignores
  /// [recipes].
  final bool isLoading;

  /// Supplied by the list page to drive pagination; the search page has no
  /// pagination and leaves it null.
  final ScrollController? scrollController;

  final ScrollPhysics? physics;

  static const _placeholderCount = 6;

  @override
  Widget build(BuildContext context) {
    return Skeletonizer(
      enabled: isLoading,
      child: GridView.builder(
        controller: scrollController,
        physics: physics,
        padding: const EdgeInsets.all(16),
        gridDelegate: recipeGridDelegate,
        itemCount: isLoading ? _placeholderCount : recipes.length,
        itemBuilder: (context, index) {
          final recipe = isLoading ? placeholderRecipe(index) : recipes[index];
          return RecipeGridCard(
            recipe: recipe,
            onTap: () => onRecipeTap(recipe),
          );
        },
      ),
    );
  }
}
