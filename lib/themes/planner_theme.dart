import 'package:flutter/material.dart';
import 'package:theme_tailor_annotation/theme_tailor_annotation.dart';

part 'planner_theme.tailor.dart';

// See https://pub.dev/packages/theme_tailor/

@TailorMixin(themeGetter: ThemeGetter.onThemeData)
class PlannerTheme extends ThemeExtension<PlannerTheme>
    with _$PlannerThemeTailorMixin {
  const PlannerTheme({
    required this.lowPriorityBackground,
    required this.lowPriorityForeground,
    required this.mediumPriorityBackground,
    required this.mediumPriorityForeground,
    required this.highPriorityBackground,
    required this.highPriorityForeground,
  });

  @override
  final Color lowPriorityBackground;
  @override
  final Color lowPriorityForeground;
  @override
  final Color mediumPriorityBackground;
  @override
  final Color mediumPriorityForeground;
  @override
  final Color highPriorityBackground;
  @override
  final Color highPriorityForeground;
}
