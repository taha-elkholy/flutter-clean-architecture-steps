import 'package:flutter/material.dart';
import 'package:flutter_clean_architecture_steps/extensions/build_context_extensions.dart';
import 'package:flutter_clean_architecture_steps/widgets/loading_dots.dart';
import 'package:skeletonizer/skeletonizer.dart';

// Shared image widget. Shows a shimmering placeholder while the image is
// downloading and a broken-image box if it fails. Stateless on purpose:
// Image.network already knows whether it's still loading, so tracking that
// manually only creates stale-state bugs when grid items get reused.
class NetworkImageWithShimmer extends StatelessWidget {
  const NetworkImageWithShimmer({
    required this.imageUrl,
    super.key,
    this.width,
    this.height,
    this.fit = BoxFit.cover,
  });
  final String imageUrl;
  final double? width;
  final double? height;
  final BoxFit fit;

  Widget _placeholder(BuildContext context, {Widget? child}) {
    return Container(
      width: width,
      height: height,
      color: context.colorScheme.surfaceContainerHighest,
      child: child == null ? null : Center(child: child),
    );
  }

  @override
  Widget build(BuildContext context) {
    if (imageUrl.isEmpty) {
      return _placeholder(context);
    }
    return Image.network(
      imageUrl,
      width: width,
      height: height,
      fit: fit,
      errorBuilder: (context, error, stackTrace) {
        return _placeholder(
          context,
          child: Icon(
            Icons.broken_image_outlined,
            color: context.colorScheme.onSurfaceVariant,
          ),
        );
      },
      loadingBuilder: (context, child, loadingProgress) {
        // null progress means the image is fully loaded (including when it
        // came straight from the cache).
        if (loadingProgress == null) return child;
        return Skeletonizer(
          child: _placeholder(context, child: const LoadingDots(size: 7)),
        );
      },
    );
  }
}
