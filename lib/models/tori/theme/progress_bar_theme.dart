import 'package:flutter/material.dart';
import 'package:theme_tailor_annotation/theme_tailor_annotation.dart';

part 'progress_bar_theme.tailor.dart';

@tailorMixinComponent
class ProgressBarTheme extends ThemeExtension<ProgressBarTheme>
    with _$ProgressBarThemeTailorMixin {
  const ProgressBarTheme({
    required this.color,
    required this.trackColor,
    required this.textColor,
  });

  @override
  final Color color;
  @override
  final Color trackColor;
  @override
  final Color textColor;
}
