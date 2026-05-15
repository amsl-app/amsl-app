import 'dart:math';

import 'package:flutter/material.dart';
import 'package:shimmer/shimmer.dart';

class LoadingText extends StatelessWidget {
  final double width;
  final Color? color;

  const LoadingText({super.key, this.width = double.infinity, this.color});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    final defaultBg = theme.colorScheme.surface;

    final Color baseColor =
        color ??
        defaultBg.withValues(
          red: max(defaultBg.r - 0.1, 0),
          green: max(defaultBg.g - 0.1, 0),
          blue: max(defaultBg.b - 0.1, 0),
        );

    final Color highlightColor = baseColor.withValues(
      red: min(baseColor.r + 0.15, 255),
      green: min(baseColor.g + 0.15, 255),
      blue: min(baseColor.b + 0.15, 255),
    );

    return Shimmer.fromColors(
      baseColor: baseColor,
      highlightColor: highlightColor,
      period: const Duration(milliseconds: 3000),
      child: Container(
        height: 20,
        width: width,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.all(Radius.circular(4)),
          color: baseColor,
        ),
      ),
    );
  }
}
