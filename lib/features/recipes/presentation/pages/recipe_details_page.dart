import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_clean_architecture_steps/core/di/service_locator.dart';
import 'package:flutter_clean_architecture_steps/core/widgets/loading_dots.dart';
import 'package:flutter_clean_architecture_steps/features/recipes/presentation/cubits/recipe_details/recipe_details_cubit.dart';
import 'package:flutter_clean_architecture_steps/features/recipes/presentation/cubits/recipe_details/recipe_details_state.dart';
import 'package:flutter_clean_architecture_steps/features/recipes/presentation/widgets/recipe_details_view.dart';
import 'package:flutter_clean_architecture_steps/features/recipes/presentation/widgets/recipes_error_view.dart';

/// Takes the details cubit from the locator and owns it for as long as this
/// screen is on the stack.
///
/// The recipe id reaches the cubit through [RecipeDetailsCubit.fetchDetails]
/// rather than its constructor, so the locator can hand out a cubit that knows
/// nothing about which recipe it is about to read.
class RecipeDetailsPage extends StatelessWidget {
  const RecipeDetailsPage({required this.recipeId, super.key});

  final int recipeId;

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) {
        final cubit = getIt<RecipeDetailsCubit>();
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
