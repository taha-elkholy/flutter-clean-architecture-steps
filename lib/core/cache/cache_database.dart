import 'package:drift/drift.dart';
import 'package:drift_flutter/drift_flutter.dart';
import 'package:flutter_clean_architecture_steps/core/cache/tables/cached_recipe_details_table.dart';
import 'package:flutter_clean_architecture_steps/core/cache/tables/cached_recipes_table.dart';

part 'cache_database.g.dart';

@DriftDatabase(tables: [CachedRecipes, CachedRecipeDetails])
class CacheDatabase extends _$CacheDatabase {
  CacheDatabase() : super(driftDatabase(name: _fileName));

  static const _fileName = 'recipes_cache';

  @override
  int get schemaVersion => 1;
}
