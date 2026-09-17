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

class RecipesRepositoryImpl implements RecipesRepository {
  const RecipesRepositoryImpl(this._remote, this._local);

  final RecipesRemoteDataSource _remote;
  final RecipesLocalDataSource _local;

  /// Reads a page, and falls back to what was saved only for the first one.
  ///
  /// A later page cannot fall back: the cache holds what the server already
  /// sent, so answering a `loadMore` from it would repeat recipes already on
  /// screen. Failing there leaves the list as it is instead.
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

  /// No fallback here. The cache holds what this device happened to scroll
  /// past, so a local search would answer from a fraction of the catalogue
  /// without saying so — and the server searches ingredients and instructions
  /// too, not just the name. Failing is the honest answer.
  @override
  Future<Result<RecipesPageEntity>> searchRecipes(String query) {
    return _read(() async => (await _remote.searchRecipes(query)).toEntity());
  }

  /// Reads one recipe, and falls back to the copy saved when it was last read.
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

  /// Everything saved for this sort, as one page.
  ///
  /// [RecipesPageEntity.total] is what it holds rather than what the server
  /// has, so the list stops asking for more while it is offline.
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

  /// Runs [read] and answers null if the cache refuses it.
  ///
  /// Only ever called once the network has already failed, and a cache that
  /// fails too says nothing the network error does not say better.
  Future<T?> _cached<T>(Future<T?> Function() read) async {
    try {
      return await read();
    } on AppException catch (_) {
      return null;
    }
  }

  /// Runs [write] and swallows a cache that refuses it.
  ///
  /// Saving is what the next run reads, never what this one answers with: a
  /// full disk must not turn a request that worked into an error on screen.
  Future<void> _save(Future<void> Function() write) async {
    try {
      await write();
    } on AppException catch (_) {
      return;
    }
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
