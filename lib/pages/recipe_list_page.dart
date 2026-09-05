import 'dart:async';
import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_clean_architecture_steps/extensions/build_context_extensions.dart';
import 'package:flutter_clean_architecture_steps/router/app_routes.dart';
import 'package:flutter_clean_architecture_steps/widgets/loading_dots.dart';
import 'package:flutter_clean_architecture_steps/widgets/recipes_grid.dart';
import 'package:flutter_clean_architecture_steps/widgets/sort_tabs.dart';
import 'package:http/http.dart' as http;

class RecipeListPage extends StatefulWidget {
  const RecipeListPage({super.key});

  @override
  State<RecipeListPage> createState() => _RecipeListPageState();
}

class _RecipeListPageState extends State<RecipeListPage> {
  List<dynamic> recipes = [];
  bool isLoading = true;
  bool isLoadingMore = false;
  int skip = 0;
  final int limit = 10;
  int total = 0;
  RecipeSort sortBy = RecipeSort.topRated;
  final ScrollController scrollController = ScrollController();

  @override
  void initState() {
    super.initState();
    unawaited(fetchRecipes());
    scrollController.addListener(() {
      if (scrollController.position.pixels >=
          scrollController.position.maxScrollExtent - 100) {
        unawaited(loadMore());
      }
    });
  }

  Future<void> fetchRecipes() async {
    setState(() {
      isLoading = true;
    });
    final url = Uri.parse(
      'https://dummyjson.com/recipes?limit=$limit&skip=0&sortBy=${sortBy.queryValue}&order=desc&select=name,image,rating,cuisine,difficulty',
    );
    final response = await http.get(url);
    final data = jsonDecode(response.body);
    setState(() {
      recipes = data['recipes'];
      total = data['total'];
      skip = limit;
      isLoading = false;
    });
  }

  Future<void> loadMore() async {
    if (isLoadingMore || skip >= total) return;
    setState(() {
      isLoadingMore = true;
    });
    final url = Uri.parse(
      'https://dummyjson.com/recipes?limit=$limit&skip=$skip&sortBy=${sortBy.queryValue}&order=desc&select=name,image,rating,cuisine,difficulty',
    );
    final response = await http.get(url);
    final data = jsonDecode(response.body);
    setState(() {
      recipes.addAll(data['recipes']);
      skip += limit;
      isLoadingMore = false;
    });
  }

  Future<void> refresh() async {
    final url = Uri.parse(
      'https://dummyjson.com/recipes?limit=$limit&skip=0&sortBy=${sortBy.queryValue}&order=desc&select=name,image,rating,cuisine,difficulty',
    );
    final response = await http.get(url);
    final data = jsonDecode(response.body);
    setState(() {
      recipes = data['recipes'];
      total = data['total'];
      skip = limit;
    });
  }

  void changeSort(RecipeSort value) {
    sortBy = value;
    unawaited(fetchRecipes());
  }

  void openDetails(dynamic recipe) {
    if (isLoading) return;
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
              onRefresh: refresh,
              child: RecipesGrid(
                recipes: recipes,
                onRecipeTap: openDetails,
                isLoading: isLoading,
                scrollController: scrollController,
                physics: const AlwaysScrollableScrollPhysics(),
              ),
            ),
          ),
          if (isLoadingMore)
            const Padding(padding: EdgeInsets.all(12), child: LoadingDots()),
        ],
      ),
    );
  }
}
