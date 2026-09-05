import 'package:flutter/material.dart';
import 'package:flutter_clean_architecture_steps/extensions/build_context_extensions.dart';
import 'package:flutter_clean_architecture_steps/generated/l10n.dart';
import 'package:flutter_clean_architecture_steps/widgets/network_image_with_shimmer.dart';

// Shared card UI for both the home grid and the search grid.
// Duplicated on purpose is avoided here for one widget only (the card),
// while the fetch logic itself still lives separately in each page's State
// — that duplication is intentional and left for a later branch.
class RecipeGridCard extends StatelessWidget {
  const RecipeGridCard({required this.recipe, required this.onTap, super.key});

  final dynamic recipe;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    final theme = context.theme;
    final strings = context.strings;
    final tertiaryColor = theme.colorScheme.tertiary;

    return GestureDetector(
      onTap: onTap,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          AspectRatio(
            aspectRatio: 1,
            child: ClipRRect(
              borderRadius: BorderRadius.circular(10),
              child: Stack(
                fit: StackFit.expand,
                children: [
                  NetworkImageWithShimmer(
                    imageUrl: recipe['image'] ?? '',
                    width: double.infinity,
                    height: double.infinity,
                  ),
                  Positioned(
                    top: 6,
                    right: 6,
                    child: Container(
                      padding: const EdgeInsets.symmetric(
                        horizontal: 6,
                        vertical: 2,
                      ),
                      decoration: BoxDecoration(
                        color: theme.colorScheme.surfaceContainerLowest,
                        borderRadius: BorderRadius.circular(6),
                      ),
                      child: Row(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          Icon(
                            Icons.star,
                            size: 10,
                            color: tertiaryColor,
                          ),
                          const SizedBox(width: 2),
                          Text(
                            '${recipe['rating']}',
                            style: theme.textTheme.labelMedium?.copyWith(
                              color: tertiaryColor,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
          const SizedBox(height: 6),
          Text(
            recipe['name'],
            maxLines: 1,
            overflow: TextOverflow.ellipsis,
            style: theme.textTheme.labelLarge,
          ),
          const SizedBox(height: 2),
          Text(
            strings.recipeMeta(
              recipe['cuisine'] as String,
              recipe['difficulty'] as String,
            ),
            style: theme.textTheme.labelSmall,
          ),
        ],
      ),
    );
  }
}

const recipeGridDelegate = SliverGridDelegateWithFixedCrossAxisCount(
  crossAxisCount: 2,
  crossAxisSpacing: 10,
  mainAxisSpacing: 10,
  childAspectRatio: 0.72,
);

// Uses S.current instead of S.of(context): this is a plain data helper with
// no BuildContext of its own, and the placeholder is only ever built while
// the app is already running with a resolved locale.
dynamic placeholderRecipe(int id) => {
  'id': id,
  'name': S.current.recipeNamePlaceholder,
  'image': '',
  'rating': 4.5,
  'cuisine': S.current.cuisinePlaceholder,
  'difficulty': S.current.difficultyPlaceholder,
};
