import 'dart:async';
import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_clean_architecture_steps/extensions/build_context_extensions.dart';
import 'package:flutter_clean_architecture_steps/router/app_routes.dart';
import 'package:flutter_clean_architecture_steps/widgets/loading_dots.dart';
import 'package:flutter_clean_architecture_steps/widgets/recipe_grid_card.dart';
import 'package:http/http.dart' as http;
import 'package:skeletonizer/skeletonizer.dart';

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
  String sortBy = 'rating';
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
      'https://dummyjson.com/recipes?limit=$limit&skip=0&sortBy=$sortBy&order=desc&select=name,image,rating,cuisine,difficulty',
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
      'https://dummyjson.com/recipes?limit=$limit&skip=$skip&sortBy=$sortBy&order=desc&select=name,image,rating,cuisine,difficulty',
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
      'https://dummyjson.com/recipes?limit=$limit&skip=0&sortBy=$sortBy&order=desc&select=name,image,rating,cuisine,difficulty',
    );
    final response = await http.get(url);
    final data = jsonDecode(response.body);
    setState(() {
      recipes = data['recipes'];
      total = data['total'];
      skip = limit;
    });
  }

  void changeSort(String value) {
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
    final theme = Theme.of(context);
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
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
            child: Row(
              children: [
                GestureDetector(
                  onTap: () => changeSort('rating'),
                  child: Container(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 14,
                      vertical: 6,
                    ),
                    decoration: BoxDecoration(
                      color: sortBy == 'rating'
                          ? theme.colorScheme.primary
                          : Colors.transparent,
                      border: Border.all(color: theme.colorScheme.outline),
                      borderRadius: BorderRadius.circular(18),
                    ),
                    child: Text(
                      strings.topRated,
                      style: theme.textTheme.bodySmall?.copyWith(
                        color: sortBy == 'rating'
                            ? theme.colorScheme.onPrimary
                            : theme.colorScheme.secondary,
                      ),
                    ),
                  ),
                ),
                const SizedBox(width: 8),
                GestureDetector(
                  onTap: () => changeSort('reviewCount'),
                  child: Container(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 14,
                      vertical: 6,
                    ),
                    decoration: BoxDecoration(
                      color: sortBy == 'reviewCount'
                          ? theme.colorScheme.primary
                          : Colors.transparent,
                      border: Border.all(color: theme.colorScheme.outline),
                      borderRadius: BorderRadius.circular(18),
                    ),
                    child: Text(
                      strings.mostReviewed,
                      style: theme.textTheme.bodySmall?.copyWith(
                        color: sortBy == 'reviewCount'
                            ? theme.colorScheme.onPrimary
                            : theme.colorScheme.secondary,
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
          Expanded(
            child: RefreshIndicator(
              onRefresh: refresh,
              child: Skeletonizer(
                enabled: isLoading,
                child: GridView.builder(
                  controller: scrollController,
                  physics: const AlwaysScrollableScrollPhysics(),
                  padding: const EdgeInsets.all(16),
                  gridDelegate: recipeGridDelegate,
                  itemCount: isLoading ? 6 : recipes.length,
                  itemBuilder: (context, index) {
                    final recipe = isLoading
                        ? placeholderRecipe(index)
                        : recipes[index];
                    return RecipeGridCard(
                      recipe: recipe,
                      onTap: () => openDetails(recipe),
                    );
                  },
                ),
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
