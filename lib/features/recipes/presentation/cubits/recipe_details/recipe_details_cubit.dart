import 'package:flutter_clean_architecture_steps/core/base/base_cubit.dart';
import 'package:flutter_clean_architecture_steps/features/recipes/domain/usecases/get_recipe_details_usecase.dart';
import 'package:flutter_clean_architecture_steps/features/recipes/presentation/cubits/recipe_details/recipe_details_state.dart';

class RecipeDetailsCubit extends BaseCubit<RecipeDetailsState> {
  RecipeDetailsCubit(this._getRecipeDetails)
    : super(const RecipeDetailsInitial());

  final GetRecipeDetailsUseCase _getRecipeDetails;

  Future<void> fetchDetails(int recipeId) async {
    emit(const RecipeDetailsLoading());

    final result = await _getRecipeDetails(recipeId);

    result.fold(
      onSuccess: (details) => emit(RecipeDetailsLoaded(details)),
      onError: (failure) => emit(RecipeDetailsError(failure)),
    );
  }
}
