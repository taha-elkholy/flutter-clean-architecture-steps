import 'package:flutter_clean_architecture_steps/cubits/base_cubit.dart';
import 'package:flutter_clean_architecture_steps/cubits/recipe_details/recipe_details_state.dart';
import 'package:flutter_clean_architecture_steps/error/failure.dart';
import 'package:flutter_clean_architecture_steps/error/map_app_exception.dart';
import 'package:flutter_clean_architecture_steps/network/api_client.dart';

/// Owns the details request for as long as the details page is on the stack,
/// so the recipe dies with the page instead of outliving it.
class RecipeDetailsCubit extends BaseCubit<RecipeDetailsState> {
  RecipeDetailsCubit() : super(const RecipeDetailsInitial());

  final _client = ApiClient();

  Future<void> fetchDetails(int recipeId) async {
    emit(const RecipeDetailsLoading());

    try {
      emit(RecipeDetailsLoaded(await _client.get('/recipes/$recipeId')));
    } on Object catch (error) {
      emit(RecipeDetailsError(mapFailure(mapAppException(error))));
    }
  }

  @override
  Future<void> close() {
    _client.close();
    return super.close();
  }
}
