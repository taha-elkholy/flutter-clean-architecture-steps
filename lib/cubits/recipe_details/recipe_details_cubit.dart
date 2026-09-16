import 'package:flutter_clean_architecture_steps/cubits/base_cubit.dart';
import 'package:flutter_clean_architecture_steps/cubits/recipe_details/recipe_details_state.dart';
import 'package:flutter_clean_architecture_steps/repositories/recipes_repository.dart';

/// Owns the details request for as long as the details page is on the stack,
/// so the recipe dies with the page instead of outliving it.
class RecipeDetailsCubit extends BaseCubit<RecipeDetailsState> {
  RecipeDetailsCubit(this._repository) : super(const RecipeDetailsInitial());

  final RecipesRepository _repository;

  Future<void> fetchDetails(int recipeId) async {
    emit(const RecipeDetailsLoading());

    final result = await _repository.getRecipeDetails(recipeId);

    result.fold(
      onSuccess: (details) => emit(RecipeDetailsLoaded(details)),
      onError: (failure) => emit(RecipeDetailsError(failure)),
    );
  }
}
