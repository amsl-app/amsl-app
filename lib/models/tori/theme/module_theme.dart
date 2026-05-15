import 'package:amsl_app/models/tori/theme/progress_bar_theme.dart';
import 'package:amsl_app/models/tori/theme/session_theme.dart';
import 'package:flutter/material.dart';
import 'package:theme_tailor_annotation/theme_tailor_annotation.dart';

part 'module_theme.tailor.dart';

@TailorMixin(themeGetter: ThemeGetter.onThemeData)
class ModuleTheme extends ThemeExtension<ModuleTheme>
    with _$ModuleThemeTailorMixin {
  const ModuleTheme({
    required this.color,
    required this.containerColor,
    required this.textColor,
    required this.descriptionColor,
    required this.progressBarTheme,
    required this.sessionTheme,
  });

  @override
  final Color color;
  @override
  final Color containerColor;
  @override
  final Color textColor;
  @override
  final Color descriptionColor;
  @override
  final ProgressBarTheme progressBarTheme;
  @override
  final SessionTheme sessionTheme;
}
