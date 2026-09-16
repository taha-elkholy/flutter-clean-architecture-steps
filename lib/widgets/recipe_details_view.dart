import 'package:flutter/material.dart';
import 'package:flutter_clean_architecture_steps/entities/recipe_details_entity.dart';
import 'package:flutter_clean_architecture_steps/extensions/build_context_extensions.dart';
import 'package:flutter_clean_architecture_steps/widgets/network_image_with_shimmer.dart';

/// The details body once the recipe has arrived.
class RecipeDetailsView extends StatelessWidget {
  const RecipeDetailsView({required this.recipe, super.key});

  final RecipeDetailsEntity recipe;

  @override
  Widget build(BuildContext context) {
    final textTheme = context.textTheme;
    final strings = context.strings;

    return SingleChildScrollView(
      padding: const EdgeInsets.all(16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          ClipRRect(
            borderRadius: BorderRadius.circular(14),
            child: NetworkImageWithShimmer(
              imageUrl: recipe.image,
              width: double.infinity,
              height: 220,
            ),
          ),
          const SizedBox(height: 14),
          Text(recipe.name, style: textTheme.titleMedium),
          const SizedBox(height: 6),
          Text(
            strings.recipeMetaWithCalories(
              recipe.cuisine,
              recipe.difficulty,
              recipe.caloriesPerServing,
            ),
            style: textTheme.bodySmall,
          ),
          const SizedBox(height: 18),
          Text(strings.ingredients, style: textTheme.titleSmall),
          const SizedBox(height: 8),
          ...recipe.ingredients.map(
            (ingredient) => Padding(
              padding: const EdgeInsets.only(bottom: 4),
              child: Text('• $ingredient'),
            ),
          ),
          const SizedBox(height: 18),
          Text(strings.instructions, style: textTheme.titleSmall),
          const SizedBox(height: 8),
          ...recipe.instructions.indexed.map(
            (entry) => Padding(
              padding: const EdgeInsets.only(bottom: 6),
              child: Text('${entry.$1 + 1}. ${entry.$2}'),
            ),
          ),
        ],
      ),
    );
  }
}
