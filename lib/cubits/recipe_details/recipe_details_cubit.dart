import 'dart:convert';

import 'package:flutter_clean_architecture_steps/cubits/base_cubit.dart';
import 'package:flutter_clean_architecture_steps/cubits/recipe_details/recipe_details_state.dart';
import 'package:http/http.dart' as http;

/// Owns the details request for as long as the details page is on the stack,
/// so the recipe dies with the page instead of outliving it.
class RecipeDetailsCubit extends BaseCubit<RecipeDetailsState> {
  RecipeDetailsCubit({http.Client? client})
    : _client = client ?? http.Client(),
      _ownsClient = client == null,
      super(const RecipeDetailsInitial());

  final http.Client _client;
  final bool _ownsClient;

  Future<void> fetchDetails(int recipeId) async {
    emit(const RecipeDetailsLoading());

    try {
      final url = Uri.parse('https://dummyjson.com/recipes/$recipeId');
      final response = await _client.get(url);
      emit(RecipeDetailsLoaded(jsonDecode(response.body)));
    } on Object {
      emit(const RecipeDetailsError());
    }
  }

  @override
  Future<void> close() {
    if (_ownsClient) _client.close();
    return super.close();
  }
}
