import 'package:equatable/equatable.dart';
import 'package:flutter_clean_architecture_steps/core/error/failure.dart';
import 'package:flutter_clean_architecture_steps/features/recipes/domain/entities/recipe_details_entity.dart';

sealed class RecipeDetailsState extends Equatable {
  const RecipeDetailsState();

  @override
  List<Object?> get props => [];
}

class RecipeDetailsInitial extends RecipeDetailsState {
  const RecipeDetailsInitial();
}

class RecipeDetailsLoading extends RecipeDetailsState {
  const RecipeDetailsLoading();
}

class RecipeDetailsLoaded extends RecipeDetailsState {
  const RecipeDetailsLoaded(this.recipe);

  final RecipeDetailsEntity recipe;

  @override
  List<Object?> get props => [recipe];
}

class RecipeDetailsError extends RecipeDetailsState {
  const RecipeDetailsError(this.failure);

  final Failure failure;

  @override
  List<Object?> get props => [failure];
}
