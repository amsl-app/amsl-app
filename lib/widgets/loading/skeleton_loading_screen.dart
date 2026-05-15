import 'dart:math';

import 'package:amsl_app/widgets/loading/haptic_refresh_indicator.dart';
import 'package:amsl_app/widgets/loading/skeleton_loading_widget.dart';
import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:go_router/go_router.dart';

class SkeletonLoadingScreen extends StatelessWidget {
  const SkeletonLoadingScreen({
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

    final cardColor = bgColor.withValues(
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
                  ? IconButton(
                      onPressed: () => context.pop(),
                      icon: const Icon(Icons.arrow_back_ios_new_rounded),
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
          child: Container(
            padding: const EdgeInsets.symmetric(horizontal: 20.0, vertical: 16),
            child: ListView(
              physics: AlwaysScrollableScrollPhysics(),
              children: [
                SkeletonLoadingWidget(columns: 1, color: cardColor),
                const Gap(20),
                SkeletonLoadingWidget(columns: 2, rows: 3, color: cardColor),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
