import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_clean_architecture_steps/cubits/recipe_details/recipe_details_cubit.dart';
import 'package:flutter_clean_architecture_steps/cubits/recipe_details/recipe_details_state.dart';
import 'package:flutter_clean_architecture_steps/network/api_client.dart';
import 'package:flutter_clean_architecture_steps/repositories/recipes_repository_impl.dart';
import 'package:flutter_clean_architecture_steps/widgets/loading_dots.dart';
import 'package:flutter_clean_architecture_steps/widgets/recipe_details_view.dart';
import 'package:flutter_clean_architecture_steps/widgets/recipes_error_view.dart';

/// Builds what the details cubit needs and owns it for as long as this screen
/// is on the stack.
///
/// Stateful only to close the client: the cubit is handed a repository, so
/// closing what the request runs on is the caller's job.
class RecipeDetailsPage extends StatefulWidget {
  const RecipeDetailsPage({required this.recipeId, super.key});

  final int recipeId;

  @override
  State<RecipeDetailsPage> createState() => _RecipeDetailsPageState();
}

class _RecipeDetailsPageState extends State<RecipeDetailsPage> {
  final ApiClient client = ApiClient();

  @override
  void dispose() {
    client.close();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) {
        final cubit = RecipeDetailsCubit(RecipesRepositoryImpl(client));
        unawaited(cubit.fetchDetails(widget.recipeId));
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
              onRetry: () => context
                  .read<RecipeDetailsCubit>()
                  .fetchDetails(widget.recipeId),
            ),
          },
        ),
      ),
    );
  }
}
