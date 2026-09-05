import 'package:flutter/material.dart';
import 'package:flutter_clean_architecture_steps/generated/l10n.dart';

/// Fallback screen for a route the router does not know.
///
/// It exists so an unknown or malformed route lands on a real screen the user
/// can back out of, instead of a black screen or a thrown route error.
class RouteNotFoundPage extends StatelessWidget {
  const RouteNotFoundPage({required this.routeName, super.key});

  /// The route that could not be resolved, shown to make the mistake obvious.
  final String routeName;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final strings = S.of(context);

    return Scaffold(
      appBar: AppBar(title: Text(strings.routeNotFoundTitle)),
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(24),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Icon(
                Icons.explore_off_outlined,
                size: 56,
                color: theme.colorScheme.outline,
              ),
              const SizedBox(height: 16),
              Text(
                strings.routeNotFoundMessage(routeName),
                textAlign: TextAlign.center,
                style: theme.textTheme.bodyMedium,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
