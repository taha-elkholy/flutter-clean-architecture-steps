import 'package:flutter_clean_architecture_steps/entities/params/get_recipes_params.dart';
import 'package:flutter_clean_architecture_steps/entities/recipe_details_entity.dart';
import 'package:flutter_clean_architecture_steps/entities/recipes_page_entity.dart';
import 'package:flutter_clean_architecture_steps/error/map_app_exception.dart';
import 'package:flutter_clean_architecture_steps/mappers/recipe_details_mapper.dart';
import 'package:flutter_clean_architecture_steps/mappers/recipes_page_mapper.dart';
import 'package:flutter_clean_architecture_steps/models/recipe_details_model.dart';
import 'package:flutter_clean_architecture_steps/models/recipes_page_model.dart';
import 'package:flutter_clean_architecture_steps/network/api_client.dart';
import 'package:flutter_clean_architecture_steps/repositories/recipes_repository.dart';

/// Answers the repository with the one [ApiClient] it is handed.
///
/// It owns the paths, the query parameters and the parsing, so a cubit never
/// sees a url or a json map. The client is passed in, and whoever created it
/// closes it.
class RecipesRepositoryImpl implements RecipesRepository {
  const RecipesRepositoryImpl(this._client);

  final ApiClient _client;

  /// The fields the list and search calls ask for, which is what makes the
  /// details call necessary later.
  static const _listFields = 'name,image,rating,cuisine,difficulty';

  @override
  Future<RecipesPageEntity> getRecipes(GetRecipesParams params) {
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
  Future<RecipesPageEntity> searchRecipes(String query) {
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
  Future<RecipeDetailsEntity> getRecipeDetails(int recipeId) {
    return _read(
      () async => RecipeDetailsModel.fromMap(
        await _client.get('/recipes/$recipeId'),
      ).toEntity(),
    );
  }

  /// Runs [read] and lets only an `AppException` out of it.
  ///
  /// Parsing is inside, so a body in the wrong shape is named here rather than
  /// surfacing as a raw cast error somewhere above.
  Future<T> _read<T>(Future<T> Function() read) async {
    try {
      return await read();
    } on Object catch (error) {
      throw mapAppException(error);
    }
  }
}
