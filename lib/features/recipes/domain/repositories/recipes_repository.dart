import 'package:flutter_clean_architecture_steps/core/result/result.dart';
import 'package:flutter_clean_architecture_steps/features/recipes/domain/entities/params/get_recipes_params.dart';
import 'package:flutter_clean_architecture_steps/features/recipes/domain/entities/recipe_details_entity.dart';
import 'package:flutter_clean_architecture_steps/features/recipes/domain/entities/recipes_page_entity.dart';

abstract class RecipesRepository {
  Future<Result<RecipesPageEntity>> getRecipes(GetRecipesParams params);

  Future<Result<RecipesPageEntity>> searchRecipes(String query);

  Future<Result<RecipeDetailsEntity>> getRecipeDetails(int recipeId);
}
