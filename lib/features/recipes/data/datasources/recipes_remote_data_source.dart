import 'package:flutter_clean_architecture_steps/core/error/map_app_exception.dart';
import 'package:flutter_clean_architecture_steps/core/network/api_client.dart';
import 'package:flutter_clean_architecture_steps/features/recipes/data/models/recipe_details_model.dart';
import 'package:flutter_clean_architecture_steps/features/recipes/data/models/recipes_page_model.dart';
import 'package:flutter_clean_architecture_steps/features/recipes/domain/entities/params/get_recipes_params.dart';
import 'package:injectable/injectable.dart';

abstract class RecipesRemoteDataSource {
  Future<RecipesPageModel> getRecipes(GetRecipesParams params);

  Future<RecipesPageModel> searchRecipes(String query);

  Future<RecipeDetailsModel> getRecipeDetails(int recipeId);
}

@LazySingleton(as: RecipesRemoteDataSource)
class RecipesRemoteDataSourceImpl implements RecipesRemoteDataSource {
  const RecipesRemoteDataSourceImpl(this._client);

  final ApiClient _client;

  /// The fields the list and search calls ask for, which is what makes the
  /// details call necessary later.
  static const _listFields = 'name,image,rating,cuisine,difficulty';

  @override
  Future<RecipesPageModel> getRecipes(GetRecipesParams params) {
    return _read(() async {
      final response = await _client.get(
        '/recipes',
        queryParameters: {
          'limit': params.limit,
          'skip': params.skip,
          'sortBy': params.sort.queryValue,
          'order': 'desc',
          'select': _listFields,
        },
      );

      return RecipesPageModel.fromMap(response);
    });
  }

  @override
  Future<RecipesPageModel> searchRecipes(String query) {
    return _read(() async {
      final response = await _client.get(
        '/recipes/search',
        queryParameters: {'q': query, 'select': _listFields},
      );

      return RecipesPageModel.fromMap(response);
    });
  }

  @override
  Future<RecipeDetailsModel> getRecipeDetails(int recipeId) {
    return _read(() async {
      final response = await _client.get('/recipes/$recipeId');

      return RecipeDetailsModel.fromMap(response);
    });
  }

  /// Runs [read] and rethrows whatever it threw as a named AppException.
  ///
  /// Parsing is inside, so a body in the wrong shape is named here too. Dio
  /// stops at this line: nothing above the data source sees it.
  Future<T> _read<T>(Future<T> Function() read) async {
    try {
      return await read();
    } on Object catch (error) {
      throw mapAppException(error);
    }
  }
}
