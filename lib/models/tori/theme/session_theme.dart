import 'package:flutter/material.dart';
import 'package:theme_tailor_annotation/theme_tailor_annotation.dart';

part 'session_theme.tailor.dart';

@TailorMixin(themeGetter: ThemeGetter.onThemeData)
class SessionTheme extends ThemeExtension<SessionTheme>
    with _$SessionThemeTailorMixin {
  const SessionTheme({required this.textColor, required this.descriptionColor});

  @override
  final Color textColor;
  @override
  final Color descriptionColor;
}
