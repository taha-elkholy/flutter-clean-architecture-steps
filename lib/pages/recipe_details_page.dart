import 'dart:async';
import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_clean_architecture_steps/widgets/loading_dots.dart';
import 'package:flutter_clean_architecture_steps/widgets/network_image_with_shimmer.dart';
import 'package:http/http.dart' as http;

class RecipeDetailsPage extends StatefulWidget {
  const RecipeDetailsPage({required this.recipeId, super.key});
  final int recipeId;

  @override
  State<RecipeDetailsPage> createState() => _RecipeDetailsPageState();
}

class _RecipeDetailsPageState extends State<RecipeDetailsPage> {
  dynamic recipe;
  bool isLoading = true;

  @override
  void initState() {
    super.initState();
    unawaited(fetchDetails());
  }

  Future<void> fetchDetails() async {
    final url = Uri.parse('https://dummyjson.com/recipes/${widget.recipeId}');
    final response = await http.get(url);
    final data = jsonDecode(response.body);
    setState(() {
      recipe = data;
      isLoading = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFFBF8F4),
      appBar: AppBar(backgroundColor: const Color(0xFFFBF8F4), elevation: 0),
      body: isLoading
          ? const Center(child: LoadingDots())
          : SingleChildScrollView(
              padding: const EdgeInsets.all(16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  ClipRRect(
                    borderRadius: BorderRadius.circular(14),
                    child: NetworkImageWithShimmer(
                      imageUrl: recipe['image'] ?? '',
                      width: double.infinity,
                      height: 220,
                    ),
                  ),
                  const SizedBox(height: 14),
                  Text(
                    recipe['name'],
                    style: const TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                      color: Color(0xFF2B2420),
                    ),
                  ),
                  const SizedBox(height: 6),
                  Text(
                    '${recipe['cuisine']} · '
                    '${recipe['difficulty']} · '
                    "${recipe['caloriesPerServing']} cal",
                    style: const TextStyle(
                      fontSize: 13,
                      color: Color(0xFFA08F76),
                    ),
                  ),
                  const SizedBox(height: 18),
                  const Text(
                    'Ingredients',
                    style: TextStyle(
                      fontSize: 15,
                      fontWeight: FontWeight.bold,
                      color: Color(0xFF2B2420),
                    ),
                  ),
                  const SizedBox(height: 8),
                  ...List.generate(
                    recipe['ingredients'].length,
                    (index) => Padding(
                      padding: const EdgeInsets.only(bottom: 4),
                      child: Text('• ${recipe['ingredients'][index]}'),
                    ),
                  ),
                  const SizedBox(height: 18),
                  const Text(
                    'Instructions',
                    style: TextStyle(
                      fontSize: 15,
                      fontWeight: FontWeight.bold,
                      color: Color(0xFF2B2420),
                    ),
                  ),
                  const SizedBox(height: 8),
                  ...List.generate(
                    recipe['instructions'].length,
                    (index) => Padding(
                      padding: const EdgeInsets.only(bottom: 6),
                      child: Text(
                        '${index + 1}. ${recipe['instructions'][index]}',
                      ),
                    ),
                  ),
                ],
              ),
            ),
    );
  }
}
