import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_clean_architecture_steps/cubits/recipe_details/recipe_details_cubit.dart';
import 'package:flutter_clean_architecture_steps/cubits/recipe_details/recipe_details_state.dart';
import 'package:flutter_clean_architecture_steps/widgets/loading_dots.dart';
import 'package:flutter_clean_architecture_steps/widgets/recipe_details_view.dart';
import 'package:flutter_clean_architecture_steps/widgets/recipes_error_view.dart';

/// Owns the details cubit for as long as this screen is on the stack.
///
/// Stateless: the recipe lives in the cubit, and nothing else here is the
/// widget's own.
class RecipeDetailsPage extends StatelessWidget {
  const RecipeDetailsPage({required this.recipeId, super.key});

  final int recipeId;

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) {
        final cubit = RecipeDetailsCubit();
        unawaited(cubit.fetchDetails(recipeId));
        return cubit;
      },
      child: Scaffold(
        appBar: AppBar(),
        body: BlocBuilder<RecipeDetailsCubit, RecipeDetailsState>(
          builder: (context, state) => switch (state) {
            RecipeDetailsInitial() ||
            RecipeDetailsLoading() => const Center(child: LoadingDots()),
            RecipeDetailsLoaded(:final recipe) => RecipeDetailsView(
              recipe: recipe,
            ),
            RecipeDetailsError(:final failure) => RecipesErrorView(
              failure: failure,
              onRetry: () =>
                  context.read<RecipeDetailsCubit>().fetchDetails(recipeId),
            ),
          },
        ),
      ),
    );
  }
}
