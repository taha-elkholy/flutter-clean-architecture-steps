import 'dart:convert';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_clean_architecture_steps/cubits/search_recipes/search_recipes_state.dart';
import 'package:http/http.dart' as http;

/// Owns the search request for as long as the search page is open.
class SearchRecipesCubit extends Cubit<SearchRecipesState> {
  SearchRecipesCubit({http.Client? client})
    : _client = client ?? http.Client(),
      _ownsClient = client == null,
      super(const SearchRecipesInitial());

  final http.Client _client;
  final bool _ownsClient;

  /// The query behind the state on screen, so a retry can repeat it without
  /// the page having to hand it back.
  String _query = '';

  Future<void> search(String query) async {
    if (query.isEmpty) return;
    _query = query;
    emit(const SearchRecipesLoading());

    try {
      final url = Uri.parse(
        'https://dummyjson.com/recipes/search?q=$query'
        '&select=name,image,rating,cuisine,difficulty',
      );
      final response = await _client.get(url);
      final data = jsonDecode(response.body) as Map<String, dynamic>;
      final recipes = data['recipes'] as List<dynamic>;

      emit(
        recipes.isEmpty
            ? const SearchRecipesEmpty()
            : SearchRecipesLoaded(recipes),
      );
    } on Object {
      emit(const SearchRecipesError());
    }
  }

  /// Runs the last query again.
  Future<void> retry() => search(_query);

  @override
  Future<void> close() {
    if (_ownsClient) _client.close();
    return super.close();
  }
}
