import 'package:flutter/material.dart';
import 'package:flutter_clean_architecture_steps/widgets/network_image_with_shimmer.dart';

// Shared card UI for both the home grid and the search grid.
// Duplicated on purpose is avoided here for one widget only (the card),
// while the fetch logic itself still lives separately in each page's State
// — that duplication is intentional and left for a later branch.
Widget buildRecipeGridCard(dynamic recipe, VoidCallback onTap) {
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
                      color: Colors.white.withValues(alpha: 0.9),
                      borderRadius: BorderRadius.circular(6),
                    ),
                    child: Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        const Icon(
                          Icons.star,
                          size: 10,
                          color: Color(0xFFB4501F),
                        ),
                        const SizedBox(width: 2),
                        Text(
                          '${recipe['rating']}',
                          style: const TextStyle(
                            fontSize: 10,
                            fontWeight: FontWeight.bold,
                            color: Color(0xFFB4501F),
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
          style: const TextStyle(
            fontSize: 12.5,
            fontWeight: FontWeight.w600,
            color: Color(0xFF2B2420),
          ),
        ),
        const SizedBox(height: 2),
        Text(
          '${recipe['cuisine']} · ${recipe['difficulty']}',
          style: const TextStyle(fontSize: 10.5, color: Color(0xFFA08F76)),
        ),
      ],
    ),
  );
}

const recipeGridDelegate = SliverGridDelegateWithFixedCrossAxisCount(
  crossAxisCount: 2,
  crossAxisSpacing: 10,
  mainAxisSpacing: 10,
  childAspectRatio: 0.72,
);

dynamic placeholderRecipe(int id) => {
  'id': id,
  'name': 'Recipe name placeholder',
  'image': '',
  'rating': 4.5,
  'cuisine': 'Cuisine',
  'difficulty': 'Easy',
};
