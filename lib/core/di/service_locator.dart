import 'package:flutter_clean_architecture_steps/core/cache/cache_database.dart';
import 'package:flutter_clean_architecture_steps/core/network/api_client.dart';
import 'package:flutter_clean_architecture_steps/features/recipes/data/datasources/recipes_local_data_source.dart';
import 'package:flutter_clean_architecture_steps/features/recipes/data/datasources/recipes_remote_data_source.dart';
import 'package:flutter_clean_architecture_steps/features/recipes/data/repositories/recipes_repository_impl.dart';
import 'package:flutter_clean_architecture_steps/features/recipes/domain/repositories/recipes_repository.dart';
import 'package:flutter_clean_architecture_steps/features/recipes/domain/usecases/get_recipe_details_usecase.dart';
import 'package:flutter_clean_architecture_steps/features/recipes/domain/usecases/get_recipe_list_usecase.dart';
import 'package:flutter_clean_architecture_steps/features/recipes/domain/usecases/search_recipes_usecase.dart';
import 'package:flutter_clean_architecture_steps/features/recipes/presentation/cubits/recipe_details/recipe_details_cubit.dart';
import 'package:flutter_clean_architecture_steps/features/recipes/presentation/cubits/recipes_list/recipes_list_cubit.dart';
import 'package:flutter_clean_architecture_steps/features/recipes/presentation/cubits/search_recipes/search_recipes_cubit.dart';
import 'package:get_it/get_it.dart';

/// The one container the whole app reads its dependencies from.
final GetIt getIt = GetIt.instance;

/// Registers every dependency, newest-first: a thing is registered after what
/// it is built from, so each line below can read what the lines above it left.
///
/// Called once, before `runApp`.
void setupServiceLocator() {
  _registerCore();
  _registerRecipes();
}

/// What the whole app shares, regardless of feature.
///
/// Both are singletons because both are connections. One [CacheDatabase] is a
/// correctness rule rather than a saving: a second one opened on the same file
/// would not see what the first has written.
void _registerCore() {
  getIt
    ..registerLazySingleton<ApiClient>(ApiClient.new)
    ..registerLazySingleton<CacheDatabase>(CacheDatabase.new);
}

void _registerRecipes() {
  getIt
    // Data sources and the repository are registered against their abstract
    // type, so everything above them is handed the contract and never the
    // implementation.
    ..registerLazySingleton<RecipesRemoteDataSource>(
      () => RecipesRemoteDataSourceImpl(getIt()),
    )
    ..registerLazySingleton<RecipesLocalDataSource>(
      () => RecipesLocalDataSourceImpl(getIt()),
    )
    ..registerLazySingleton<RecipesRepository>(
      () => RecipesRepositoryImpl(getIt(), getIt()),
    )
    // Use cases hold no state, so one instance each would do. They are
    // factories anyway: a use case costs nothing to build, and keeping the
    // whole layer one kind of registration is worth more than saving it.
    ..registerFactory<GetRecipeListUseCase>(() => GetRecipeListUseCase(getIt()))
    ..registerFactory<SearchRecipesUseCase>(() => SearchRecipesUseCase(getIt()))
    ..registerFactory<GetRecipeDetailsUseCase>(
      () => GetRecipeDetailsUseCase(getIt()),
    )
    // Cubits are factories because a screen closes the one it was given: a
    // singleton cubit would be closed the first time a screen left the stack
    // and dead for every screen after it.
    ..registerFactory<RecipesListCubit>(() => RecipesListCubit(getIt()))
    ..registerFactory<SearchRecipesCubit>(() => SearchRecipesCubit(getIt()))
    ..registerFactory<RecipeDetailsCubit>(() => RecipeDetailsCubit(getIt()));
}
