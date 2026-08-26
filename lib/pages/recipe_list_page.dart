import 'dart:async';
import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_clean_architecture_steps/pages/recipe_details_page.dart';
import 'package:flutter_clean_architecture_steps/pages/search_recipe_page.dart';
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
      Navigator.push(
        context,
        MaterialPageRoute<void>(
          builder: (context) => RecipeDetailsPage(recipeId: recipe['id']),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: const Color(0xFFFBF8F4),
        elevation: 0,
        title: const Text(
          'Recipes',
          style: TextStyle(
            color: Color(0xFF2B2420),
            fontWeight: FontWeight.bold,
          ),
        ),
        actions: [
          IconButton(
            icon: const Icon(Icons.search, color: Color(0xFF7A6A55)),
            onPressed: () {
              unawaited(
                Navigator.push(
                  context,
                  MaterialPageRoute<void>(
                    builder: (context) => const SearchRecipePage(),
                  ),
                ),
              );
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
                          ? const Color(0xFFC8683B)
                          : Colors.transparent,
                      border: Border.all(color: const Color(0xFFE4D9C8)),
                      borderRadius: BorderRadius.circular(18),
                    ),
                    child: Text(
                      'Top Rated',
                      style: TextStyle(
                        color: sortBy == 'rating'
                            ? Colors.white
                            : const Color(0xFF8A7A64),
                        fontSize: 13,
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
                          ? const Color(0xFFC8683B)
                          : Colors.transparent,
                      border: Border.all(color: const Color(0xFFE4D9C8)),
                      borderRadius: BorderRadius.circular(18),
                    ),
                    child: Text(
                      'Most Reviewed',
                      style: TextStyle(
                        color: sortBy == 'reviewCount'
                            ? Colors.white
                            : const Color(0xFF8A7A64),
                        fontSize: 13,
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
              color: const Color(0xFFC8683B),
              backgroundColor: const Color(0xFFFBF8F4),
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
                    return buildRecipeGridCard(
                      recipe,
                      () => openDetails(recipe),
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
