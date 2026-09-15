import 'package:equatable/equatable.dart';

/// The full recipe as the details page uses it.
///
/// Separate from the list entity rather than an extension of it, because the
/// two come from different endpoints and neither is a subset the other can
/// stand in for.
class RecipeDetailsEntity extends Equatable {
  const RecipeDetailsEntity({
    required this.id,
    required this.name,
    required this.image,
    required this.rating,
    required this.cuisine,
    required this.difficulty,
    required this.caloriesPerServing,
    required this.prepTimeMinutes,
    required this.cookTimeMinutes,
    required this.servings,
    required this.ingredients,
    required this.instructions,
  });

  final int id;
  final String name;
  final String image;
  final double rating;
  final String cuisine;
  final String difficulty;
  final int caloriesPerServing;
  final int prepTimeMinutes;
  final int cookTimeMinutes;
  final int servings;
  final List<String> ingredients;
  final List<String> instructions;

  @override
  List<Object?> get props => [
    id,
    name,
    image,
    rating,
    cuisine,
    difficulty,
    caloriesPerServing,
    prepTimeMinutes,
    cookTimeMinutes,
    servings,
    ingredients,
    instructions,
  ];
}
