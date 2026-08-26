import 'package:flutter/material.dart';
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

  Widget _placeholder({Widget? child}) {
    return Container(
      width: width,
      height: height,
      color: const Color(0xFFEFE7DC),
      child: child == null ? null : Center(child: child),
    );
  }

  @override
  Widget build(BuildContext context) {
    if (imageUrl.isEmpty) {
      return _placeholder();
    }
    return Image.network(
      imageUrl,
      width: width,
      height: height,
      fit: fit,
      errorBuilder: (context, error, stackTrace) {
        return _placeholder(
          child: const Icon(
            Icons.broken_image_outlined,
            color: Color(0xFFA08F76),
          ),
        );
      },
      loadingBuilder: (context, child, loadingProgress) {
        // null progress means the image is fully loaded (including when it
        // came straight from the cache).
        if (loadingProgress == null) return child;
        return Skeletonizer(
          child: _placeholder(child: const LoadingDots(size: 7)),
        );
      },
    );
  }
}
