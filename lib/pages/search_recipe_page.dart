import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_clean_architecture_steps/cubits/search_recipes/search_recipes_cubit.dart';
import 'package:flutter_clean_architecture_steps/cubits/search_recipes/search_recipes_state.dart';
import 'package:flutter_clean_architecture_steps/extensions/build_context_extensions.dart';
import 'package:flutter_clean_architecture_steps/router/app_routes.dart';
import 'package:flutter_clean_architecture_steps/widgets/empty_view.dart';
import 'package:flutter_clean_architecture_steps/widgets/recipes_error_view.dart';
import 'package:flutter_clean_architecture_steps/widgets/recipes_grid.dart';

/// Owns the search cubit for as long as this screen is on the stack, so the
/// results die with the page instead of outliving it.
class SearchRecipePage extends StatelessWidget {
  const SearchRecipePage({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => SearchRecipesCubit(),
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

  // NOTE: search only runs on submit (Enter) for now.
  // Live-as-you-type search needs debouncing, and that's a deliberate
  // problem left for a later branch, not an oversight here.
  void search(String query) {
    unawaited(context.read<SearchRecipesCubit>().search(query));
  }

  void openDetails(dynamic recipe) {
    unawaited(
      context.push(
        AppRoutes.recipeDetails,
        arguments: recipe['id'],
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
          onSubmitted: search,
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
          SearchRecipesError() => RecipesErrorView(
            onRetry: () => context.read<SearchRecipesCubit>().retry(),
          ),
        },
      ),
    );
  }
}
