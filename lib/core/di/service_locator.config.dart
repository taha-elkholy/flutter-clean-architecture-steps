// GENERATED CODE - DO NOT MODIFY BY HAND
// dart format width=80

// **************************************************************************
// InjectableConfigGenerator
// **************************************************************************

// ignore_for_file: type=lint
// coverage:ignore-file

// ignore_for_file: no_leading_underscores_for_library_prefixes

import 'package:flutter_clean_architecture_steps/core/cache/cache_database.dart'
    as _i1001;
import 'package:flutter_clean_architecture_steps/core/network/api_client.dart'
    as _i750;
import 'package:flutter_clean_architecture_steps/features/recipes/data/datasources/recipes_local_data_source.dart'
    as _i200;
import 'package:flutter_clean_architecture_steps/features/recipes/data/datasources/recipes_remote_data_source.dart'
    as _i703;
import 'package:flutter_clean_architecture_steps/features/recipes/data/repositories/recipes_repository_impl.dart'
    as _i990;
import 'package:flutter_clean_architecture_steps/features/recipes/domain/repositories/recipes_repository.dart'
    as _i380;
import 'package:flutter_clean_architecture_steps/features/recipes/domain/usecases/get_recipe_details_usecase.dart'
    as _i414;
import 'package:flutter_clean_architecture_steps/features/recipes/domain/usecases/get_recipe_list_usecase.dart'
    as _i27;
import 'package:flutter_clean_architecture_steps/features/recipes/domain/usecases/search_recipes_usecase.dart'
    as _i633;
import 'package:flutter_clean_architecture_steps/features/recipes/presentation/cubits/recipe_details/recipe_details_cubit.dart'
    as _i128;
import 'package:flutter_clean_architecture_steps/features/recipes/presentation/cubits/recipes_list/recipes_list_cubit.dart'
    as _i89;
import 'package:flutter_clean_architecture_steps/features/recipes/presentation/cubits/search_recipes/search_recipes_cubit.dart'
    as _i746;
import 'package:get_it/get_it.dart' as _i174;
import 'package:injectable/injectable.dart' as _i526;

extension GetItInjectableX on _i174.GetIt {
  // initializes the registration of main-scope dependencies inside of GetIt
  _i174.GetIt init({
    String? environment,
    _i526.EnvironmentFilter? environmentFilter,
  }) {
    final gh = _i526.GetItHelper(this, environment, environmentFilter);
    gh.lazySingleton<_i1001.CacheDatabase>(() => _i1001.CacheDatabase());
    gh.lazySingleton<_i750.ApiClient>(() => _i750.ApiClient());
    gh.lazySingleton<_i703.RecipesRemoteDataSource>(
      () => _i703.RecipesRemoteDataSourceImpl(gh<_i750.ApiClient>()),
    );
    gh.lazySingleton<_i200.RecipesLocalDataSource>(
      () => _i200.RecipesLocalDataSourceImpl(gh<_i1001.CacheDatabase>()),
    );
    gh.lazySingleton<_i380.RecipesRepository>(
      () => _i990.RecipesRepositoryImpl(
        gh<_i703.RecipesRemoteDataSource>(),
        gh<_i200.RecipesLocalDataSource>(),
      ),
    );
    gh.factory<_i414.GetRecipeDetailsUseCase>(
      () => _i414.GetRecipeDetailsUseCase(gh<_i380.RecipesRepository>()),
    );
    gh.factory<_i27.GetRecipeListUseCase>(
      () => _i27.GetRecipeListUseCase(gh<_i380.RecipesRepository>()),
    );
    gh.factory<_i633.SearchRecipesUseCase>(
      () => _i633.SearchRecipesUseCase(gh<_i380.RecipesRepository>()),
    );
    gh.factory<_i89.RecipesListCubit>(
      () => _i89.RecipesListCubit(gh<_i27.GetRecipeListUseCase>()),
    );
    gh.factory<_i746.SearchRecipesCubit>(
      () => _i746.SearchRecipesCubit(gh<_i633.SearchRecipesUseCase>()),
    );
    gh.factory<_i128.RecipeDetailsCubit>(
      () => _i128.RecipeDetailsCubit(gh<_i414.GetRecipeDetailsUseCase>()),
    );
    return this;
  }
}
