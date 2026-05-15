import 'package:flutter/material.dart';
import 'package:theme_tailor_annotation/theme_tailor_annotation.dart';

part 'section_header_theme.tailor.dart';

// See https://pub.dev/packages/theme_tailor/

@TailorMixin(themeGetter: ThemeGetter.onThemeData)
class SectionHeaderTheme extends ThemeExtension<SectionHeaderTheme>
    with _$SectionHeaderThemeTailorMixin {
  const SectionHeaderTheme({required this.iconColor, required this.textStyle});

  @override
  final Color iconColor;
  @override
  final TextStyle textStyle;
}
