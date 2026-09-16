import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_clean_architecture_steps/core/extensions/build_context_extensions.dart';
import 'package:flutter_clean_architecture_steps/core/network/api_client.dart';
import 'package:flutter_clean_architecture_steps/core/router/app_routes.dart';
import 'package:flutter_clean_architecture_steps/features/recipes/data/datasources/recipes_remote_data_source.dart';
import 'package:flutter_clean_architecture_steps/features/recipes/data/repositories/recipes_repository_impl.dart';
import 'package:flutter_clean_architecture_steps/features/recipes/domain/entities/recipe_sort.dart';
import 'package:flutter_clean_architecture_steps/features/recipes/domain/usecases/get_recipe_list_usecase.dart';
import 'package:flutter_clean_architecture_steps/features/recipes/presentation/cubits/recipes_list/recipes_list_cubit.dart';
import 'package:flutter_clean_architecture_steps/features/recipes/presentation/widgets/recipes_sort_tab.dart';
import 'package:flutter_clean_architecture_steps/features/recipes/presentation/widgets/sort_tabs.dart';

/// Owns the list cubit for as long as this screen is on the stack.
///
/// No separate view widget: the page reads nothing from the cubit, so it can
/// provide it and sit above it at once.
class RecipeListPage extends StatefulWidget {
  const RecipeListPage({super.key});

  @override
  State<RecipeListPage> createState() => _RecipeListPageState();
}

/// Stateful only for the selected sort. Each tab keeps its own scroll position
/// and reads its own slot; this page only decides which one is on top.
class _RecipeListPageState extends State<RecipeListPage> {
  RecipeSort sortBy = RecipeSort.topRated;

  /// Built here and closed here: the cubit is handed a repository, so closing
  /// what the request runs on is this page's job.
  final ApiClient client = ApiClient();

  void changeSort(RecipeSort value) => setState(() => sortBy = value);

  @override
  void dispose() {
    client.close();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final strings = context.strings;

    return BlocProvider(
      create: (_) =>
          RecipesListCubit(
            GetRecipeListUseCase(
              RecipesRepositoryImpl(RecipesRemoteDataSourceImpl(client)),
            ),
          ),
      child: Scaffold(
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
              // Both tabs stay alive, so switching back shows the recipes and
              // the scroll position the tab already had.
              child: IndexedStack(
                index: sortBy.index,
                sizing: StackFit.expand,
                children: [
                  for (final sort in RecipeSort.values)
                    RecipesSortTab(sort: sort),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
