import 'package:drift/drift.dart';
import 'package:flutter_clean_architecture_steps/core/cache/cache_database.dart';
import 'package:flutter_clean_architecture_steps/core/error/app_exception.dart';
import 'package:flutter_clean_architecture_steps/features/recipes/data/mappers/cached_recipe_details_mapper.dart';
import 'package:flutter_clean_architecture_steps/features/recipes/data/mappers/cached_recipe_mapper.dart';
import 'package:flutter_clean_architecture_steps/features/recipes/data/models/recipe_details_model.dart';
import 'package:flutter_clean_architecture_steps/features/recipes/data/models/recipe_model.dart';
import 'package:flutter_clean_architecture_steps/features/recipes/domain/entities/recipe_sort.dart';

abstract class RecipesLocalDataSource {
  Future<List<RecipeModel>> getRecipes(RecipeSort sort);

  Future<void> saveRecipes({
    required RecipeSort sort,
    required List<RecipeModel> recipes,
    required int skip,
    required bool replace,
  });

  Future<RecipeDetailsModel?> getRecipeDetails(int recipeId);

  Future<void> saveRecipeDetails(RecipeDetailsModel details);
}

class RecipesLocalDataSourceImpl implements RecipesLocalDataSource {
  const RecipesLocalDataSourceImpl(this._database);

  final CacheDatabase _database;

  @override
  Future<List<RecipeModel>> getRecipes(RecipeSort sort) {
    return _read(() async {
      final query = _database.select(_database.cachedRecipes)
        ..where((row) => row.sort.equals(sort.queryValue))
        ..orderBy([(row) => OrderingTerm.asc(row.position)]);

      final rows = await query.get();

      return rows.map((row) => row.toModel()).toList();
    });
  }

  @override
  Future<void> saveRecipes({
    required RecipeSort sort,
    required List<RecipeModel> recipes,
    required int skip,
    required bool replace,
  }) {
    return _read(() async {
      final rows = [
        for (final (index, recipe) in recipes.indexed)
          if (recipe.id case final id?)
            recipe.toCachedRow(id: id, sort: sort, position: skip + index),
      ];

      await _database.transaction(() async {
        if (replace) {
          await (_database.delete(_database.cachedRecipes)
                ..where((row) => row.sort.equals(sort.queryValue)))
              .go();
        }

        await _database.batch(
          (batch) =>
              batch.insertAllOnConflictUpdate(_database.cachedRecipes, rows),
        );
      });
    });
  }

  @override
  Future<RecipeDetailsModel?> getRecipeDetails(int recipeId) {
    return _read(() async {
      final query = _database.select(_database.cachedRecipeDetails)
        ..where((row) => row.id.equals(recipeId));

      final row = await query.getSingleOrNull();

      return row?.toModel();
    });
  }

  @override
  Future<void> saveRecipeDetails(RecipeDetailsModel details) {
    return _read(() async {
      if (details.id case final id?) {
        await _database
            .into(_database.cachedRecipeDetails)
            .insertOnConflictUpdate(details.toCachedRow(id: id));
      }
    });
  }

  /// Runs [read] and names anything the database throws.
  ///
  /// One code for all of it: a screen has nothing different to say about a
  /// locked file and a failed write.
  Future<T> _read<T>(Future<T> Function() read) async {
    try {
      return await read();
    } on Object catch (_) {
      throw const CacheException();
    }
  }
}
