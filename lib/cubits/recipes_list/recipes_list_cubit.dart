import 'dart:convert';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_clean_architecture_steps/cubits/recipes_list/recipes_list_state.dart';
import 'package:flutter_clean_architecture_steps/widgets/sort_tabs.dart';
import 'package:http/http.dart' as http;

/// Owns the first page, pagination and refresh for each of the two sorts.
///
/// It holds no data: everything the list knows about itself lives in
/// [RecipesListState].
class RecipesListCubit extends Cubit<RecipesListState> {
  RecipesListCubit({http.Client? client})
    : _client = client ?? http.Client(),
      _ownsClient = client == null,
      super(const RecipesListState());

  final http.Client _client;
  final bool _ownsClient;

  static const _pageSize = 10;

  /// Loads the first page of [sort], replacing whatever that slot held.
  Future<void> fetchRecipes(RecipeSort sort) async {
    _emitFor(sort, const RecipesSortLoading());

    try {
      _emitFor(sort, await _firstPage(sort));
    } on Object {
      _emitFor(sort, const RecipesSortError());
    }
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
      current.copyWith(isLoadingMore: true, loadMoreFailed: false),
    );

    try {
      final data = await _getPage(sort: sort, skip: current.skip);
      final newRecipes = data['recipes'] as List<dynamic>;
      final skip = current.skip + newRecipes.length;
      _emitFor(
        sort,
        current.copyWith(
          recipes: [...current.recipes, ...newRecipes],
          skip: skip,
          hasMore: skip < (data['total'] as int),
          isLoadingMore: false,
        ),
      );
    } on Object {
      // Only the attempt failed; the recipes on screen stay.
      _emitFor(
        sort,
        current.copyWith(isLoadingMore: false, loadMoreFailed: true),
      );
    }
  }

  /// Re-reads the first page of [sort]. Emits no loading state: pull-to-refresh
  /// draws its own spinner, so the recipes stay visible until replaced.
  Future<void> refresh(RecipeSort sort) async {
    try {
      _emitFor(sort, await _firstPage(sort));
    } on Object {
      // A failed refresh leaves the list exactly as it was.
    }
  }

  /// Reads page one of [sort] and turns it into the state it belongs in.
  Future<RecipesSortState> _firstPage(RecipeSort sort) async {
    final data = await _getPage(sort: sort, skip: 0);
    final recipes = data['recipes'] as List<dynamic>;
    if (recipes.isEmpty) return const RecipesSortEmpty();

    return RecipesSortLoaded(
      recipes: recipes,
      skip: recipes.length,
      hasMore: recipes.length < (data['total'] as int),
    );
  }

  Future<Map<String, dynamic>> _getPage({
    required RecipeSort sort,
    required int skip,
  }) async {
    final url = Uri.parse(
      'https://dummyjson.com/recipes?limit=$_pageSize&skip=$skip'
      '&sortBy=${sort.queryValue}&order=desc'
      '&select=name,image,rating,cuisine,difficulty',
    );
    final response = await _client.get(url);
    return jsonDecode(response.body) as Map<String, dynamic>;
  }

  void _emitFor(RecipeSort sort, RecipesSortState sortState) {
    emit(
      switch (sort) {
        RecipeSort.topRated => state.copyWith(topRated: sortState),
        RecipeSort.mostReviewed => state.copyWith(mostReviewed: sortState),
      },
    );
  }

  @override
  Future<void> close() {
    if (_ownsClient) _client.close();
    return super.close();
  }
}
