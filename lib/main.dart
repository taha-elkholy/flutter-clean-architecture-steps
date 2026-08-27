import 'package:flutter/material.dart';
import 'package:flutter_clean_architecture_steps/pages/recipe_list_page.dart';
import 'package:flutter_clean_architecture_steps/style/app_theme.dart';

void main() {
  runApp(const RecipesApp());
}

class RecipesApp extends StatelessWidget {
  const RecipesApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Recipes',
      theme: AppTheme.light,
      home: const RecipeListPage(),
    );
  }
}
