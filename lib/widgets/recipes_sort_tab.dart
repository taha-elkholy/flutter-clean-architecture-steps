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

/// One tab of the recipe list: everything that belongs to a single [sort].
///
/// Both tabs are alive at once inside the page's `IndexedStack`, so each needs
/// its own scroll controller and reads only its own slot. The page keeps the
/// index and nothing else.
class RecipesSortTab extends StatefulWidget {
  const RecipesSortTab({required this.sort, super.key});

  final RecipeSort sort;

  @override
  State<RecipesSortTab> createState() => _RecipesSortTabState();
}

class _RecipesSortTabState extends State<RecipesSortTab> {
  final ScrollController scrollController = ScrollController();

  @override
  void initState() {
    super.initState();
    scrollController.addListener(_onScroll);
    // The tab asks for its own first page. Switching tabs no longer builds
    // this widget again, so this runs once per tab.
    unawaited(context.read<RecipesListCubit>().fetchIfNeeded(widget.sort));
  }

  @override
  void dispose() {
    scrollController.dispose();
    super.dispose();
  }

  void _onScroll() {
    if (scrollController.position.pixels >=
        scrollController.position.maxScrollExtent - 100) {
      unawaited(context.read<RecipesListCubit>().loadMore(widget.sort));
    }
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

    return Column(
      children: [
        Expanded(
          child: RefreshIndicator(
            onRefresh: () =>
                context.read<RecipesListCubit>().refresh(widget.sort),
            child: BlocConsumer<RecipesListCubit, RecipesListState>(
              // Only this tab's slot concerns this builder.
              buildWhen: (previous, current) =>
                  previous.sortOf(widget.sort) != current.sortOf(widget.sort),
              // The failure travels inside the loaded state, so the recipes
              // stay on screen and only the message reacts to it. Fires on
              // the transition, so it shows once rather than on every emit
              // while the flag is up.
              listenWhen: (previous, current) =>
                  !previous.sortOf(widget.sort).loadMoreFailed &&
                  current.sortOf(widget.sort).loadMoreFailed,
              listener: (context, state) =>
                  showToast(context, strings.couldNotLoadMore),
              builder: (context, state) => switch (state.sortOf(widget.sort)) {
                RecipesSortInitial() || RecipesSortLoading() => RecipesGrid(
                  recipes: const [],
                  onRecipeTap: openDetails,
                  isLoading: true,
                ),
                RecipesSortLoaded(:final recipes) => RecipesGrid(
                  recipes: recipes,
                  onRecipeTap: openDetails,
                  scrollController: scrollController,
                ),
                RecipesSortEmpty() => EmptyView(strings.noRecipes),
                RecipesSortError() => RecipesErrorView(
                  onRetry: () => context.read<RecipesListCubit>().fetchRecipes(
                    widget.sort,
                  ),
                ),
              },
            ),
          ),
        ),
        BlocBuilder<RecipesListCubit, RecipesListState>(
          buildWhen: (previous, current) =>
              previous.sortOf(widget.sort).isLoadingMore !=
              current.sortOf(widget.sort).isLoadingMore,
          builder: (context, state) => state.sortOf(widget.sort).isLoadingMore
              ? const Padding(
                  padding: EdgeInsets.all(12),
                  child: LoadingDots(),
                )
              : const SizedBox.shrink(),
        ),
      ],
    );
  }
}
