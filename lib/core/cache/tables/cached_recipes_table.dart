import 'package:drift/drift.dart';

/// The key is the (id, sort) pair, so a recipe in both sorts is stored twice.
/// That duplication is what keeps reading a page a single query.
@DataClassName('CachedRecipeRow')
class CachedRecipes extends Table {
  IntColumn get id => integer()();

  TextColumn get sort => text()();

  /// Where the server put this recipe, kept rather than recomputed.
  IntColumn get position => integer()();

  TextColumn get name => text()();

  TextColumn get image => text()();

  RealColumn get rating => real()();

  TextColumn get cuisine => text()();

  TextColumn get difficulty => text()();

  @override
  Set<Column<Object>> get primaryKey => {id, sort};
}
