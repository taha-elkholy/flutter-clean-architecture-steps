import 'dart:async';
import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_clean_architecture_steps/generated/l10n.dart';
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
    final strings = S.of(context);

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
      body: !hasSearched
          ? Center(
              child: Text(
                strings.searchEmptyState,
                style: Theme.of(context).textTheme.bodySmall,
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
                  return RecipeGridCard(
                    recipe: recipe,
                    onTap: () => openDetails(recipe),
                  );
                },
              ),
            ),
    );
  }
}
