import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_clean_architecture_steps/cubits/recipes_list/recipes_list_cubit.dart';
import 'package:flutter_clean_architecture_steps/extensions/build_context_extensions.dart';
import 'package:flutter_clean_architecture_steps/router/app_routes.dart';
import 'package:flutter_clean_architecture_steps/widgets/recipes_sort_tab.dart';
import 'package:flutter_clean_architecture_steps/widgets/sort_tabs.dart';

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

  void changeSort(RecipeSort value) => setState(() => sortBy = value);

  @override
  Widget build(BuildContext context) {
    final strings = context.strings;

    return BlocProvider(
      create: (_) => RecipesListCubit(),
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
