import 'package:flutter_clean_architecture_steps/core/result/result.dart';
import 'package:flutter_clean_architecture_steps/features/recipes/domain/entities/recipe_details_entity.dart';
import 'package:flutter_clean_architecture_steps/features/recipes/domain/repositories/recipes_repository.dart';
import 'package:injectable/injectable.dart';

@injectable
class GetRecipeDetailsUseCase {
  const GetRecipeDetailsUseCase(this._repository);

  final RecipesRepository _repository;

  Future<Result<RecipeDetailsEntity>> call(int recipeId) {
    return _repository.getRecipeDetails(recipeId);
  }
}
