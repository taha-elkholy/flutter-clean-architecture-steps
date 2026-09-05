import 'package:flutter/material.dart';
import 'package:flutter_clean_architecture_steps/extensions/build_context_extensions.dart';

/// The two sort options the recipe list can be ordered by.
///
/// The API takes these as raw `sortBy` values, so the wire name travels with
/// the option instead of being rebuilt from a switch at the call site.
enum RecipeSort {
  topRated('rating'),
  mostReviewed('reviewCount');

  const RecipeSort(this.queryValue);

  /// The value sent to the API as `sortBy`.
  final String queryValue;
}

/// The sort chip row above the recipe grid.
class SortTabs extends StatelessWidget {
  const SortTabs({required this.selected, required this.onChanged, super.key});

  final RecipeSort selected;
  final ValueChanged<RecipeSort> onChanged;

  @override
  Widget build(BuildContext context) {
    final strings = context.strings;

    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      child: Row(
        children: [
          _SortChip(
            label: strings.topRated,
            isSelected: selected == RecipeSort.topRated,
            onTap: () => onChanged(RecipeSort.topRated),
          ),
          const SizedBox(width: 8),
          _SortChip(
            label: strings.mostReviewed,
            isSelected: selected == RecipeSort.mostReviewed,
            onTap: () => onChanged(RecipeSort.mostReviewed),
          ),
        ],
      ),
    );
  }
}

class _SortChip extends StatelessWidget {
  const _SortChip({
    required this.label,
    required this.isSelected,
    required this.onTap,
  });

  final String label;
  final bool isSelected;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    final theme = context.theme;

    return GestureDetector(
      onTap: onTap,
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 6),
        decoration: BoxDecoration(
          color: isSelected ? theme.colorScheme.primary : Colors.transparent,
          border: Border.all(color: theme.colorScheme.outline),
          borderRadius: BorderRadius.circular(18),
        ),
        child: Text(
          label,
          style: theme.textTheme.bodySmall?.copyWith(
            color: isSelected
                ? theme.colorScheme.onPrimary
                : theme.colorScheme.secondary,
          ),
        ),
      ),
    );
  }
}
