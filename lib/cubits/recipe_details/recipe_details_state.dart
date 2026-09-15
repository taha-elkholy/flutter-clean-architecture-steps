import 'package:equatable/equatable.dart';
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

  final dynamic recipe;

  // The recipe is an untyped map with no equality of its own, so identity is
  // all there is to compare. A new fetch always brings a new map. Once it
  // becomes an entity with real equality, this goes back to being the recipe.
  @override
  List<Object?> get props => [identityHashCode(recipe)];
}

/// The request failed, carrying what to tell the user.
class RecipeDetailsError extends RecipeDetailsState {
  const RecipeDetailsError(this.failure);

  final Failure failure;

  @override
  List<Object?> get props => [failure];
}
