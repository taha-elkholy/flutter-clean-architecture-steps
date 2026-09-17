import 'package:drift/drift.dart';
import 'package:drift_flutter/drift_flutter.dart';
// The generated part is compiled against this file's imports alone, and it
// names the converter the details table maps through.
import 'package:flutter_clean_architecture_steps/core/cache/converters/string_list_converter.dart';
import 'package:flutter_clean_architecture_steps/core/cache/tables/cached_recipe_details_table.dart';
import 'package:flutter_clean_architecture_steps/core/cache/tables/cached_recipes_table.dart';

part 'cache_database.g.dart';

@DriftDatabase(tables: [CachedRecipes, CachedRecipeDetails])
class CacheDatabase extends _$CacheDatabase {
  CacheDatabase._() : super(driftDatabase(name: _fileName));

  /// One connection for the whole app: a second one opened on the same file
  /// would not see what the first has written.
  ///
  /// Static until a branch arrives that hands dependencies out properly.
  static final CacheDatabase instance = CacheDatabase._();

  static const _fileName = 'recipes_cache';

  @override
  int get schemaVersion => 1;
}
