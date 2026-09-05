import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_clean_architecture_steps/cubits/recipes_list/recipes_list_cubit.dart';
import 'package:flutter_clean_architecture_steps/cubits/recipes_list/recipes_list_state.dart';
import 'package:flutter_clean_architecture_steps/extensions/build_context_extensions.dart';
import 'package:flutter_clean_architecture_steps/helpers/toast_helpers.dart';
import 'package:flutter_clean_architecture_steps/router/app_routes.dart';
import 'package:flutter_clean_architecture_steps/widgets/empty_view.dart';
import 'package:flutter_clean_architecture_steps/widgets/loading_dots.dart';
import 'package:flutter_clean_architecture_steps/widgets/recipes_error_view.dart';
import 'package:flutter_clean_architecture_steps/widgets/recipes_grid.dart';
import 'package:flutter_clean_architecture_steps/widgets/sort_tabs.dart';

/// Owns the list cubit for as long as this screen is on the stack.
class RecipeListPage extends StatelessWidget {
  const RecipeListPage({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) {
        final cubit = RecipesListCubit();
        unawaited(cubit.fetchRecipes(RecipeSort.topRated));
        return cubit;
      },
      child: const RecipeListView(),
    );
  }
}

class RecipeListView extends StatefulWidget {
  const RecipeListView({super.key});

  @override
  State<RecipeListView> createState() => _RecipeListViewState();
}

/// Stateful only for what the widget owns — the scroll controller and the
/// selected sort. The recipes live in the cubit.
class _RecipeListViewState extends State<RecipeListView> {
  final ScrollController scrollController = ScrollController();
  RecipeSort sortBy = RecipeSort.topRated;

  @override
  void initState() {
    super.initState();
    scrollController.addListener(_onScroll);
  }

  @override
  void dispose() {
    scrollController.dispose();
    super.dispose();
  }

  void _onScroll() {
    if (scrollController.position.pixels >=
        scrollController.position.maxScrollExtent - 100) {
      unawaited(context.read<RecipesListCubit>().loadMore(sortBy));
    }
  }

  void changeSort(RecipeSort value) {
    setState(() => sortBy = value);
    unawaited(context.read<RecipesListCubit>().fetchRecipes(value));
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
        title: Text(strings.appTitle),
        actions: [
          IconButton(
            icon: const Icon(Icons.search),
            onPressed: () {
              unawaited(context.push<void>(AppRoutes.searchRecipe));
            },
          ),
        ],
      ),
      body: Column(
        children: [
          SortTabs(selected: sortBy, onChanged: changeSort),
          Expanded(
            child: RefreshIndicator(
              onRefresh: () => context.read<RecipesListCubit>().refresh(sortBy),
              child: BlocConsumer<RecipesListCubit, RecipesListState>(
                // Only the selected sort's slot concerns this builder.
                buildWhen: (previous, current) =>
                    previous.sortOf(sortBy) != current.sortOf(sortBy),
                // The failure travels inside the loaded state, so the recipes
                // stay on screen and only the message reacts to it. Fires on
                // the transition, so it shows once rather than on every emit
                // while the flag is up.
                listenWhen: (previous, current) =>
                    !previous.sortOf(sortBy).loadMoreFailed &&
                    current.sortOf(sortBy).loadMoreFailed,
                listener: (context, state) =>
                    showToast(context, strings.couldNotLoadMore),
                builder: (context, state) => switch (state.sortOf(sortBy)) {
                  RecipesSortInitial() || RecipesSortLoading() => RecipesGrid(
                    recipes: const [],
                    onRecipeTap: openDetails,
                    isLoading: true,
                    physics: const AlwaysScrollableScrollPhysics(),
                  ),
                  RecipesSortLoaded(:final recipes) => RecipesGrid(
                    recipes: recipes,
                    onRecipeTap: openDetails,
                    scrollController: scrollController,
                    physics: const AlwaysScrollableScrollPhysics(),
                  ),
                  RecipesSortEmpty() => EmptyView(strings.noRecipes),
                  RecipesSortError() => RecipesErrorView(
                    onRetry: () =>
                        context.read<RecipesListCubit>().fetchRecipes(sortBy),
                  ),
                },
              ),
            ),
          ),
          BlocBuilder<RecipesListCubit, RecipesListState>(
            buildWhen: (previous, current) =>
                previous.sortOf(sortBy).isLoadingMore !=
                current.sortOf(sortBy).isLoadingMore,
            builder: (context, state) => state.sortOf(sortBy).isLoadingMore
                ? const Padding(
                    padding: EdgeInsets.all(12),
                    child: LoadingDots(),
                  )
                : const SizedBox.shrink(),
          ),
        ],
      ),
    );
  }
}
