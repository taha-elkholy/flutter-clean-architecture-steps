import 'package:flutter_clean_architecture_steps/features/recipes/data/models/recipe_model.dart';
import 'package:flutter_clean_architecture_steps/features/recipes/domain/entities/recipe_entity.dart';

/// Where a missing field stops being missing: each null becomes the empty
/// value of its own type.
extension RecipeModelMapper on RecipeModel {
  RecipeEntity toEntity() {
    return RecipeEntity(
      id: id ?? 0,
      name: name ?? '',
      image: image ?? '',
      rating: rating ?? 0,
      cuisine: cuisine ?? '',
      difficulty: difficulty ?? '',
    );
  }
}
