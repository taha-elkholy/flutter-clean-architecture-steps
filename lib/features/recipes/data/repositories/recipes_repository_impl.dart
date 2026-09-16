import 'package:flutter_clean_architecture_steps/core/error/app_exception.dart';
import 'package:flutter_clean_architecture_steps/core/error/failure.dart';
import 'package:flutter_clean_architecture_steps/core/result/result.dart';
import 'package:flutter_clean_architecture_steps/features/recipes/data/datasources/recipes_remote_data_source.dart';
import 'package:flutter_clean_architecture_steps/features/recipes/data/mappers/recipe_details_mapper.dart';
import 'package:flutter_clean_architecture_steps/features/recipes/data/mappers/recipes_page_mapper.dart';
import 'package:flutter_clean_architecture_steps/features/recipes/domain/entities/params/get_recipes_params.dart';
import 'package:flutter_clean_architecture_steps/features/recipes/domain/entities/recipe_details_entity.dart';
import 'package:flutter_clean_architecture_steps/features/recipes/domain/entities/recipes_page_entity.dart';
import 'package:flutter_clean_architecture_steps/features/recipes/domain/repositories/recipes_repository.dart';

class RecipesRepositoryImpl implements RecipesRepository {
  const RecipesRepositoryImpl(this._remote);

  final RecipesRemoteDataSource _remote;

  @override
  Future<Result<RecipesPageEntity>> getRecipes(GetRecipesParams params) {
    return _read(() async => (await _remote.getRecipes(params)).toEntity());
  }

  @override
  Future<Result<RecipesPageEntity>> searchRecipes(String query) {
    return _read(() async => (await _remote.searchRecipes(query)).toEntity());
  }

  @override
  Future<Result<RecipeDetailsEntity>> getRecipeDetails(int recipeId) {
    return _read(
      () async => (await _remote.getRecipeDetails(recipeId)).toEntity(),
    );
  }

  /// Runs [read] and answers with a [Result] either way.
  ///
  /// A data source names what went wrong; this turns that name into the
  /// message a screen can show.
  Future<Result<T>> _read<T>(Future<T> Function() read) async {
    try {
      return Result.success(await read());
    } on AppException catch (appException) {
      return Result.failed(mapFailure(appException));
    }
  }
}
