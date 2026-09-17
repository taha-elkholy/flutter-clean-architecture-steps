import 'dart:convert';

import 'package:drift/drift.dart';

/// Stores a list of strings in one text column as json.
///
/// Nothing queries an ingredient on its own, so splitting them across rows
/// would buy nothing.
class StringListConverter extends TypeConverter<List<String>, String>
    with JsonTypeConverter<List<String>, String> {
  const StringListConverter();

  @override
  List<String> fromSql(String fromDb) {
    final decoded = jsonDecode(fromDb) as List<dynamic>;

    return decoded.map((value) => value as String).toList();
  }

  @override
  String toSql(List<String> value) => jsonEncode(value);
}
