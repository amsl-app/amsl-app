import 'package:flutter/material.dart';
import 'package:theme_tailor_annotation/theme_tailor_annotation.dart';

part 'assessment_theme.tailor.dart';

@TailorMixin(themeGetter: ThemeGetter.onThemeData)
class AssessmentTheme extends ThemeExtension<AssessmentTheme>
    with _$AssessmentThemeTailorMixin {
  const AssessmentTheme({required this.scaleColors});

  @override
  final List<Color> scaleColors;
}
