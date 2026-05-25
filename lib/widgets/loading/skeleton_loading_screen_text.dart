import 'dart:math';

import 'package:amsl_app/widgets/loading/haptic_refresh_indicator.dart';
import 'package:amsl_app/widgets/loading/loading_text.dart';
import 'package:flutter/material.dart';
import 'package:gap/gap.dart';

class SkeletonLoadingScreenText extends StatelessWidget {
  const SkeletonLoadingScreenText({
    super.key,
    this.onRefresh,
    this.goBackAllowed = false,
    this.title,
    this.backgroundColor,
  });

  final Function? onRefresh;
  final bool goBackAllowed;
  final String? title;
  final Color? backgroundColor;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final bgColor = backgroundColor ?? theme.colorScheme.surface;
    final lineColor = bgColor.withValues(
      red: max(bgColor.r - 0.1, 0),
      green: max(bgColor.g - 0.1, 0),
      blue: max(bgColor.b - 0.1, 0),
    );

    return Scaffold(
      backgroundColor: bgColor,
      appBar: goBackAllowed || title != null
          ? AppBar(
              backgroundColor: bgColor,
              leading: goBackAllowed
                  ? BackButton(
                      onPressed: () => Navigator.of(context).maybePop(),
                    )
                  : null,
              title: Text(
                title ?? 'Laden...',
                style: theme.textTheme.titleMedium,
              ),
            )
          : null,
      body: SafeArea(
        child: HapticRefreshIndicator(
          onRefresh: () async {
            if (onRefresh != null) {
              await onRefresh!();
            }
          },
          child: SingleChildScrollView(
            padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 16),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // Title block
                LoadingText(width: double.infinity, color: lineColor),
                const Gap(8),
                LoadingText(width: 220, color: lineColor),
                const Gap(24),
                // Paragraph 1
                ..._paragraph(lineColor),
                const Gap(24),
                // Paragraph 2
                ..._paragraph(lineColor),
                const Gap(24),
                // Paragraph 3
                ..._paragraph(lineColor, lastLineWidth: 120),
              ],
            ),
          ),
        ),
      ),
    );
  }

  List<Widget> _paragraph(Color color, {double lastLineWidth = 180}) {
    return [
      LoadingText(width: double.infinity, color: color),
      const Gap(24),
      LoadingText(width: double.infinity, color: color),
      const Gap(24),
      LoadingText(width: double.infinity, color: color),
      const Gap(24),
      LoadingText(width: lastLineWidth, color: color),
    ];
  }
}
