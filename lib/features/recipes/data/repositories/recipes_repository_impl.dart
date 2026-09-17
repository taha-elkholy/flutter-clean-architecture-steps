import 'package:flutter_clean_architecture_steps/core/error/app_exception.dart';
import 'package:flutter_clean_architecture_steps/core/error/failure.dart';
import 'package:flutter_clean_architecture_steps/core/result/result.dart';
import 'package:flutter_clean_architecture_steps/features/recipes/data/datasources/recipes_local_data_source.dart';
import 'package:flutter_clean_architecture_steps/features/recipes/data/datasources/recipes_remote_data_source.dart';
import 'package:flutter_clean_architecture_steps/features/recipes/data/mappers/recipe_details_mapper.dart';
import 'package:flutter_clean_architecture_steps/features/recipes/data/mappers/recipe_mapper.dart';
import 'package:flutter_clean_architecture_steps/features/recipes/data/mappers/recipes_page_mapper.dart';
import 'package:flutter_clean_architecture_steps/features/recipes/domain/entities/params/get_recipes_params.dart';
import 'package:flutter_clean_architecture_steps/features/recipes/domain/entities/recipe_details_entity.dart';
import 'package:flutter_clean_architecture_steps/features/recipes/domain/entities/recipes_page_entity.dart';
import 'package:flutter_clean_architecture_steps/features/recipes/domain/repositories/recipes_repository.dart';
import 'package:injectable/injectable.dart';

@LazySingleton(as: RecipesRepository)
class RecipesRepositoryImpl implements RecipesRepository {
  const RecipesRepositoryImpl(this._remote, this._local);

  final RecipesRemoteDataSource _remote;
  final RecipesLocalDataSource _local;

  /// Only the first page falls back to the cache: the cache holds what the
  /// server already sent, so answering a `loadMore` from it would repeat
  /// recipes already on screen.
  @override
  Future<Result<RecipesPageEntity>> getRecipes(GetRecipesParams params) async {
    try {
      final page = await _remote.getRecipes(params);

      await _save(
        () => _local.saveRecipes(
          sort: params.sort,
          recipes: page.recipes ?? const [],
          skip: params.skip,
          replace: params.skip == 0,
        ),
      );

      return Result.success(page.toEntity());
    } on AppException catch (appException) {
      if (params.skip != 0) return Result.failed(mapFailure(appException));

      return _cachedPage(params, appException);
    }
  }

  /// No cache fallback: the cache holds what this device happened to scroll
  /// past, so a local search would answer from a fraction of the catalogue —
  /// and the server searches ingredients and instructions too, not just names.
  @override
  Future<Result<RecipesPageEntity>> searchRecipes(String query) {
    return _read(() async => (await _remote.searchRecipes(query)).toEntity());
  }

  @override
  Future<Result<RecipeDetailsEntity>> getRecipeDetails(int recipeId) async {
    try {
      final details = await _remote.getRecipeDetails(recipeId);
      await _save(() => _local.saveRecipeDetails(details));

      return Result.success(details.toEntity());
    } on AppException catch (appException) {
      final cached = await _cached(() => _local.getRecipeDetails(recipeId));
      if (cached == null) return Result.failed(mapFailure(appException));

      return Result.success(cached.toEntity());
    }
  }

  /// [RecipesPageEntity.total] is what the cache holds rather than what the
  /// server has, so the list stops asking for more while it is offline.
  Future<Result<RecipesPageEntity>> _cachedPage(
    GetRecipesParams params,
    AppException appException,
  ) async {
    final cached = await _cached(() => _local.getRecipes(params.sort));

    if (cached == null || cached.isEmpty) {
      return Result.failed(mapFailure(appException));
    }

    final recipes = cached.map((recipe) => recipe.toEntity()).toList();

    return Result.success(
      RecipesPageEntity(recipes: recipes, total: recipes.length),
    );
  }

  /// Only ever called once the network has already failed, and a cache that
  /// fails too says nothing the network error does not say better.
  Future<T?> _cached<T>(Future<T?> Function() read) async {
    try {
      return await read();
    } on AppException catch (_) {
      return null;
    }
  }

  /// Saving is what the next run reads, never what this one answers with: a
  /// full disk must not turn a request that worked into an error on screen.
  Future<void> _save(Future<void> Function() write) async {
    try {
      await write();
    } on AppException catch (_) {
      return;
    }
  }

  Future<Result<T>> _read<T>(Future<T> Function() read) async {
    try {
      return Result.success(await read());
    } on AppException catch (appException) {
      return Result.failed(mapFailure(appException));
    }
  }
}
