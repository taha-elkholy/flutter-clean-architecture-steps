import 'package:flutter_clean_architecture_steps/entities/recipe_entity.dart';
import 'package:flutter_clean_architecture_steps/models/recipe_model.dart';

/// Where a missing field stops being missing.
///
/// Each null becomes the empty value of its own type, so the screens get an
/// entity they can read without asking.
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
