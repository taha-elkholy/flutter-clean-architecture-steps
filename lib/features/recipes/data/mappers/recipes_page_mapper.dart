import 'package:flutter_clean_architecture_steps/features/recipes/data/mappers/recipe_mapper.dart';
import 'package:flutter_clean_architecture_steps/features/recipes/data/models/recipes_page_model.dart';
import 'package:flutter_clean_architecture_steps/features/recipes/domain/entities/recipes_page_entity.dart';

extension RecipesPageModelMapper on RecipesPageModel {
  RecipesPageEntity toEntity() {
    return RecipesPageEntity(
      recipes: recipes?.map((recipe) => recipe.toEntity()).toList() ?? const [],
      total: total ?? 0,
    );
  }
}
