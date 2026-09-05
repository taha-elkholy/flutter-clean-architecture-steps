import 'package:flutter/material.dart';
import 'package:flutter_clean_architecture_steps/extensions/build_context_extensions.dart';

/// Shown wherever a screen has nothing to list.
///
/// The icon is the same everywhere, so emptiness reads the same across the app;
/// only [message] says which screen it is.
///
/// It scrolls even though it fits: an empty screen offers no other way out, so
/// a pull-to-refresh above it needs something to pull.
class EmptyView extends StatelessWidget {
  const EmptyView(this.message, {super.key});

  final String message;

  @override
  Widget build(BuildContext context) {
    final theme = context.theme;

    return LayoutBuilder(
      builder: (context, constraints) => SingleChildScrollView(
        physics: const AlwaysScrollableScrollPhysics(),
        child: ConstrainedBox(
          constraints: BoxConstraints(minHeight: constraints.maxHeight),
          child: Center(
            child: Padding(
              padding: const EdgeInsets.all(24),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Icon(
                    Icons.inbox_outlined,
                    size: 40,
                    color: theme.colorScheme.outline,
                  ),
                  const SizedBox(height: 12),
                  Text(
                    message,
                    textAlign: TextAlign.center,
                    style: theme.textTheme.bodySmall,
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
