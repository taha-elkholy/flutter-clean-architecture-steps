import 'package:equatable/equatable.dart';
import 'package:flutter_clean_architecture_steps/features/recipes/domain/entities/recipe_sort.dart';

/// What one page of recipes is asked for by.
class GetRecipesParams extends Equatable {
  const GetRecipesParams({
    required this.sort,
    required this.skip,
    required this.limit,
  });

  final RecipeSort sort;

  /// How many recipes to pass over before reading.
  final int skip;

  final int limit;

  @override
  List<Object?> get props => [sort, skip, limit];
}
