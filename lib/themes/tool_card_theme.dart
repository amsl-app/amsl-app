import 'package:flutter/material.dart';
import 'package:theme_tailor_annotation/theme_tailor_annotation.dart';

part 'tool_card_theme.tailor.dart';

@TailorMixin(themeGetter: ThemeGetter.onThemeData)
class ToolCardTheme extends ThemeExtension<ToolCardTheme>
    with _$ToolCardThemeTailorMixin {
  const ToolCardTheme({
    required this.backgroundColor,
    required this.decorationColor,
    required this.labelStyle,
  });

  @override
  final Color backgroundColor;
  @override
  final Color decorationColor;
  @override
  final TextStyle labelStyle;
}
