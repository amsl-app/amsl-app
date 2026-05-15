import 'package:amsl_app/models/tori/modules/session_themes.dart';
import 'package:amsl_app/models/tori/theme/module_theme.dart';
import 'package:amsl_app/models/tori/theme/progress_bar_theme.dart';
import 'package:flutter/material.dart';
import 'package:logging/logging.dart';

class ModuleThemes {
  static const blue = ModuleTheme(
    color: Color(0xFF096683),
    containerColor: Color(0xFF00A2D3),
    textColor: Colors.white,
    descriptionColor: Colors.white,
    progressBarTheme: ProgressBarTheme(
      color: Color(0xFF39829B),
      trackColor: Color(0xFFAECBD4),
      textColor: Color(0xCCFFFFFF),
    ),
    sessionTheme: SessionThemes.main,
  );
  static const red = ModuleTheme(
    color: Color(0xFF6B0F26),
    containerColor: Color(0xFF8C1C1C),
    textColor: Colors.white,
    descriptionColor: Colors.white,
    progressBarTheme: ProgressBarTheme(
      color: Color(0xFF873D50),
      trackColor: Color(0xFFCCAFB8),
      textColor: Color(0xCCFFFFFF),
    ),
    sessionTheme: SessionThemes.main,
  );
  static const green = ModuleTheme(
    color: Color(0xFF195841),
    containerColor: Color(0xFF2B8C6C),
    textColor: Colors.white,
    descriptionColor: Colors.white,
    progressBarTheme: ProgressBarTheme(
      color: Color(0xFF437865),
      trackColor: Color(0xFFB2C5C0),
      textColor: Color(0xCCFFFFFF),
    ),
    sessionTheme: SessionThemes.main,
  );

  // "light-sea-green"
  static const lightSeaGreen = ModuleTheme(
    color: Color(0xFF58A490),
    containerColor: Color(0xFF85CCC1),
    textColor: Colors.white,
    descriptionColor: Colors.white,
    progressBarTheme: ProgressBarTheme(
      color: Color(0xFF78B5A4),
      trackColor: Color(0xFFC5DDD7),
      textColor: Color(0xCCFFFFFF),
    ),
    sessionTheme: SessionThemes.main,
  );
  static const yellow = ModuleTheme(
    color: Color(0xFFD6A94F),
    containerColor: Color(0xFFF2D479),
    textColor: Colors.white,
    descriptionColor: Colors.white,
    progressBarTheme: ProgressBarTheme(
      color: Color(0xFFDDB970),
      trackColor: Color(0xFFEDDFC4),
      textColor: Color(0xCCFFFFFF),
    ),
    sessionTheme: SessionThemes.main,
  );

  static final Logger log = Logger("ModuleThemes");

  static ModuleTheme? get(String? name) {
    final theme = switch (name) {
      "blue" => ModuleThemes.blue,
      "red" => ModuleThemes.red,
      "green" => ModuleThemes.green,
      "light-sea-green" => ModuleThemes.lightSeaGreen,
      "yellow" => ModuleThemes.yellow,
      _ => null,
    };
    if (name != null && theme == null) {
      log.warning("No theme found for name $name, returning default theme");
    }
    return theme;
  }
}
