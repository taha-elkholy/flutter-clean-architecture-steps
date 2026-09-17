// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'cache_database.dart';

// ignore_for_file: type=lint
class $CachedRecipesTable extends CachedRecipes
    with TableInfo<$CachedRecipesTable, CachedRecipeRow> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $CachedRecipesTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _idMeta = const VerificationMeta('id');
  @override
  late final GeneratedColumn<int> id = GeneratedColumn<int>(
    'id',
    aliasedName,
    false,
    type: DriftSqlType.int,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _sortMeta = const VerificationMeta('sort');
  @override
  late final GeneratedColumn<String> sort = GeneratedColumn<String>(
    'sort',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _positionMeta = const VerificationMeta(
    'position',
  );
  @override
  late final GeneratedColumn<int> position = GeneratedColumn<int>(
    'position',
    aliasedName,
    false,
    type: DriftSqlType.int,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _nameMeta = const VerificationMeta('name');
  @override
  late final GeneratedColumn<String> name = GeneratedColumn<String>(
    'name',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _imageMeta = const VerificationMeta('image');
  @override
  late final GeneratedColumn<String> image = GeneratedColumn<String>(
    'image',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _ratingMeta = const VerificationMeta('rating');
  @override
  late final GeneratedColumn<double> rating = GeneratedColumn<double>(
    'rating',
    aliasedName,
    false,
    type: DriftSqlType.double,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _cuisineMeta = const VerificationMeta(
    'cuisine',
  );
  @override
  late final GeneratedColumn<String> cuisine = GeneratedColumn<String>(
    'cuisine',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _difficultyMeta = const VerificationMeta(
    'difficulty',
  );
  @override
  late final GeneratedColumn<String> difficulty = GeneratedColumn<String>(
    'difficulty',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  @override
  List<GeneratedColumn> get $columns => [
    id,
    sort,
    position,
    name,
    image,
    rating,
    cuisine,
    difficulty,
  ];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'cached_recipes';
  @override
  VerificationContext validateIntegrity(
    Insertable<CachedRecipeRow> instance, {
    bool isInserting = false,
  }) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    } else if (isInserting) {
      context.missing(_idMeta);
    }
    if (data.containsKey('sort')) {
      context.handle(
        _sortMeta,
        sort.isAcceptableOrUnknown(data['sort']!, _sortMeta),
      );
    } else if (isInserting) {
      context.missing(_sortMeta);
    }
    if (data.containsKey('position')) {
      context.handle(
        _positionMeta,
        position.isAcceptableOrUnknown(data['position']!, _positionMeta),
      );
    } else if (isInserting) {
      context.missing(_positionMeta);
    }
    if (data.containsKey('name')) {
      context.handle(
        _nameMeta,
        name.isAcceptableOrUnknown(data['name']!, _nameMeta),
      );
    } else if (isInserting) {
      context.missing(_nameMeta);
    }
    if (data.containsKey('image')) {
      context.handle(
        _imageMeta,
        image.isAcceptableOrUnknown(data['image']!, _imageMeta),
      );
    } else if (isInserting) {
      context.missing(_imageMeta);
    }
    if (data.containsKey('rating')) {
      context.handle(
        _ratingMeta,
        rating.isAcceptableOrUnknown(data['rating']!, _ratingMeta),
      );
    } else if (isInserting) {
      context.missing(_ratingMeta);
    }
    if (data.containsKey('cuisine')) {
      context.handle(
        _cuisineMeta,
        cuisine.isAcceptableOrUnknown(data['cuisine']!, _cuisineMeta),
      );
    } else if (isInserting) {
      context.missing(_cuisineMeta);
    }
    if (data.containsKey('difficulty')) {
      context.handle(
        _difficultyMeta,
        difficulty.isAcceptableOrUnknown(data['difficulty']!, _difficultyMeta),
      );
    } else if (isInserting) {
      context.missing(_difficultyMeta);
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id, sort};
  @override
  CachedRecipeRow map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return CachedRecipeRow(
      id: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}id'],
      )!,
      sort: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}sort'],
      )!,
      position: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}position'],
      )!,
      name: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}name'],
      )!,
      image: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}image'],
      )!,
      rating: attachedDatabase.typeMapping.read(
        DriftSqlType.double,
        data['${effectivePrefix}rating'],
      )!,
      cuisine: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}cuisine'],
      )!,
      difficulty: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}difficulty'],
      )!,
    );
  }

  @override
  $CachedRecipesTable createAlias(String alias) {
    return $CachedRecipesTable(attachedDatabase, alias);
  }
}

class CachedRecipeRow extends DataClass implements Insertable<CachedRecipeRow> {
  final int id;
  final String sort;

  /// Where the server put this recipe, kept rather than recomputed.
  final int position;
  final String name;
  final String image;
  final double rating;
  final String cuisine;
  final String difficulty;
  const CachedRecipeRow({
    required this.id,
    required this.sort,
    required this.position,
    required this.name,
    required this.image,
    required this.rating,
    required this.cuisine,
    required this.difficulty,
  });
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<int>(id);
    map['sort'] = Variable<String>(sort);
    map['position'] = Variable<int>(position);
    map['name'] = Variable<String>(name);
    map['image'] = Variable<String>(image);
    map['rating'] = Variable<double>(rating);
    map['cuisine'] = Variable<String>(cuisine);
    map['difficulty'] = Variable<String>(difficulty);
    return map;
  }

  CachedRecipesCompanion toCompanion(bool nullToAbsent) {
    return CachedRecipesCompanion(
      id: Value(id),
      sort: Value(sort),
      position: Value(position),
      name: Value(name),
      image: Value(image),
      rating: Value(rating),
      cuisine: Value(cuisine),
      difficulty: Value(difficulty),
    );
  }

  factory CachedRecipeRow.fromJson(
    Map<String, dynamic> json, {
    ValueSerializer? serializer,
  }) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return CachedRecipeRow(
      id: serializer.fromJson<int>(json['id']),
      sort: serializer.fromJson<String>(json['sort']),
      position: serializer.fromJson<int>(json['position']),
      name: serializer.fromJson<String>(json['name']),
      image: serializer.fromJson<String>(json['image']),
      rating: serializer.fromJson<double>(json['rating']),
      cuisine: serializer.fromJson<String>(json['cuisine']),
      difficulty: serializer.fromJson<String>(json['difficulty']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<int>(id),
      'sort': serializer.toJson<String>(sort),
      'position': serializer.toJson<int>(position),
      'name': serializer.toJson<String>(name),
      'image': serializer.toJson<String>(image),
      'rating': serializer.toJson<double>(rating),
      'cuisine': serializer.toJson<String>(cuisine),
      'difficulty': serializer.toJson<String>(difficulty),
    };
  }

  CachedRecipeRow copyWith({
    int? id,
    String? sort,
    int? position,
    String? name,
    String? image,
    double? rating,
    String? cuisine,
    String? difficulty,
  }) => CachedRecipeRow(
    id: id ?? this.id,
    sort: sort ?? this.sort,
    position: position ?? this.position,
    name: name ?? this.name,
    image: image ?? this.image,
    rating: rating ?? this.rating,
    cuisine: cuisine ?? this.cuisine,
    difficulty: difficulty ?? this.difficulty,
  );
  CachedRecipeRow copyWithCompanion(CachedRecipesCompanion data) {
    return CachedRecipeRow(
      id: data.id.present ? data.id.value : this.id,
      sort: data.sort.present ? data.sort.value : this.sort,
      position: data.position.present ? data.position.value : this.position,
      name: data.name.present ? data.name.value : this.name,
      image: data.image.present ? data.image.value : this.image,
      rating: data.rating.present ? data.rating.value : this.rating,
      cuisine: data.cuisine.present ? data.cuisine.value : this.cuisine,
      difficulty: data.difficulty.present
          ? data.difficulty.value
          : this.difficulty,
    );
  }

  @override
  String toString() {
    return (StringBuffer('CachedRecipeRow(')
          ..write('id: $id, ')
          ..write('sort: $sort, ')
          ..write('position: $position, ')
          ..write('name: $name, ')
          ..write('image: $image, ')
          ..write('rating: $rating, ')
          ..write('cuisine: $cuisine, ')
          ..write('difficulty: $difficulty')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode =>
      Object.hash(id, sort, position, name, image, rating, cuisine, difficulty);
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is CachedRecipeRow &&
          other.id == this.id &&
          other.sort == this.sort &&
          other.position == this.position &&
          other.name == this.name &&
          other.image == this.image &&
          other.rating == this.rating &&
          other.cuisine == this.cuisine &&
          other.difficulty == this.difficulty);
}

class CachedRecipesCompanion extends UpdateCompanion<CachedRecipeRow> {
  final Value<int> id;
  final Value<String> sort;
  final Value<int> position;
  final Value<String> name;
  final Value<String> image;
  final Value<double> rating;
  final Value<String> cuisine;
  final Value<String> difficulty;
  final Value<int> rowid;
  const CachedRecipesCompanion({
    this.id = const Value.absent(),
    this.sort = const Value.absent(),
    this.position = const Value.absent(),
    this.name = const Value.absent(),
    this.image = const Value.absent(),
    this.rating = const Value.absent(),
    this.cuisine = const Value.absent(),
    this.difficulty = const Value.absent(),
    this.rowid = const Value.absent(),
  });
  CachedRecipesCompanion.insert({
    required int id,
    required String sort,
    required int position,
    required String name,
    required String image,
    required double rating,
    required String cuisine,
    required String difficulty,
    this.rowid = const Value.absent(),
  }) : id = Value(id),
       sort = Value(sort),
       position = Value(position),
       name = Value(name),
       image = Value(image),
       rating = Value(rating),
       cuisine = Value(cuisine),
       difficulty = Value(difficulty);
  static Insertable<CachedRecipeRow> custom({
    Expression<int>? id,
    Expression<String>? sort,
    Expression<int>? position,
    Expression<String>? name,
    Expression<String>? image,
    Expression<double>? rating,
    Expression<String>? cuisine,
    Expression<String>? difficulty,
    Expression<int>? rowid,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (sort != null) 'sort': sort,
      if (position != null) 'position': position,
      if (name != null) 'name': name,
      if (image != null) 'image': image,
      if (rating != null) 'rating': rating,
      if (cuisine != null) 'cuisine': cuisine,
      if (difficulty != null) 'difficulty': difficulty,
      if (rowid != null) 'rowid': rowid,
    });
  }

  CachedRecipesCompanion copyWith({
    Value<int>? id,
    Value<String>? sort,
    Value<int>? position,
    Value<String>? name,
    Value<String>? image,
    Value<double>? rating,
    Value<String>? cuisine,
    Value<String>? difficulty,
    Value<int>? rowid,
  }) {
    return CachedRecipesCompanion(
      id: id ?? this.id,
      sort: sort ?? this.sort,
      position: position ?? this.position,
      name: name ?? this.name,
      image: image ?? this.image,
      rating: rating ?? this.rating,
      cuisine: cuisine ?? this.cuisine,
      difficulty: difficulty ?? this.difficulty,
      rowid: rowid ?? this.rowid,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<int>(id.value);
    }
    if (sort.present) {
      map['sort'] = Variable<String>(sort.value);
    }
    if (position.present) {
      map['position'] = Variable<int>(position.value);
    }
    if (name.present) {
      map['name'] = Variable<String>(name.value);
    }
    if (image.present) {
      map['image'] = Variable<String>(image.value);
    }
    if (rating.present) {
      map['rating'] = Variable<double>(rating.value);
    }
    if (cuisine.present) {
      map['cuisine'] = Variable<String>(cuisine.value);
    }
    if (difficulty.present) {
      map['difficulty'] = Variable<String>(difficulty.value);
    }
    if (rowid.present) {
      map['rowid'] = Variable<int>(rowid.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('CachedRecipesCompanion(')
          ..write('id: $id, ')
          ..write('sort: $sort, ')
          ..write('position: $position, ')
          ..write('name: $name, ')
          ..write('image: $image, ')
          ..write('rating: $rating, ')
          ..write('cuisine: $cuisine, ')
          ..write('difficulty: $difficulty, ')
          ..write('rowid: $rowid')
          ..write(')'))
        .toString();
  }
}

class $CachedRecipeDetailsTable extends CachedRecipeDetails
    with TableInfo<$CachedRecipeDetailsTable, CachedRecipeDetailsRow> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $CachedRecipeDetailsTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _idMeta = const VerificationMeta('id');
  @override
  late final GeneratedColumn<int> id = GeneratedColumn<int>(
    'id',
    aliasedName,
    false,
    type: DriftSqlType.int,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _nameMeta = const VerificationMeta('name');
  @override
  late final GeneratedColumn<String> name = GeneratedColumn<String>(
    'name',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _imageMeta = const VerificationMeta('image');
  @override
  late final GeneratedColumn<String> image = GeneratedColumn<String>(
    'image',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _ratingMeta = const VerificationMeta('rating');
  @override
  late final GeneratedColumn<double> rating = GeneratedColumn<double>(
    'rating',
    aliasedName,
    false,
    type: DriftSqlType.double,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _cuisineMeta = const VerificationMeta(
    'cuisine',
  );
  @override
  late final GeneratedColumn<String> cuisine = GeneratedColumn<String>(
    'cuisine',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _difficultyMeta = const VerificationMeta(
    'difficulty',
  );
  @override
  late final GeneratedColumn<String> difficulty = GeneratedColumn<String>(
    'difficulty',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _caloriesPerServingMeta =
      const VerificationMeta('caloriesPerServing');
  @override
  late final GeneratedColumn<int> caloriesPerServing = GeneratedColumn<int>(
    'calories_per_serving',
    aliasedName,
    false,
    type: DriftSqlType.int,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _prepTimeMinutesMeta = const VerificationMeta(
    'prepTimeMinutes',
  );
  @override
  late final GeneratedColumn<int> prepTimeMinutes = GeneratedColumn<int>(
    'prep_time_minutes',
    aliasedName,
    false,
    type: DriftSqlType.int,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _cookTimeMinutesMeta = const VerificationMeta(
    'cookTimeMinutes',
  );
  @override
  late final GeneratedColumn<int> cookTimeMinutes = GeneratedColumn<int>(
    'cook_time_minutes',
    aliasedName,
    false,
    type: DriftSqlType.int,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _servingsMeta = const VerificationMeta(
    'servings',
  );
  @override
  late final GeneratedColumn<int> servings = GeneratedColumn<int>(
    'servings',
    aliasedName,
    false,
    type: DriftSqlType.int,
    requiredDuringInsert: true,
  );
  @override
  late final GeneratedColumnWithTypeConverter<List<String>, String>
  ingredients =
      GeneratedColumn<String>(
        'ingredients',
        aliasedName,
        false,
        type: DriftSqlType.string,
        requiredDuringInsert: true,
      ).withConverter<List<String>>(
        $CachedRecipeDetailsTable.$converteringredients,
      );
  @override
  late final GeneratedColumnWithTypeConverter<List<String>, String>
  instructions =
      GeneratedColumn<String>(
        'instructions',
        aliasedName,
        false,
        type: DriftSqlType.string,
        requiredDuringInsert: true,
      ).withConverter<List<String>>(
        $CachedRecipeDetailsTable.$converterinstructions,
      );
  @override
  List<GeneratedColumn> get $columns => [
    id,
    name,
    image,
    rating,
    cuisine,
    difficulty,
    caloriesPerServing,
    prepTimeMinutes,
    cookTimeMinutes,
    servings,
    ingredients,
    instructions,
  ];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'cached_recipe_details';
  @override
  VerificationContext validateIntegrity(
    Insertable<CachedRecipeDetailsRow> instance, {
    bool isInserting = false,
  }) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    }
    if (data.containsKey('name')) {
      context.handle(
        _nameMeta,
        name.isAcceptableOrUnknown(data['name']!, _nameMeta),
      );
    } else if (isInserting) {
      context.missing(_nameMeta);
    }
    if (data.containsKey('image')) {
      context.handle(
        _imageMeta,
        image.isAcceptableOrUnknown(data['image']!, _imageMeta),
      );
    } else if (isInserting) {
      context.missing(_imageMeta);
    }
    if (data.containsKey('rating')) {
      context.handle(
        _ratingMeta,
        rating.isAcceptableOrUnknown(data['rating']!, _ratingMeta),
      );
    } else if (isInserting) {
      context.missing(_ratingMeta);
    }
    if (data.containsKey('cuisine')) {
      context.handle(
        _cuisineMeta,
        cuisine.isAcceptableOrUnknown(data['cuisine']!, _cuisineMeta),
      );
    } else if (isInserting) {
      context.missing(_cuisineMeta);
    }
    if (data.containsKey('difficulty')) {
      context.handle(
        _difficultyMeta,
        difficulty.isAcceptableOrUnknown(data['difficulty']!, _difficultyMeta),
      );
    } else if (isInserting) {
      context.missing(_difficultyMeta);
    }
    if (data.containsKey('calories_per_serving')) {
      context.handle(
        _caloriesPerServingMeta,
        caloriesPerServing.isAcceptableOrUnknown(
          data['calories_per_serving']!,
          _caloriesPerServingMeta,
        ),
      );
    } else if (isInserting) {
      context.missing(_caloriesPerServingMeta);
    }
    if (data.containsKey('prep_time_minutes')) {
      context.handle(
        _prepTimeMinutesMeta,
        prepTimeMinutes.isAcceptableOrUnknown(
          data['prep_time_minutes']!,
          _prepTimeMinutesMeta,
        ),
      );
    } else if (isInserting) {
      context.missing(_prepTimeMinutesMeta);
    }
    if (data.containsKey('cook_time_minutes')) {
      context.handle(
        _cookTimeMinutesMeta,
        cookTimeMinutes.isAcceptableOrUnknown(
          data['cook_time_minutes']!,
          _cookTimeMinutesMeta,
        ),
      );
    } else if (isInserting) {
      context.missing(_cookTimeMinutesMeta);
    }
    if (data.containsKey('servings')) {
      context.handle(
        _servingsMeta,
        servings.isAcceptableOrUnknown(data['servings']!, _servingsMeta),
      );
    } else if (isInserting) {
      context.missing(_servingsMeta);
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  CachedRecipeDetailsRow map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return CachedRecipeDetailsRow(
      id: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}id'],
      )!,
      name: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}name'],
      )!,
      image: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}image'],
      )!,
      rating: attachedDatabase.typeMapping.read(
        DriftSqlType.double,
        data['${effectivePrefix}rating'],
      )!,
      cuisine: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}cuisine'],
      )!,
      difficulty: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}difficulty'],
      )!,
      caloriesPerServing: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}calories_per_serving'],
      )!,
      prepTimeMinutes: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}prep_time_minutes'],
      )!,
      cookTimeMinutes: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}cook_time_minutes'],
      )!,
      servings: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}servings'],
      )!,
      ingredients: $CachedRecipeDetailsTable.$converteringredients.fromSql(
        attachedDatabase.typeMapping.read(
          DriftSqlType.string,
          data['${effectivePrefix}ingredients'],
        )!,
      ),
      instructions: $CachedRecipeDetailsTable.$converterinstructions.fromSql(
        attachedDatabase.typeMapping.read(
          DriftSqlType.string,
          data['${effectivePrefix}instructions'],
        )!,
      ),
    );
  }

  @override
  $CachedRecipeDetailsTable createAlias(String alias) {
    return $CachedRecipeDetailsTable(attachedDatabase, alias);
  }

  static JsonTypeConverter2<List<String>, String, String>
  $converteringredients = const StringListConverter();
  static JsonTypeConverter2<List<String>, String, String>
  $converterinstructions = const StringListConverter();
}

class CachedRecipeDetailsRow extends DataClass
    implements Insertable<CachedRecipeDetailsRow> {
  final int id;
  final String name;
  final String image;
  final double rating;
  final String cuisine;
  final String difficulty;
  final int caloriesPerServing;
  final int prepTimeMinutes;
  final int cookTimeMinutes;
  final int servings;
  final List<String> ingredients;
  final List<String> instructions;
  const CachedRecipeDetailsRow({
    required this.id,
    required this.name,
    required this.image,
    required this.rating,
    required this.cuisine,
    required this.difficulty,
    required this.caloriesPerServing,
    required this.prepTimeMinutes,
    required this.cookTimeMinutes,
    required this.servings,
    required this.ingredients,
    required this.instructions,
  });
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<int>(id);
    map['name'] = Variable<String>(name);
    map['image'] = Variable<String>(image);
    map['rating'] = Variable<double>(rating);
    map['cuisine'] = Variable<String>(cuisine);
    map['difficulty'] = Variable<String>(difficulty);
    map['calories_per_serving'] = Variable<int>(caloriesPerServing);
    map['prep_time_minutes'] = Variable<int>(prepTimeMinutes);
    map['cook_time_minutes'] = Variable<int>(cookTimeMinutes);
    map['servings'] = Variable<int>(servings);
    {
      map['ingredients'] = Variable<String>(
        $CachedRecipeDetailsTable.$converteringredients.toSql(ingredients),
      );
    }
    {
      map['instructions'] = Variable<String>(
        $CachedRecipeDetailsTable.$converterinstructions.toSql(instructions),
      );
    }
    return map;
  }

  CachedRecipeDetailsCompanion toCompanion(bool nullToAbsent) {
    return CachedRecipeDetailsCompanion(
      id: Value(id),
      name: Value(name),
      image: Value(image),
      rating: Value(rating),
      cuisine: Value(cuisine),
      difficulty: Value(difficulty),
      caloriesPerServing: Value(caloriesPerServing),
      prepTimeMinutes: Value(prepTimeMinutes),
      cookTimeMinutes: Value(cookTimeMinutes),
      servings: Value(servings),
      ingredients: Value(ingredients),
      instructions: Value(instructions),
    );
  }

  factory CachedRecipeDetailsRow.fromJson(
    Map<String, dynamic> json, {
    ValueSerializer? serializer,
  }) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return CachedRecipeDetailsRow(
      id: serializer.fromJson<int>(json['id']),
      name: serializer.fromJson<String>(json['name']),
      image: serializer.fromJson<String>(json['image']),
      rating: serializer.fromJson<double>(json['rating']),
      cuisine: serializer.fromJson<String>(json['cuisine']),
      difficulty: serializer.fromJson<String>(json['difficulty']),
      caloriesPerServing: serializer.fromJson<int>(json['caloriesPerServing']),
      prepTimeMinutes: serializer.fromJson<int>(json['prepTimeMinutes']),
      cookTimeMinutes: serializer.fromJson<int>(json['cookTimeMinutes']),
      servings: serializer.fromJson<int>(json['servings']),
      ingredients: $CachedRecipeDetailsTable.$converteringredients.fromJson(
        serializer.fromJson<String>(json['ingredients']),
      ),
      instructions: $CachedRecipeDetailsTable.$converterinstructions.fromJson(
        serializer.fromJson<String>(json['instructions']),
      ),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<int>(id),
      'name': serializer.toJson<String>(name),
      'image': serializer.toJson<String>(image),
      'rating': serializer.toJson<double>(rating),
      'cuisine': serializer.toJson<String>(cuisine),
      'difficulty': serializer.toJson<String>(difficulty),
      'caloriesPerServing': serializer.toJson<int>(caloriesPerServing),
      'prepTimeMinutes': serializer.toJson<int>(prepTimeMinutes),
      'cookTimeMinutes': serializer.toJson<int>(cookTimeMinutes),
      'servings': serializer.toJson<int>(servings),
      'ingredients': serializer.toJson<String>(
        $CachedRecipeDetailsTable.$converteringredients.toJson(ingredients),
      ),
      'instructions': serializer.toJson<String>(
        $CachedRecipeDetailsTable.$converterinstructions.toJson(instructions),
      ),
    };
  }

  CachedRecipeDetailsRow copyWith({
    int? id,
    String? name,
    String? image,
    double? rating,
    String? cuisine,
    String? difficulty,
    int? caloriesPerServing,
    int? prepTimeMinutes,
    int? cookTimeMinutes,
    int? servings,
    List<String>? ingredients,
    List<String>? instructions,
  }) => CachedRecipeDetailsRow(
    id: id ?? this.id,
    name: name ?? this.name,
    image: image ?? this.image,
    rating: rating ?? this.rating,
    cuisine: cuisine ?? this.cuisine,
    difficulty: difficulty ?? this.difficulty,
    caloriesPerServing: caloriesPerServing ?? this.caloriesPerServing,
    prepTimeMinutes: prepTimeMinutes ?? this.prepTimeMinutes,
    cookTimeMinutes: cookTimeMinutes ?? this.cookTimeMinutes,
    servings: servings ?? this.servings,
    ingredients: ingredients ?? this.ingredients,
    instructions: instructions ?? this.instructions,
  );
  CachedRecipeDetailsRow copyWithCompanion(CachedRecipeDetailsCompanion data) {
    return CachedRecipeDetailsRow(
      id: data.id.present ? data.id.value : this.id,
      name: data.name.present ? data.name.value : this.name,
      image: data.image.present ? data.image.value : this.image,
      rating: data.rating.present ? data.rating.value : this.rating,
      cuisine: data.cuisine.present ? data.cuisine.value : this.cuisine,
      difficulty: data.difficulty.present
          ? data.difficulty.value
          : this.difficulty,
      caloriesPerServing: data.caloriesPerServing.present
          ? data.caloriesPerServing.value
          : this.caloriesPerServing,
      prepTimeMinutes: data.prepTimeMinutes.present
          ? data.prepTimeMinutes.value
          : this.prepTimeMinutes,
      cookTimeMinutes: data.cookTimeMinutes.present
          ? data.cookTimeMinutes.value
          : this.cookTimeMinutes,
      servings: data.servings.present ? data.servings.value : this.servings,
      ingredients: data.ingredients.present
          ? data.ingredients.value
          : this.ingredients,
      instructions: data.instructions.present
          ? data.instructions.value
          : this.instructions,
    );
  }

  @override
  String toString() {
    return (StringBuffer('CachedRecipeDetailsRow(')
          ..write('id: $id, ')
          ..write('name: $name, ')
          ..write('image: $image, ')
          ..write('rating: $rating, ')
          ..write('cuisine: $cuisine, ')
          ..write('difficulty: $difficulty, ')
          ..write('caloriesPerServing: $caloriesPerServing, ')
          ..write('prepTimeMinutes: $prepTimeMinutes, ')
          ..write('cookTimeMinutes: $cookTimeMinutes, ')
          ..write('servings: $servings, ')
          ..write('ingredients: $ingredients, ')
          ..write('instructions: $instructions')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(
    id,
    name,
    image,
    rating,
    cuisine,
    difficulty,
    caloriesPerServing,
    prepTimeMinutes,
    cookTimeMinutes,
    servings,
    ingredients,
    instructions,
  );
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is CachedRecipeDetailsRow &&
          other.id == this.id &&
          other.name == this.name &&
          other.image == this.image &&
          other.rating == this.rating &&
          other.cuisine == this.cuisine &&
          other.difficulty == this.difficulty &&
          other.caloriesPerServing == this.caloriesPerServing &&
          other.prepTimeMinutes == this.prepTimeMinutes &&
          other.cookTimeMinutes == this.cookTimeMinutes &&
          other.servings == this.servings &&
          other.ingredients == this.ingredients &&
          other.instructions == this.instructions);
}

class CachedRecipeDetailsCompanion
    extends UpdateCompanion<CachedRecipeDetailsRow> {
  final Value<int> id;
  final Value<String> name;
  final Value<String> image;
  final Value<double> rating;
  final Value<String> cuisine;
  final Value<String> difficulty;
  final Value<int> caloriesPerServing;
  final Value<int> prepTimeMinutes;
  final Value<int> cookTimeMinutes;
  final Value<int> servings;
  final Value<List<String>> ingredients;
  final Value<List<String>> instructions;
  const CachedRecipeDetailsCompanion({
    this.id = const Value.absent(),
    this.name = const Value.absent(),
    this.image = const Value.absent(),
    this.rating = const Value.absent(),
    this.cuisine = const Value.absent(),
    this.difficulty = const Value.absent(),
    this.caloriesPerServing = const Value.absent(),
    this.prepTimeMinutes = const Value.absent(),
    this.cookTimeMinutes = const Value.absent(),
    this.servings = const Value.absent(),
    this.ingredients = const Value.absent(),
    this.instructions = const Value.absent(),
  });
  CachedRecipeDetailsCompanion.insert({
    this.id = const Value.absent(),
    required String name,
    required String image,
    required double rating,
    required String cuisine,
    required String difficulty,
    required int caloriesPerServing,
    required int prepTimeMinutes,
    required int cookTimeMinutes,
    required int servings,
    required List<String> ingredients,
    required List<String> instructions,
  }) : name = Value(name),
       image = Value(image),
       rating = Value(rating),
       cuisine = Value(cuisine),
       difficulty = Value(difficulty),
       caloriesPerServing = Value(caloriesPerServing),
       prepTimeMinutes = Value(prepTimeMinutes),
       cookTimeMinutes = Value(cookTimeMinutes),
       servings = Value(servings),
       ingredients = Value(ingredients),
       instructions = Value(instructions);
  static Insertable<CachedRecipeDetailsRow> custom({
    Expression<int>? id,
    Expression<String>? name,
    Expression<String>? image,
    Expression<double>? rating,
    Expression<String>? cuisine,
    Expression<String>? difficulty,
    Expression<int>? caloriesPerServing,
    Expression<int>? prepTimeMinutes,
    Expression<int>? cookTimeMinutes,
    Expression<int>? servings,
    Expression<String>? ingredients,
    Expression<String>? instructions,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (name != null) 'name': name,
      if (image != null) 'image': image,
      if (rating != null) 'rating': rating,
      if (cuisine != null) 'cuisine': cuisine,
      if (difficulty != null) 'difficulty': difficulty,
      if (caloriesPerServing != null)
        'calories_per_serving': caloriesPerServing,
      if (prepTimeMinutes != null) 'prep_time_minutes': prepTimeMinutes,
      if (cookTimeMinutes != null) 'cook_time_minutes': cookTimeMinutes,
      if (servings != null) 'servings': servings,
      if (ingredients != null) 'ingredients': ingredients,
      if (instructions != null) 'instructions': instructions,
    });
  }

  CachedRecipeDetailsCompanion copyWith({
    Value<int>? id,
    Value<String>? name,
    Value<String>? image,
    Value<double>? rating,
    Value<String>? cuisine,
    Value<String>? difficulty,
    Value<int>? caloriesPerServing,
    Value<int>? prepTimeMinutes,
    Value<int>? cookTimeMinutes,
    Value<int>? servings,
    Value<List<String>>? ingredients,
    Value<List<String>>? instructions,
  }) {
    return CachedRecipeDetailsCompanion(
      id: id ?? this.id,
      name: name ?? this.name,
      image: image ?? this.image,
      rating: rating ?? this.rating,
      cuisine: cuisine ?? this.cuisine,
      difficulty: difficulty ?? this.difficulty,
      caloriesPerServing: caloriesPerServing ?? this.caloriesPerServing,
      prepTimeMinutes: prepTimeMinutes ?? this.prepTimeMinutes,
      cookTimeMinutes: cookTimeMinutes ?? this.cookTimeMinutes,
      servings: servings ?? this.servings,
      ingredients: ingredients ?? this.ingredients,
      instructions: instructions ?? this.instructions,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<int>(id.value);
    }
    if (name.present) {
      map['name'] = Variable<String>(name.value);
    }
    if (image.present) {
      map['image'] = Variable<String>(image.value);
    }
    if (rating.present) {
      map['rating'] = Variable<double>(rating.value);
    }
    if (cuisine.present) {
      map['cuisine'] = Variable<String>(cuisine.value);
    }
    if (difficulty.present) {
      map['difficulty'] = Variable<String>(difficulty.value);
    }
    if (caloriesPerServing.present) {
      map['calories_per_serving'] = Variable<int>(caloriesPerServing.value);
    }
    if (prepTimeMinutes.present) {
      map['prep_time_minutes'] = Variable<int>(prepTimeMinutes.value);
    }
    if (cookTimeMinutes.present) {
      map['cook_time_minutes'] = Variable<int>(cookTimeMinutes.value);
    }
    if (servings.present) {
      map['servings'] = Variable<int>(servings.value);
    }
    if (ingredients.present) {
      map['ingredients'] = Variable<String>(
        $CachedRecipeDetailsTable.$converteringredients.toSql(
          ingredients.value,
        ),
      );
    }
    if (instructions.present) {
      map['instructions'] = Variable<String>(
        $CachedRecipeDetailsTable.$converterinstructions.toSql(
          instructions.value,
        ),
      );
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('CachedRecipeDetailsCompanion(')
          ..write('id: $id, ')
          ..write('name: $name, ')
          ..write('image: $image, ')
          ..write('rating: $rating, ')
          ..write('cuisine: $cuisine, ')
          ..write('difficulty: $difficulty, ')
          ..write('caloriesPerServing: $caloriesPerServing, ')
          ..write('prepTimeMinutes: $prepTimeMinutes, ')
          ..write('cookTimeMinutes: $cookTimeMinutes, ')
          ..write('servings: $servings, ')
          ..write('ingredients: $ingredients, ')
          ..write('instructions: $instructions')
          ..write(')'))
        .toString();
  }
}

abstract class _$CacheDatabase extends GeneratedDatabase {
  _$CacheDatabase(QueryExecutor e) : super(e);
  $CacheDatabaseManager get managers => $CacheDatabaseManager(this);
  late final $CachedRecipesTable cachedRecipes = $CachedRecipesTable(this);
  late final $CachedRecipeDetailsTable cachedRecipeDetails =
      $CachedRecipeDetailsTable(this);
  @override
  Iterable<TableInfo<Table, Object?>> get allTables =>
      allSchemaEntities.whereType<TableInfo<Table, Object?>>();
  @override
  List<DatabaseSchemaEntity> get allSchemaEntities => [
    cachedRecipes,
    cachedRecipeDetails,
  ];
}

typedef $$CachedRecipesTableCreateCompanionBuilder =
    CachedRecipesCompanion Function({
      required int id,
      required String sort,
      required int position,
      required String name,
      required String image,
      required double rating,
      required String cuisine,
      required String difficulty,
      Value<int> rowid,
    });
typedef $$CachedRecipesTableUpdateCompanionBuilder =
    CachedRecipesCompanion Function({
      Value<int> id,
      Value<String> sort,
      Value<int> position,
      Value<String> name,
      Value<String> image,
      Value<double> rating,
      Value<String> cuisine,
      Value<String> difficulty,
      Value<int> rowid,
    });

class $$CachedRecipesTableFilterComposer
    extends Composer<_$CacheDatabase, $CachedRecipesTable> {
  $$CachedRecipesTableFilterComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnFilters<int> get id => $composableBuilder(
    column: $table.id,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get sort => $composableBuilder(
    column: $table.sort,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<int> get position => $composableBuilder(
    column: $table.position,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get name => $composableBuilder(
    column: $table.name,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get image => $composableBuilder(
    column: $table.image,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<double> get rating => $composableBuilder(
    column: $table.rating,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get cuisine => $composableBuilder(
    column: $table.cuisine,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get difficulty => $composableBuilder(
    column: $table.difficulty,
    builder: (column) => ColumnFilters(column),
  );
}

class $$CachedRecipesTableOrderingComposer
    extends Composer<_$CacheDatabase, $CachedRecipesTable> {
  $$CachedRecipesTableOrderingComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnOrderings<int> get id => $composableBuilder(
    column: $table.id,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get sort => $composableBuilder(
    column: $table.sort,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<int> get position => $composableBuilder(
    column: $table.position,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get name => $composableBuilder(
    column: $table.name,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get image => $composableBuilder(
    column: $table.image,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<double> get rating => $composableBuilder(
    column: $table.rating,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get cuisine => $composableBuilder(
    column: $table.cuisine,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get difficulty => $composableBuilder(
    column: $table.difficulty,
    builder: (column) => ColumnOrderings(column),
  );
}

class $$CachedRecipesTableAnnotationComposer
    extends Composer<_$CacheDatabase, $CachedRecipesTable> {
  $$CachedRecipesTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<int> get id =>
      $composableBuilder(column: $table.id, builder: (column) => column);

  GeneratedColumn<String> get sort =>
      $composableBuilder(column: $table.sort, builder: (column) => column);

  GeneratedColumn<int> get position =>
      $composableBuilder(column: $table.position, builder: (column) => column);

  GeneratedColumn<String> get name =>
      $composableBuilder(column: $table.name, builder: (column) => column);

  GeneratedColumn<String> get image =>
      $composableBuilder(column: $table.image, builder: (column) => column);

  GeneratedColumn<double> get rating =>
      $composableBuilder(column: $table.rating, builder: (column) => column);

  GeneratedColumn<String> get cuisine =>
      $composableBuilder(column: $table.cuisine, builder: (column) => column);

  GeneratedColumn<String> get difficulty => $composableBuilder(
    column: $table.difficulty,
    builder: (column) => column,
  );
}

class $$CachedRecipesTableTableManager
    extends
        RootTableManager<
          _$CacheDatabase,
          $CachedRecipesTable,
          CachedRecipeRow,
          $$CachedRecipesTableFilterComposer,
          $$CachedRecipesTableOrderingComposer,
          $$CachedRecipesTableAnnotationComposer,
          $$CachedRecipesTableCreateCompanionBuilder,
          $$CachedRecipesTableUpdateCompanionBuilder,
          (
            CachedRecipeRow,
            BaseReferences<
              _$CacheDatabase,
              $CachedRecipesTable,
              CachedRecipeRow
            >,
          ),
          CachedRecipeRow,
          PrefetchHooks Function()
        > {
  $$CachedRecipesTableTableManager(
    _$CacheDatabase db,
    $CachedRecipesTable table,
  ) : super(
        TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $$CachedRecipesTableFilterComposer($db: db, $table: table),
          createOrderingComposer: () =>
              $$CachedRecipesTableOrderingComposer($db: db, $table: table),
          createComputedFieldComposer: () =>
              $$CachedRecipesTableAnnotationComposer($db: db, $table: table),
          updateCompanionCallback:
              ({
                Value<int> id = const Value.absent(),
                Value<String> sort = const Value.absent(),
                Value<int> position = const Value.absent(),
                Value<String> name = const Value.absent(),
                Value<String> image = const Value.absent(),
                Value<double> rating = const Value.absent(),
                Value<String> cuisine = const Value.absent(),
                Value<String> difficulty = const Value.absent(),
                Value<int> rowid = const Value.absent(),
              }) => CachedRecipesCompanion(
                id: id,
                sort: sort,
                position: position,
                name: name,
                image: image,
                rating: rating,
                cuisine: cuisine,
                difficulty: difficulty,
                rowid: rowid,
              ),
          createCompanionCallback:
              ({
                required int id,
                required String sort,
                required int position,
                required String name,
                required String image,
                required double rating,
                required String cuisine,
                required String difficulty,
                Value<int> rowid = const Value.absent(),
              }) => CachedRecipesCompanion.insert(
                id: id,
                sort: sort,
                position: position,
                name: name,
                image: image,
                rating: rating,
                cuisine: cuisine,
                difficulty: difficulty,
                rowid: rowid,
              ),
          withReferenceMapper: (p0) => p0
              .map((e) => (e.readTable(table), BaseReferences(db, table, e)))
              .toList(),
          prefetchHooksCallback: null,
        ),
      );
}

typedef $$CachedRecipesTableProcessedTableManager =
    ProcessedTableManager<
      _$CacheDatabase,
      $CachedRecipesTable,
      CachedRecipeRow,
      $$CachedRecipesTableFilterComposer,
      $$CachedRecipesTableOrderingComposer,
      $$CachedRecipesTableAnnotationComposer,
      $$CachedRecipesTableCreateCompanionBuilder,
      $$CachedRecipesTableUpdateCompanionBuilder,
      (
        CachedRecipeRow,
        BaseReferences<_$CacheDatabase, $CachedRecipesTable, CachedRecipeRow>,
      ),
      CachedRecipeRow,
      PrefetchHooks Function()
    >;
typedef $$CachedRecipeDetailsTableCreateCompanionBuilder =
    CachedRecipeDetailsCompanion Function({
      Value<int> id,
      required String name,
      required String image,
      required double rating,
      required String cuisine,
      required String difficulty,
      required int caloriesPerServing,
      required int prepTimeMinutes,
      required int cookTimeMinutes,
      required int servings,
      required List<String> ingredients,
      required List<String> instructions,
    });
typedef $$CachedRecipeDetailsTableUpdateCompanionBuilder =
    CachedRecipeDetailsCompanion Function({
      Value<int> id,
      Value<String> name,
      Value<String> image,
      Value<double> rating,
      Value<String> cuisine,
      Value<String> difficulty,
      Value<int> caloriesPerServing,
      Value<int> prepTimeMinutes,
      Value<int> cookTimeMinutes,
      Value<int> servings,
      Value<List<String>> ingredients,
      Value<List<String>> instructions,
    });

class $$CachedRecipeDetailsTableFilterComposer
    extends Composer<_$CacheDatabase, $CachedRecipeDetailsTable> {
  $$CachedRecipeDetailsTableFilterComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnFilters<int> get id => $composableBuilder(
    column: $table.id,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get name => $composableBuilder(
    column: $table.name,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get image => $composableBuilder(
    column: $table.image,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<double> get rating => $composableBuilder(
    column: $table.rating,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get cuisine => $composableBuilder(
    column: $table.cuisine,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get difficulty => $composableBuilder(
    column: $table.difficulty,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<int> get caloriesPerServing => $composableBuilder(
    column: $table.caloriesPerServing,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<int> get prepTimeMinutes => $composableBuilder(
    column: $table.prepTimeMinutes,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<int> get cookTimeMinutes => $composableBuilder(
    column: $table.cookTimeMinutes,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<int> get servings => $composableBuilder(
    column: $table.servings,
    builder: (column) => ColumnFilters(column),
  );

  ColumnWithTypeConverterFilters<List<String>, List<String>, String>
  get ingredients => $composableBuilder(
    column: $table.ingredients,
    builder: (column) => ColumnWithTypeConverterFilters(column),
  );

  ColumnWithTypeConverterFilters<List<String>, List<String>, String>
  get instructions => $composableBuilder(
    column: $table.instructions,
    builder: (column) => ColumnWithTypeConverterFilters(column),
  );
}

class $$CachedRecipeDetailsTableOrderingComposer
    extends Composer<_$CacheDatabase, $CachedRecipeDetailsTable> {
  $$CachedRecipeDetailsTableOrderingComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnOrderings<int> get id => $composableBuilder(
    column: $table.id,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get name => $composableBuilder(
    column: $table.name,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get image => $composableBuilder(
    column: $table.image,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<double> get rating => $composableBuilder(
    column: $table.rating,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get cuisine => $composableBuilder(
    column: $table.cuisine,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get difficulty => $composableBuilder(
    column: $table.difficulty,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<int> get caloriesPerServing => $composableBuilder(
    column: $table.caloriesPerServing,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<int> get prepTimeMinutes => $composableBuilder(
    column: $table.prepTimeMinutes,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<int> get cookTimeMinutes => $composableBuilder(
    column: $table.cookTimeMinutes,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<int> get servings => $composableBuilder(
    column: $table.servings,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get ingredients => $composableBuilder(
    column: $table.ingredients,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get instructions => $composableBuilder(
    column: $table.instructions,
    builder: (column) => ColumnOrderings(column),
  );
}

class $$CachedRecipeDetailsTableAnnotationComposer
    extends Composer<_$CacheDatabase, $CachedRecipeDetailsTable> {
  $$CachedRecipeDetailsTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<int> get id =>
      $composableBuilder(column: $table.id, builder: (column) => column);

  GeneratedColumn<String> get name =>
      $composableBuilder(column: $table.name, builder: (column) => column);

  GeneratedColumn<String> get image =>
      $composableBuilder(column: $table.image, builder: (column) => column);

  GeneratedColumn<double> get rating =>
      $composableBuilder(column: $table.rating, builder: (column) => column);

  GeneratedColumn<String> get cuisine =>
      $composableBuilder(column: $table.cuisine, builder: (column) => column);

  GeneratedColumn<String> get difficulty => $composableBuilder(
    column: $table.difficulty,
    builder: (column) => column,
  );

  GeneratedColumn<int> get caloriesPerServing => $composableBuilder(
    column: $table.caloriesPerServing,
    builder: (column) => column,
  );

  GeneratedColumn<int> get prepTimeMinutes => $composableBuilder(
    column: $table.prepTimeMinutes,
    builder: (column) => column,
  );

  GeneratedColumn<int> get cookTimeMinutes => $composableBuilder(
    column: $table.cookTimeMinutes,
    builder: (column) => column,
  );

  GeneratedColumn<int> get servings =>
      $composableBuilder(column: $table.servings, builder: (column) => column);

  GeneratedColumnWithTypeConverter<List<String>, String> get ingredients =>
      $composableBuilder(
        column: $table.ingredients,
        builder: (column) => column,
      );

  GeneratedColumnWithTypeConverter<List<String>, String> get instructions =>
      $composableBuilder(
        column: $table.instructions,
        builder: (column) => column,
      );
}

class $$CachedRecipeDetailsTableTableManager
    extends
        RootTableManager<
          _$CacheDatabase,
          $CachedRecipeDetailsTable,
          CachedRecipeDetailsRow,
          $$CachedRecipeDetailsTableFilterComposer,
          $$CachedRecipeDetailsTableOrderingComposer,
          $$CachedRecipeDetailsTableAnnotationComposer,
          $$CachedRecipeDetailsTableCreateCompanionBuilder,
          $$CachedRecipeDetailsTableUpdateCompanionBuilder,
          (
            CachedRecipeDetailsRow,
            BaseReferences<
              _$CacheDatabase,
              $CachedRecipeDetailsTable,
              CachedRecipeDetailsRow
            >,
          ),
          CachedRecipeDetailsRow,
          PrefetchHooks Function()
        > {
  $$CachedRecipeDetailsTableTableManager(
    _$CacheDatabase db,
    $CachedRecipeDetailsTable table,
  ) : super(
        TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $$CachedRecipeDetailsTableFilterComposer($db: db, $table: table),
          createOrderingComposer: () =>
              $$CachedRecipeDetailsTableOrderingComposer(
                $db: db,
                $table: table,
              ),
          createComputedFieldComposer: () =>
              $$CachedRecipeDetailsTableAnnotationComposer(
                $db: db,
                $table: table,
              ),
          updateCompanionCallback:
              ({
                Value<int> id = const Value.absent(),
                Value<String> name = const Value.absent(),
                Value<String> image = const Value.absent(),
                Value<double> rating = const Value.absent(),
                Value<String> cuisine = const Value.absent(),
                Value<String> difficulty = const Value.absent(),
                Value<int> caloriesPerServing = const Value.absent(),
                Value<int> prepTimeMinutes = const Value.absent(),
                Value<int> cookTimeMinutes = const Value.absent(),
                Value<int> servings = const Value.absent(),
                Value<List<String>> ingredients = const Value.absent(),
                Value<List<String>> instructions = const Value.absent(),
              }) => CachedRecipeDetailsCompanion(
                id: id,
                name: name,
                image: image,
                rating: rating,
                cuisine: cuisine,
                difficulty: difficulty,
                caloriesPerServing: caloriesPerServing,
                prepTimeMinutes: prepTimeMinutes,
                cookTimeMinutes: cookTimeMinutes,
                servings: servings,
                ingredients: ingredients,
                instructions: instructions,
              ),
          createCompanionCallback:
              ({
                Value<int> id = const Value.absent(),
                required String name,
                required String image,
                required double rating,
                required String cuisine,
                required String difficulty,
                required int caloriesPerServing,
                required int prepTimeMinutes,
                required int cookTimeMinutes,
                required int servings,
                required List<String> ingredients,
                required List<String> instructions,
              }) => CachedRecipeDetailsCompanion.insert(
                id: id,
                name: name,
                image: image,
                rating: rating,
                cuisine: cuisine,
                difficulty: difficulty,
                caloriesPerServing: caloriesPerServing,
                prepTimeMinutes: prepTimeMinutes,
                cookTimeMinutes: cookTimeMinutes,
                servings: servings,
                ingredients: ingredients,
                instructions: instructions,
              ),
          withReferenceMapper: (p0) => p0
              .map((e) => (e.readTable(table), BaseReferences(db, table, e)))
              .toList(),
          prefetchHooksCallback: null,
        ),
      );
}

typedef $$CachedRecipeDetailsTableProcessedTableManager =
    ProcessedTableManager<
      _$CacheDatabase,
      $CachedRecipeDetailsTable,
      CachedRecipeDetailsRow,
      $$CachedRecipeDetailsTableFilterComposer,
      $$CachedRecipeDetailsTableOrderingComposer,
      $$CachedRecipeDetailsTableAnnotationComposer,
      $$CachedRecipeDetailsTableCreateCompanionBuilder,
      $$CachedRecipeDetailsTableUpdateCompanionBuilder,
      (
        CachedRecipeDetailsRow,
        BaseReferences<
          _$CacheDatabase,
          $CachedRecipeDetailsTable,
          CachedRecipeDetailsRow
        >,
      ),
      CachedRecipeDetailsRow,
      PrefetchHooks Function()
    >;

class $CacheDatabaseManager {
  final _$CacheDatabase _db;
  $CacheDatabaseManager(this._db);
  $$CachedRecipesTableTableManager get cachedRecipes =>
      $$CachedRecipesTableTableManager(_db, _db.cachedRecipes);
  $$CachedRecipeDetailsTableTableManager get cachedRecipeDetails =>
      $$CachedRecipeDetailsTableTableManager(_db, _db.cachedRecipeDetails);
}
