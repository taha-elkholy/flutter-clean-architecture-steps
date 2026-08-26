import 'dart:async';
import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_clean_architecture_steps/pages/recipe_details_page.dart';
import 'package:flutter_clean_architecture_steps/widgets/recipe_grid_card.dart';
import 'package:http/http.dart' as http;
import 'package:skeletonizer/skeletonizer.dart';

class SearchRecipePage extends StatefulWidget {
  const SearchRecipePage({super.key});

  @override
  State<SearchRecipePage> createState() => _SearchRecipePageState();
}

class _SearchRecipePageState extends State<SearchRecipePage> {
  final TextEditingController controller = TextEditingController();
  List<dynamic> results = [];
  bool isLoading = false;
  bool hasSearched = false;

  // NOTE: search only runs on submit (Enter) for now.
  // Live-as-you-type search needs debouncing, and that's a deliberate
  // problem left for a later branch, not an oversight here.
  Future<void> search(String query) async {
    if (query.isEmpty) return;
    setState(() {
      isLoading = true;
      hasSearched = true;
    });

    final url = Uri.parse(
      'https://dummyjson.com/recipes/search?q=$query&select=name,image,rating,cuisine,difficulty',
    );
    final response = await http.get(url);
    final data = jsonDecode(response.body);
    setState(() {
      results = data['recipes'];
      isLoading = false;
    });
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
      backgroundColor: const Color(0xFFFBF8F4),
      appBar: AppBar(
        backgroundColor: const Color(0xFFFBF8F4),
        elevation: 0,
        title: TextField(
          controller: controller,
          autofocus: true,
          decoration: const InputDecoration(
            hintText: 'Search recipes...',
            border: InputBorder.none,
          ),
          onSubmitted: search,
        ),
      ),
      body: !hasSearched
          ? const Center(
              child: Text(
                'Type a recipe name and hit enter',
                style: TextStyle(color: Color(0xFFA08F76)),
              ),
            )
          : Skeletonizer(
              enabled: isLoading,
              child: GridView.builder(
                padding: const EdgeInsets.all(16),
                gridDelegate: recipeGridDelegate,
                itemCount: isLoading ? 6 : results.length,
                itemBuilder: (context, index) {
                  final recipe = isLoading
                      ? placeholderRecipe(index)
                      : results[index];
                  return buildRecipeGridCard(recipe, () => openDetails(recipe));
                },
              ),
            ),
    );
  }
}
