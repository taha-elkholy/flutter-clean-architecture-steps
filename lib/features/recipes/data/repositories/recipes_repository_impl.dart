import 'package:flutter_clean_architecture_steps/core/error/failure.dart';
import 'package:flutter_clean_architecture_steps/core/error/map_app_exception.dart';
import 'package:flutter_clean_architecture_steps/core/network/api_client.dart';
import 'package:flutter_clean_architecture_steps/core/result/result.dart';
import 'package:flutter_clean_architecture_steps/features/recipes/data/mappers/recipe_details_mapper.dart';
import 'package:flutter_clean_architecture_steps/features/recipes/data/mappers/recipes_page_mapper.dart';
import 'package:flutter_clean_architecture_steps/features/recipes/data/models/recipe_details_model.dart';
import 'package:flutter_clean_architecture_steps/features/recipes/data/models/recipes_page_model.dart';
import 'package:flutter_clean_architecture_steps/features/recipes/domain/entities/params/get_recipes_params.dart';
import 'package:flutter_clean_architecture_steps/features/recipes/domain/entities/recipe_details_entity.dart';
import 'package:flutter_clean_architecture_steps/features/recipes/domain/entities/recipes_page_entity.dart';
import 'package:flutter_clean_architecture_steps/features/recipes/domain/repositories/recipes_repository.dart';

class RecipesRepositoryImpl implements RecipesRepository {
  const RecipesRepositoryImpl(this._client);

  final ApiClient _client;

  /// The fields the list and search calls ask for, which is what makes the
  /// details call necessary later.
  static const _listFields = 'name,image,rating,cuisine,difficulty';

  @override
  Future<Result<RecipesPageEntity>> getRecipes(GetRecipesParams params) {
    return _read(
      () async => RecipesPageModel.fromMap(
        await _client.get(
          '/recipes',
          queryParameters: {
            'limit': params.limit,
            'skip': params.skip,
            'sortBy': params.sort.queryValue,
            'order': 'desc',
            'select': _listFields,
          },
        ),
      ).toEntity(),
    );
  }

  @override
  Future<Result<RecipesPageEntity>> searchRecipes(String query) {
    return _read(
      () async => RecipesPageModel.fromMap(
        await _client.get(
          '/recipes/search',
          queryParameters: {'q': query, 'select': _listFields},
        ),
      ).toEntity(),
    );
  }

  @override
  Future<Result<RecipeDetailsEntity>> getRecipeDetails(int recipeId) {
    return _read(
      () async => RecipeDetailsModel.fromMap(
        await _client.get('/recipes/$recipeId'),
      ).toEntity(),
    );
  }

  /// Runs [read] and answers with a [Result] either way.
  ///
  /// The only `catch` between Dio and the screen. Parsing is inside, so a body
  /// in the wrong shape is caught here too.
  Future<Result<T>> _read<T>(Future<T> Function() read) async {
    try {
      return Result.success(await read());
    } on Object catch (error) {
      return Result.failed(mapFailure(mapAppException(error)));
    }
  }
}
