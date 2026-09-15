import 'package:equatable/equatable.dart';

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

  final List<dynamic> recipes;

  // Length is enough to tell two results apart, and the recipes are untyped
  // maps with no equality of their own.
  @override
  List<Object?> get props => [recipes.length];
}

/// The search ran and matched nothing. Its own state, so the page never has to
/// ask whether a loaded list is empty.
class SearchRecipesEmpty extends SearchRecipesState {
  const SearchRecipesEmpty();
}

/// The search failed. It carries no reason: this app has no error handling yet.
class SearchRecipesError extends SearchRecipesState {
  const SearchRecipesError();
}
