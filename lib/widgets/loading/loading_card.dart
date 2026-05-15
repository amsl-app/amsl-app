import 'dart:math';

import 'package:flutter/material.dart';
import 'package:shimmer/shimmer.dart';

class LoadingCard extends StatelessWidget {
  const LoadingCard({super.key, this.width, this.height, this.color});
  static const aspectRatio = 327.0 / 126.0;
  final Color? color;

  final double? width;
  final double? height;

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

    final double cardWidth =
        width ??
        (height != null
            ? height! * aspectRatio
            : MediaQuery.of(context).size.width);

    final double cardHeight = height ?? cardWidth / aspectRatio;

    const br = BorderRadius.all(Radius.circular(16));

    return SizedBox(
      width: cardWidth,
      height: cardHeight,
      child: ClipRRect(
        borderRadius: br,
        child: Material(
          child: Ink(
            color: baseColor,
            child: Container(
              padding: EdgeInsets.symmetric(
                vertical: cardHeight * 0.2,
                horizontal: cardHeight * 0.2,
              ),
              child: Row(
                children: [
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Shimmer.fromColors(
                          baseColor: highlightColor,
                          highlightColor: baseColor,
                          period: const Duration(milliseconds: 2000),
                          child: Container(
                            height: cardHeight * 0.3,
                            width: cardWidth * 0.3,
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.all(
                                Radius.circular(8),
                              ),
                              color: baseColor,
                            ),
                          ),
                        ),
                        Shimmer.fromColors(
                          baseColor: highlightColor,
                          highlightColor: baseColor,
                          period: const Duration(milliseconds: 2000),
                          child: Container(
                            width: cardWidth * 0.5,
                            height: cardHeight * 0.15,
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.all(
                                Radius.circular(32),
                              ),
                              color: baseColor,
                            ),
                          ),
                        ),
                      ],
                    ),
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
