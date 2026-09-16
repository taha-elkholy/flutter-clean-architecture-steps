import 'package:equatable/equatable.dart';
import 'package:flutter_clean_architecture_steps/features/recipes/domain/entities/recipe_entity.dart';

/// One page of recipes, with how many exist behind it.
class RecipesPageEntity extends Equatable {
  const RecipesPageEntity({required this.recipes, required this.total});

  final List<RecipeEntity> recipes;

  /// How many recipes the server has in total, which is what says whether
  /// another page is worth asking for.
  final int total;

  @override
  List<Object?> get props => [recipes, total];
}
