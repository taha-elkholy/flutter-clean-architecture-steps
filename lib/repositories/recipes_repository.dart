import 'package:flutter_clean_architecture_steps/entities/params/get_recipes_params.dart';
import 'package:flutter_clean_architecture_steps/entities/recipe_details_entity.dart';
import 'package:flutter_clean_architecture_steps/entities/recipes_page_entity.dart';
import 'package:flutter_clean_architecture_steps/error/result.dart';

abstract class RecipesRepository {
  Future<Result<RecipesPageEntity>> getRecipes(GetRecipesParams params);

  Future<Result<RecipesPageEntity>> searchRecipes(String query);

  Future<Result<RecipeDetailsEntity>> getRecipeDetails(int recipeId);
}
