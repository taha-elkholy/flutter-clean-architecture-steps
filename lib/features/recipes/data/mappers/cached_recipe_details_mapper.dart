import 'package:flutter_clean_architecture_steps/core/cache/cache_database.dart';
import 'package:flutter_clean_architecture_steps/features/recipes/data/models/recipe_details_model.dart';

extension RecipeDetailsModelCacheMapper on RecipeDetailsModel {
  CachedRecipeDetailsRow toCachedRow({required int id}) {
    return CachedRecipeDetailsRow(
      id: id,
      name: name ?? '',
      image: image ?? '',
      rating: rating ?? 0,
      cuisine: cuisine ?? '',
      difficulty: difficulty ?? '',
      caloriesPerServing: caloriesPerServing ?? 0,
      prepTimeMinutes: prepTimeMinutes ?? 0,
      cookTimeMinutes: cookTimeMinutes ?? 0,
      servings: servings ?? 0,
      ingredients: ingredients?.nonNulls.toList() ?? const [],
      instructions: instructions?.nonNulls.toList() ?? const [],
    );
  }
}

extension CachedRecipeDetailsRowMapper on CachedRecipeDetailsRow {
  RecipeDetailsModel toModel() {
    return RecipeDetailsModel(
      id: id,
      name: name,
      image: image,
      rating: rating,
      cuisine: cuisine,
      difficulty: difficulty,
      caloriesPerServing: caloriesPerServing,
      prepTimeMinutes: prepTimeMinutes,
      cookTimeMinutes: cookTimeMinutes,
      servings: servings,
      ingredients: ingredients,
      instructions: instructions,
    );
  }
}
