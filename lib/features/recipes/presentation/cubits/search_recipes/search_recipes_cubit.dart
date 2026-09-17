import 'dart:async';

import 'package:flutter_clean_architecture_steps/core/base/base_cubit.dart';
import 'package:flutter_clean_architecture_steps/features/recipes/domain/usecases/search_recipes_usecase.dart';
import 'package:flutter_clean_architecture_steps/features/recipes/presentation/cubits/search_recipes/search_recipes_state.dart';
import 'package:injectable/injectable.dart';
import 'package:rxdart/rxdart.dart';

@injectable
class SearchRecipesCubit extends BaseCubit<SearchRecipesState> {
  SearchRecipesCubit(this._searchRecipes)
    : super(const SearchRecipesInitial()) {
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

  final SearchRecipesUseCase _searchRecipes;

  static const _debounce = Duration(milliseconds: 400);

  final _queries = PublishSubject<String>();

  final _retries = PublishSubject<String>();

  late final StreamSubscription<SearchRecipesState> _subscription;

  /// The query behind the state on screen, so a retry can repeat it without
  /// the page having to hand it back. Written where the stream reads it, not
  /// where the page writes it, so it is the query that actually ran.
  String _query = '';

  /// The debounce is downstream, so this is cheap to call on every keystroke.
  void queryChanged(String query) => _queries.add(query);

  void retry() => _retries.add(_query);

  /// One search as a stream, so `switchMap` can cancel it when it is stale.
  Stream<SearchRecipesState> _search(String query) async* {
    // An empty box is not a search that found nothing: it is no search at all,
    // so it gets the initial view rather than the empty one. Nothing is asked
    // for either, which is why no use case has to refuse an empty query.
    if (query.isEmpty) {
      yield const SearchRecipesInitial();
      return;
    }

    _query = query;
    yield const SearchRecipesLoading();

    final result = await _searchRecipes(query);

    yield result.fold(
      onSuccess: (page) => page.recipes.isEmpty
          ? const SearchRecipesEmpty()
          : SearchRecipesLoaded(page.recipes),
      onError: SearchRecipesError.new,
    );
  }

  @override
  Future<void> close() async {
    await _subscription.cancel();
    await _queries.close();
    await _retries.close();
    await super.close();
  }
}
