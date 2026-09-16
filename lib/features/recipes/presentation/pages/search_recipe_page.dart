import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_clean_architecture_steps/core/extensions/build_context_extensions.dart';
import 'package:flutter_clean_architecture_steps/core/network/api_client.dart';
import 'package:flutter_clean_architecture_steps/core/router/app_routes.dart';
import 'package:flutter_clean_architecture_steps/core/widgets/empty_view.dart';
import 'package:flutter_clean_architecture_steps/features/recipes/data/repositories/recipes_repository_impl.dart';
import 'package:flutter_clean_architecture_steps/features/recipes/domain/entities/recipe_entity.dart';
import 'package:flutter_clean_architecture_steps/features/recipes/domain/usecases/search_recipes_usecase.dart';
import 'package:flutter_clean_architecture_steps/features/recipes/presentation/cubits/search_recipes/search_recipes_cubit.dart';
import 'package:flutter_clean_architecture_steps/features/recipes/presentation/cubits/search_recipes/search_recipes_state.dart';
import 'package:flutter_clean_architecture_steps/features/recipes/presentation/widgets/recipes_error_view.dart';
import 'package:flutter_clean_architecture_steps/features/recipes/presentation/widgets/recipes_grid.dart';

/// Builds what the search cubit needs and owns it for as long as this screen
/// is on the stack.
///
/// Stateful only to close the client: the cubit is handed a repository, so
/// closing what the request runs on is the caller's job.
class SearchRecipePage extends StatefulWidget {
  const SearchRecipePage({super.key});

  @override
  State<SearchRecipePage> createState() => _SearchRecipePageState();
}

class _SearchRecipePageState extends State<SearchRecipePage> {
  final ApiClient client = ApiClient();

  @override
  void dispose() {
    client.close();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => SearchRecipesCubit(
        SearchRecipesUseCase(RecipesRepositoryImpl(client)),
      ),
      child: const SearchRecipeView(),
    );
  }
}

class SearchRecipeView extends StatefulWidget {
  const SearchRecipeView({super.key});

  @override
  State<SearchRecipeView> createState() => _SearchRecipeViewState();
}

/// Stateful only for the text controller. The results live in the cubit.
class _SearchRecipeViewState extends State<SearchRecipeView> {
  final TextEditingController controller = TextEditingController();

  @override
  void dispose() {
    controller.dispose();
    super.dispose();
  }

  // Every keystroke, straight through: the debounce lives in the cubit.
  void search(String query) {
    context.read<SearchRecipesCubit>().queryChanged(query);
  }

  void openDetails(RecipeEntity recipe) {
    unawaited(
      context.push(
        AppRoutes.recipeDetails,
        arguments: recipe.id,
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final strings = context.strings;

    return Scaffold(
      appBar: AppBar(
        title: TextField(
          controller: controller,
          autofocus: true,
          decoration: InputDecoration(
            hintText: strings.searchHint,
            border: InputBorder.none,
          ),
          onChanged: search,
        ),
      ),
      body: BlocBuilder<SearchRecipesCubit, SearchRecipesState>(
        builder: (context, state) => switch (state) {
          SearchRecipesInitial() => EmptyView(strings.searchEmptyState),
          SearchRecipesLoading() => RecipesGrid(
            recipes: const [],
            onRecipeTap: openDetails,
            isLoading: true,
          ),
          SearchRecipesLoaded(:final recipes) => RecipesGrid(
            recipes: recipes,
            onRecipeTap: openDetails,
          ),
          SearchRecipesEmpty() => EmptyView(strings.searchNoResults),
          SearchRecipesError(:final failure) => RecipesErrorView(
            failure: failure,
            onRetry: () => context.read<SearchRecipesCubit>().retry(),
          ),
        },
      ),
    );
  }
}
