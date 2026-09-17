import 'package:flutter_clean_architecture_steps/core/cache/cache_database.dart';
import 'package:flutter_clean_architecture_steps/features/recipes/data/models/recipe_model.dart';
import 'package:flutter_clean_architecture_steps/features/recipes/domain/entities/recipe_sort.dart';

/// A row holds no nulls, so writing one fills every gap the same way the
/// entity mapper does.
extension RecipeModelCacheMapper on RecipeModel {
  CachedRecipeRow toCachedRow({
    required int id,
    required RecipeSort sort,
    required int position,
  }) {
    return CachedRecipeRow(
      id: id,
      sort: sort.queryValue,
      position: position,
      name: name ?? '',
      image: image ?? '',
      rating: rating ?? 0,
      cuisine: cuisine ?? '',
      difficulty: difficulty ?? '',
    );
  }
}

extension CachedRecipeRowMapper on CachedRecipeRow {
  RecipeModel toModel() {
    return RecipeModel(
      id: id,
      name: name,
      image: image,
      rating: rating,
      cuisine: cuisine,
      difficulty: difficulty,
    );
  }
}
