import 'package:equatable/equatable.dart';
import 'package:flutter_clean_architecture_steps/entities/recipe_entity.dart';
import 'package:flutter_clean_architecture_steps/error/failure.dart';

/// The state of the search page.
///
/// Flat, not composite like the list: there is only ever one search running.
sealed class SearchRecipesState extends Equatable {
  const SearchRecipesState();

  @override
  List<Object?> get props => [];
}

/// Nothing has been searched for yet.
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

/// The search ran and matched nothing. Its own state, so the page never has to
/// ask whether a loaded list is empty.
class SearchRecipesEmpty extends SearchRecipesState {
  const SearchRecipesEmpty();
}

/// The search failed, carrying what to tell the user.
class SearchRecipesError extends SearchRecipesState {
  const SearchRecipesError(this.failure);

  final Failure failure;

  @override
  List<Object?> get props => [failure];
}
