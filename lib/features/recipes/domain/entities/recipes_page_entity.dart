import 'package:equatable/equatable.dart';
import 'package:flutter_clean_architecture_steps/features/recipes/domain/entities/recipe_entity.dart';

class RecipesPageEntity extends Equatable {
  const RecipesPageEntity({required this.recipes, required this.total});

  final List<RecipeEntity> recipes;

  final int total;

  @override
  List<Object?> get props => [recipes, total];
}
