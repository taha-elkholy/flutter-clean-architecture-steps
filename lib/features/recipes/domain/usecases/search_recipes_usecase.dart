import 'package:flutter_clean_architecture_steps/core/result/result.dart';
import 'package:flutter_clean_architecture_steps/features/recipes/domain/entities/recipes_page_entity.dart';
import 'package:flutter_clean_architecture_steps/features/recipes/domain/repositories/recipes_repository.dart';

class SearchRecipesUseCase {
  const SearchRecipesUseCase(this._repository);

  final RecipesRepository _repository;

  Future<Result<RecipesPageEntity>> call(String query) {
    return _repository.searchRecipes(query);
  }
}
