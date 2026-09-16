import 'package:flutter_clean_architecture_steps/entities/params/get_recipes_params.dart';
import 'package:flutter_clean_architecture_steps/entities/recipe_details_entity.dart';
import 'package:flutter_clean_architecture_steps/entities/recipes_page_entity.dart';

/// What the cubits can ask for, said without naming Dio, a url or a json map.
///
/// Abstract, so a cubit depends on the questions and not on what answers them.
abstract class RecipesRepository {
  /// One page of recipes, as [params] asks for them.
  Future<RecipesPageEntity> getRecipes(GetRecipesParams params);

  /// The recipes matching [query].
  Future<RecipesPageEntity> searchRecipes(String query);

  /// The full recipe behind [recipeId].
  Future<RecipeDetailsEntity> getRecipeDetails(int recipeId);
}
