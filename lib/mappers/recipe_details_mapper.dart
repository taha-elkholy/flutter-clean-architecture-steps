import 'package:flutter_clean_architecture_steps/entities/recipe_details_entity.dart';
import 'package:flutter_clean_architecture_steps/models/recipe_details_model.dart';

extension RecipeDetailsModelMapper on RecipeDetailsModel {
  RecipeDetailsEntity toEntity() {
    return RecipeDetailsEntity(
      id: id ?? 0,
      name: name ?? '',
      image: image ?? '',
      rating: rating ?? 0,
      cuisine: cuisine ?? '',
      difficulty: difficulty ?? '',
      caloriesPerServing: caloriesPerServing ?? 0,
      prepTimeMinutes: prepTimeMinutes ?? 0,
      cookTimeMinutes: cookTimeMinutes ?? 0,
      servings: servings ?? 0,
      // A null entry inside the list is dropped rather than turned into an
      // empty bullet on screen.
      ingredients: ingredients?.nonNulls.toList() ?? const [],
      instructions: instructions?.nonNulls.toList() ?? const [],
    );
  }
}
