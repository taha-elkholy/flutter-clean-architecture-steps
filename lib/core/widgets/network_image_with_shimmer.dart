import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_clean_architecture_steps/core/extensions/build_context_extensions.dart';
import 'package:flutter_clean_architecture_steps/core/widgets/loading_dots.dart';
import 'package:skeletonizer/skeletonizer.dart';

// Shared image widget. Shows a shimmering placeholder while the image is
// downloading and a broken-image box if it fails. What it downloads is kept
// and capped in width, so scrolling back to a card neither refetches the
// image nor holds a photo far larger than the screen can show.
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

  /// What the widest screen this app runs on actually needs, so a full
  /// resolution photo is never stored or decoded at its original size.
  static const _maxCacheWidth = 1080;

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
    return CachedNetworkImage(
      imageUrl: imageUrl,
      width: width,
      height: height,
      fit: fit,
      maxWidthDiskCache: _maxCacheWidth,
      memCacheWidth: _maxCacheWidth,
      errorWidget: (context, url, error) {
        return _placeholder(
          context,
          child: Icon(
            Icons.broken_image_outlined,
            color: context.colorScheme.onSurfaceVariant,
          ),
        );
      },
      placeholder: (context, url) {
        return Skeletonizer(
          child: _placeholder(context, child: const LoadingDots(size: 7)),
        );
      },
    );
  }
}
