import 'package:drift/drift.dart';
import 'package:flutter_clean_architecture_steps/core/cache/converters/string_list_converter.dart';

/// Kept apart from the list table on purpose: the two endpoints return
/// different records, and merging them would leave half-filled rows behind.
@DataClassName('CachedRecipeDetailsRow')
class CachedRecipeDetails extends Table {
  IntColumn get id => integer()();

  TextColumn get name => text()();

  TextColumn get image => text()();

  RealColumn get rating => real()();

  TextColumn get cuisine => text()();

  TextColumn get difficulty => text()();

  IntColumn get caloriesPerServing => integer()();

  IntColumn get prepTimeMinutes => integer()();

  IntColumn get cookTimeMinutes => integer()();

  IntColumn get servings => integer()();

  TextColumn get ingredients => text().map(const StringListConverter())();

  TextColumn get instructions => text().map(const StringListConverter())();

  @override
  Set<Column<Object>> get primaryKey => {id};
}
