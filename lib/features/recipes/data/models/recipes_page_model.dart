import 'package:flutter_clean_architecture_steps/features/recipes/data/models/recipe_model.dart';

class RecipesPageModel {
  const RecipesPageModel({this.recipes, this.total});

  factory RecipesPageModel.fromMap(Map<String, dynamic> map) {
    return RecipesPageModel(
      recipes: (map['recipes'] as List<dynamic>?)
          ?.map(
            (recipe) => RecipeModel.fromMap(recipe as Map<String, dynamic>),
          )
          .toList(),
      total: map['total'] as int?,
    );
  }

  final List<RecipeModel>? recipes;
  final int? total;

  Map<String, dynamic> toMap() {
    return {
      'recipes': recipes?.map((recipe) => recipe.toMap()).toList(),
      'total': total,
    };
  }
}
