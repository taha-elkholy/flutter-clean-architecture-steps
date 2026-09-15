import 'package:flutter/material.dart';
import 'package:flutter_clean_architecture_steps/error/failure.dart';
import 'package:flutter_clean_architecture_steps/extensions/build_context_extensions.dart';

/// Shown when a request fails and there is nothing on screen to keep.
class RecipesErrorView extends StatelessWidget {
  const RecipesErrorView({
    required this.failure,
    required this.onRetry,
    super.key,
  });

  /// The whole failure, not just its message: what is shown for one can grow
  /// past the text without every call site having to change.
  final Failure failure;

  final VoidCallback onRetry;

  @override
  Widget build(BuildContext context) {
    final theme = context.theme;
    final strings = context.strings;

    return Center(
      child: Padding(
        padding: const EdgeInsets.all(24),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Icon(
              Icons.error_outline,
              size: 40,
              color: theme.colorScheme.outline,
            ),
            const SizedBox(height: 12),
            Text(
              failure.message,
              textAlign: TextAlign.center,
              style: theme.textTheme.bodySmall,
            ),
            const SizedBox(height: 16),
            OutlinedButton(
              onPressed: onRetry,
              child: Text(strings.retry),
            ),
          ],
        ),
      ),
    );
  }
}
