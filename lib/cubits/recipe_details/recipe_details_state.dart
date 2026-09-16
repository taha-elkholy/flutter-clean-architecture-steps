import 'package:equatable/equatable.dart';
import 'package:flutter_clean_architecture_steps/entities/recipe_details_entity.dart';
import 'package:flutter_clean_architecture_steps/error/failure.dart';

/// The state of the recipe details page.
///
/// There is no empty case: one recipe is asked for, and it either arrives or
/// the request fails.
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

/// The request failed, carrying what to tell the user.
class RecipeDetailsError extends RecipeDetailsState {
  const RecipeDetailsError(this.failure);

  final Failure failure;

  @override
  List<Object?> get props => [failure];
}
