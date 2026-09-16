import 'package:flutter_clean_architecture_steps/cubits/base_cubit.dart';
import 'package:flutter_clean_architecture_steps/cubits/recipes_list/recipes_list_state.dart';
import 'package:flutter_clean_architecture_steps/entities/params/get_recipes_params.dart';
import 'package:flutter_clean_architecture_steps/entities/recipe_sort.dart';
import 'package:flutter_clean_architecture_steps/entities/recipes_page_entity.dart';
import 'package:flutter_clean_architecture_steps/error/result.dart';
import 'package:flutter_clean_architecture_steps/repositories/recipes_repository.dart';

/// Owns the first page, pagination and refresh for each of the two sorts.
///
/// It holds no data: everything the list knows about itself lives in
/// [RecipesListState].
class RecipesListCubit extends BaseCubit<RecipesListState> {
  RecipesListCubit(this._repository) : super(const RecipesListState());

  final RecipesRepository _repository;

  static const _pageSize = 10;

  /// Loads the first page of [sort], replacing whatever that slot held.
  Future<void> fetchRecipes(RecipeSort sort) async {
    _emitFor(sort, const RecipesSortLoading());
    _emitFor(sort, await _firstPage(sort));
  }

  /// Loads [sort] only if it has never been read. This is what the two slots
  /// buy: switching tabs shows what is already there instead of fetching it
  /// again.
  Future<void> fetchIfNeeded(RecipeSort sort) async {
    if (state.sortOf(sort) is! RecipesSortInitial) return;
    await fetchRecipes(sort);
  }

  /// Appends the next page to [sort]. Does nothing unless that sort is loaded
  /// with more to read, so the scroll listener can call it freely.
  Future<void> loadMore(RecipeSort sort) async {
    final current = state.sortOf(sort);
    if (current is! RecipesSortLoaded) return;
    if (!current.hasMore || current.isLoadingMore) return;

    // This also clears any previous failure: nothing else has to reset it.
    _emitFor(
      sort,
      current.copyWith(isLoadingMore: true, loadMoreFailure: null),
    );

    final result = await _getPage(sort: sort, skip: current.skip);

    _emitFor(
      sort,
      result.fold(
        onSuccess: (page) {
          final skip = current.skip + page.recipes.length;

          return current.copyWith(
            recipes: [...current.recipes, ...page.recipes],
            skip: skip,
            hasMore: skip < page.total,
            isLoadingMore: false,
            loadMoreFailure: null,
          );
        },
        // Only the attempt failed; the recipes on screen stay.
        onError: (failure) => current.copyWith(
          isLoadingMore: false,
          loadMoreFailure: failure,
        ),
      ),
    );
  }

  /// Re-reads the first page of [sort]. Emits no loading state: pull-to-refresh
  /// draws its own spinner, so the recipes stay visible until replaced.
  Future<void> refresh(RecipeSort sort) async {
    final result = await _getPage(sort: sort, skip: 0);
    final current = state.sortOf(sort);

    _emitFor(
      sort,
      result.fold(
        onSuccess: _loadedOrEmpty,
        // The recipes on screen stay; only a message says the refresh failed.
        onError: (failure) => current is RecipesSortLoaded
            ? current.copyWith(loadMoreFailure: failure)
            : current,
      ),
    );
  }

  /// Reads page one of [sort] and turns it into the state it belongs in.
  Future<RecipesSortState> _firstPage(RecipeSort sort) async {
    final result = await _getPage(sort: sort, skip: 0);

    return result.fold(
      onSuccess: _loadedOrEmpty,
      onError: RecipesSortError.new,
    );
  }

  RecipesSortState _loadedOrEmpty(RecipesPageEntity page) {
    if (page.recipes.isEmpty) return const RecipesSortEmpty();

    return RecipesSortLoaded(
      recipes: page.recipes,
      skip: page.recipes.length,
      hasMore: page.recipes.length < page.total,
    );
  }

  Future<Result<RecipesPageEntity>> _getPage({
    required RecipeSort sort,
    required int skip,
  }) {
    return _repository.getRecipes(
      GetRecipesParams(sort: sort, skip: skip, limit: _pageSize),
    );
  }

  void _emitFor(RecipeSort sort, RecipesSortState sortState) {
    emit(
      switch (sort) {
        RecipeSort.topRated => state.copyWith(topRated: sortState),
        RecipeSort.mostReviewed => state.copyWith(mostReviewed: sortState),
      },
    );
  }
}
