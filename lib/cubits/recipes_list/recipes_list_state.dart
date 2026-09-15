import 'package:equatable/equatable.dart';
import 'package:flutter_clean_architecture_steps/widgets/sort_tabs.dart';

/// The state of the recipe list page.
///
/// One slot per sort: the two are independent requests, so one loading or
/// failing says nothing about the other.
class RecipesListState extends Equatable {
  const RecipesListState({
    this.topRated = const RecipesSortInitial(),
    this.mostReviewed = const RecipesSortInitial(),
  });

  final RecipesSortState topRated;
  final RecipesSortState mostReviewed;

  /// The slot belonging to [sort].
  RecipesSortState sortOf(RecipeSort sort) => switch (sort) {
    RecipeSort.topRated => topRated,
    RecipeSort.mostReviewed => mostReviewed,
  };

  RecipesListState copyWith({
    RecipesSortState? topRated,
    RecipesSortState? mostReviewed,
  }) {
    return RecipesListState(
      topRated: topRated ?? this.topRated,
      mostReviewed: mostReviewed ?? this.mostReviewed,
    );
  }

  @override
  List<Object?> get props => [topRated, mostReviewed];
}

/// The state of a single sort's list.
///
/// Sealed, so the UI has to answer for every case.
sealed class RecipesSortState extends Equatable {
  const RecipesSortState();

  /// Declared here, and overridden with a real field by [RecipesSortLoaded],
  /// so the page can ask any state without casting.
  bool get isLoadingMore => false;

  bool get loadMoreFailed => false;

  @override
  List<Object?> get props => [];
}

class RecipesSortInitial extends RecipesSortState {
  const RecipesSortInitial();
}

class RecipesSortLoading extends RecipesSortState {
  const RecipesSortLoading();
}

/// Recipes are on screen.
///
/// Pagination lives here rather than on the cubit, which holds no data at all.
class RecipesSortLoaded extends RecipesSortState {
  const RecipesSortLoaded({
    required this.recipes,
    required this.skip,
    required this.hasMore,
    this.isLoadingMore = false,
    this.loadMoreFailed = false,
  });

  final List<dynamic> recipes;

  /// How many recipes have been read so far, sent as the API's `skip`.
  final int skip;

  final bool hasMore;

  @override
  final bool isLoadingMore;

  /// Set when the next page failed. The recipes on screen stay; the page
  /// shows a message instead of replacing them.
  @override
  final bool loadMoreFailed;

  RecipesSortLoaded copyWith({
    List<dynamic>? recipes,
    int? skip,
    bool? hasMore,
    bool? isLoadingMore,
    bool? loadMoreFailed,
  }) {
    return RecipesSortLoaded(
      recipes: recipes ?? this.recipes,
      skip: skip ?? this.skip,
      hasMore: hasMore ?? this.hasMore,
      isLoadingMore: isLoadingMore ?? this.isLoadingMore,
      loadMoreFailed: loadMoreFailed ?? this.loadMoreFailed,
    );
  }

  // The list only grows, so its length tells two states apart. Comparing the
  // recipes would walk them all on every emit, and they are untyped maps with
  // no equality of their own.
  @override
  List<Object?> get props => [
    recipes.length,
    skip,
    hasMore,
    isLoadingMore,
    loadMoreFailed,
  ];
}

/// The first page came back with no recipes. Its own state, so the page never
/// has to ask whether a loaded list is empty.
class RecipesSortEmpty extends RecipesSortState {
  const RecipesSortEmpty();
}

/// The first page failed, so there is nothing to show. It carries no reason:
/// this app has no error handling yet.
class RecipesSortError extends RecipesSortState {
  const RecipesSortError();
}

extension RecipesSortStateX on RecipesSortState {
  /// The state as the grid sees it, with the load-more flags dropped.
  ///
  /// Those flags belong to the dots below the grid, not to the recipes in it,
  /// but they sit in the same state and in the same `props`. Selecting this
  /// instead means flipping one of them compares equal, so the grid is not
  /// rebuilt with the recipes it already has.
  RecipesSortState get gridState => switch (this) {
    RecipesSortLoaded(:final recipes, :final skip, :final hasMore) =>
      RecipesSortLoaded(recipes: recipes, skip: skip, hasMore: hasMore),
    _ => this,
  };
}
