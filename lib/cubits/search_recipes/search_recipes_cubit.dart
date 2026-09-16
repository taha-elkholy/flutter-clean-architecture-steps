import 'dart:async';

import 'package:flutter_clean_architecture_steps/cubits/base_cubit.dart';
import 'package:flutter_clean_architecture_steps/cubits/search_recipes/search_recipes_state.dart';
import 'package:flutter_clean_architecture_steps/error/failure.dart';
import 'package:flutter_clean_architecture_steps/error/map_app_exception.dart';
import 'package:flutter_clean_architecture_steps/repositories/recipes_repository.dart';
import 'package:rxdart/rxdart.dart';

/// Owns the search request for as long as the search page is open.
class SearchRecipesCubit extends BaseCubit<SearchRecipesState> {
  SearchRecipesCubit(this._repository) : super(const SearchRecipesInitial()) {
    // Typing is debounced and deduplicated; a retry skips both, since it is a
    // button rather than a keystroke and repeats a query on purpose. Both end
    // up in the same switchMap, so the two can never race each other.
    _subscription =
        Rx.merge<String>([
              _queries.debounceTime(_debounce).distinct(),
              _retries,
            ])
            // Drops the request still in flight when a newer query arrives, so
            // a slow early result can never land after a later one.
            .switchMap(_search)
            .listen(emit);
  }

  final RecipesRepository _repository;

  static const _debounce = Duration(milliseconds: 400);

  /// Every keystroke goes in here; what comes out the other end is debounced.
  final _queries = PublishSubject<String>();

  final _retries = PublishSubject<String>();

  late final StreamSubscription<SearchRecipesState> _subscription;

  /// The query behind the state on screen, so a retry can repeat it without
  /// the page having to hand it back. Written where the stream reads it, not
  /// where the page writes it, so it is the query that actually ran.
  String _query = '';

  /// Takes the query as typed. The debounce is downstream, so this is cheap to
  /// call on every keystroke.
  void queryChanged(String query) => _queries.add(query);

  /// Runs the last query again.
  void retry() => _retries.add(_query);

  /// One search as a stream, so `switchMap` can cancel it when it is stale.
  Stream<SearchRecipesState> _search(String query) async* {
    if (query.isEmpty) {
      yield const SearchRecipesInitial();
      return;
    }

    _query = query;
    yield const SearchRecipesLoading();

    try {
      final page = await _repository.searchRecipes(query);

      yield page.recipes.isEmpty
          ? const SearchRecipesEmpty()
          : SearchRecipesLoaded(page.recipes);
    } on Object catch (error) {
      yield SearchRecipesError(mapFailure(mapAppException(error)));
    }
  }

  @override
  Future<void> close() async {
    await _subscription.cancel();
    await _queries.close();
    await _retries.close();
    await super.close();
  }
}
