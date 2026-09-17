import 'package:equatable/equatable.dart';
import 'package:flutter_clean_architecture_steps/core/error/failure.dart';
import 'package:flutter_clean_architecture_steps/features/recipes/domain/entities/recipe_entity.dart';

sealed class SearchRecipesState extends Equatable {
  const SearchRecipesState();

  @override
  List<Object?> get props => [];
}

class SearchRecipesInitial extends SearchRecipesState {
  const SearchRecipesInitial();
}

class SearchRecipesLoading extends SearchRecipesState {
  const SearchRecipesLoading();
}

class SearchRecipesLoaded extends SearchRecipesState {
  const SearchRecipesLoaded(this.recipes);

  final List<RecipeEntity> recipes;

  @override
  List<Object?> get props => [recipes];
}

class SearchRecipesEmpty extends SearchRecipesState {
  const SearchRecipesEmpty();
}

class SearchRecipesError extends SearchRecipesState {
  const SearchRecipesError(this.failure);

  final Failure failure;

  @override
  List<Object?> get props => [failure];
}
