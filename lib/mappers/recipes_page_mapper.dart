import 'package:flutter_clean_architecture_steps/entities/recipes_page_entity.dart';
import 'package:flutter_clean_architecture_steps/mappers/recipe_mapper.dart';
import 'package:flutter_clean_architecture_steps/models/recipes_page_model.dart';

extension RecipesPageModelMapper on RecipesPageModel {
  RecipesPageEntity toEntity() {
    return RecipesPageEntity(
      recipes: recipes?.map((recipe) => recipe.toEntity()).toList() ?? const [],
      total: total ?? 0,
    );
  }
}
