import 'dart:math' as math;

import 'package:flutter/material.dart';
import 'package:flutter_clean_architecture_steps/extensions/build_context_extensions.dart';

// Bouncing dots loader, used everywhere instead of CircularProgressIndicator.
class LoadingDots extends StatefulWidget {
  const LoadingDots({super.key, this.size = 9});
  final double size;

  @override
  State<LoadingDots> createState() => _LoadingDotsState();
}

class _LoadingDotsState extends State<LoadingDots>
    with SingleTickerProviderStateMixin {
  late final AnimationController controller = AnimationController(
    vsync: this,
    duration: const Duration(milliseconds: 1100),
  )..repeat();

  @override
  void dispose() {
    controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final dotColor = context.colorScheme.primary;

    return AnimatedBuilder(
      animation: controller,
      builder: (context, _) {
        return Row(
          mainAxisSize: MainAxisSize.min,
          children: List.generate(3, (i) {
            final t = (controller.value - i * 0.16) % 1.0;
            final bounce = math.sin(t * math.pi).clamp(0.0, 1.0);
            return Padding(
              padding: EdgeInsets.symmetric(horizontal: widget.size * 0.32),
              child: Transform.translate(
                offset: Offset(0, -bounce * widget.size),
                child: Container(
                  width: widget.size,
                  height: widget.size,
                  decoration: BoxDecoration(
                    color: dotColor.withValues(alpha: 0.3 + bounce * 0.7),
                    shape: BoxShape.circle,
                  ),
                ),
              ),
            );
          }),
        );
      },
    );
  }
}
