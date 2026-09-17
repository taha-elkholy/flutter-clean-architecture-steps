import 'package:flutter_clean_architecture_steps/core/result/result.dart';
import 'package:flutter_clean_architecture_steps/features/recipes/domain/entities/params/get_recipes_params.dart';
import 'package:flutter_clean_architecture_steps/features/recipes/domain/entities/recipe_sort.dart';
import 'package:flutter_clean_architecture_steps/features/recipes/domain/entities/recipes_page_entity.dart';
import 'package:flutter_clean_architecture_steps/features/recipes/domain/repositories/recipes_repository.dart';
import 'package:injectable/injectable.dart';

@injectable
class GetRecipeListUseCase {
  const GetRecipeListUseCase(this._repository);

  final RecipesRepository _repository;

  static const _pageSize = 10;

  Future<Result<RecipesPageEntity>> call({
    required RecipeSort sort,
    required int skip,
  }) {
    return _repository.getRecipes(
      GetRecipesParams(sort: sort, skip: skip, limit: _pageSize),
    );
  }
}
