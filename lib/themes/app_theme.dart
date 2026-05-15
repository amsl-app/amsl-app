import 'package:amsl_app/models/tori/modules/module_themes.dart';
import 'package:amsl_app/models/tori/modules/session_themes.dart';
import 'package:amsl_app/themes/chat_theme.dart';
import 'package:amsl_app/themes/section_header_theme.dart';
import 'package:amsl_app/themes/tool_card_theme.dart';
import 'package:flutter/material.dart';

class AppTheme {
  static const lightColorScheme = ColorScheme(
    brightness: Brightness.light,
    primary: Color(0xFF0C132A),
    onPrimary: Color(0xFFFFFFFF),
    secondary: Color.fromRGBO(0, 106, 138, 1.0),
    onSecondary: Colors.white,
    secondaryContainer: Color.fromRGBO(0, 162, 211, 1.0),
    onSecondaryContainer: Colors.white,
    tertiary: Color.fromRGBO(231, 173, 56, 1.0),
    onTertiary: Colors.white,
    tertiaryContainer: Color.fromRGBO(244, 205, 131, 1.0),
    onTertiaryContainer: Color(0xFF0C132A),
    error: Color(0xFFF9DEDC),
    onError: Color(0xFFB3261E),
    surfaceContainer: Color(0xFFE2E2E2),
    surface: Colors.white,
    onSurface: Color(0xFF0C132A),
  );

  static const darkColorScheme = ColorScheme(
    brightness: Brightness.dark,
    primary: Color(0xFF0C132A),
    onPrimary: Color(0xFFFFFFFF),
    secondary: Color.fromRGBO(0, 106, 138, 1.0),
    onSecondary: Colors.white,
    secondaryContainer: Color.fromRGBO(0, 162, 211, 1.0),
    onSecondaryContainer: Colors.white,
    tertiary: Color.fromRGBO(231, 173, 56, 1.0),
    onTertiary: Colors.white,
    tertiaryContainer: Color.fromRGBO(244, 205, 131, 1.0),
    onTertiaryContainer: Color(0xFF0C132A),
    error: Color(0xFFF9DEDC),
    onError: Color(0xFFB3261E),
    surfaceContainer: Color(0xFFE2E2E2),
    surface: Color(0xFF0C132A),
    onSurface: Color(0xFFFFFFFF),
  );

  static const textTheme = TextTheme(
    displayLarge: TextStyle(fontWeight: FontWeight.bold),
    displayMedium: TextStyle(color: Colors.green),
    displaySmall: TextStyle(color: Colors.blue),
    headlineLarge: TextStyle(color: Colors.purple),
    headlineMedium: TextStyle(color: Colors.pink),
    headlineSmall: TextStyle(),
    titleLarge: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
    titleMedium: TextStyle(
      fontVariations: <FontVariation>[FontVariation('wght', 800.0)],
      fontSize: 18,
    ),
    titleSmall: TextStyle(
      fontVariations: <FontVariation>[FontVariation('wght', 800.0)],
      fontSize: 14,
    ),
    bodyLarge: TextStyle(
      fontVariations: <FontVariation>[FontVariation('wght', 600.0)],
    ),
    bodyMedium: TextStyle(
      fontVariations: <FontVariation>[FontVariation('wght', 600.0)],
    ),
    bodySmall: TextStyle(fontSize: 12, fontWeight: FontWeight.bold),
  );

  static const fontFamily = "Mulish";

  static const sectionThemeColor = Color(0xFF5B5B5B);
  static const sectionTheme = SectionHeaderTheme(
    iconColor: sectionThemeColor,
    textStyle: TextStyle(
      color: sectionThemeColor,
      fontVariations: <FontVariation>[FontVariation('wght', 800.0)],
    ),
  );

  static var lightToolCardTheme = ToolCardTheme(
    backgroundColor: lightColorScheme.tertiaryContainer,
    decorationColor: lightColorScheme.tertiary,
    labelStyle: const TextStyle(
      fontSize: 16,
      fontVariations: <FontVariation>[FontVariation('wght', 800.0)],
    ),
  );

  static var darkToolCardTheme = ToolCardTheme(
    backgroundColor: darkColorScheme.tertiaryContainer,
    decorationColor: darkColorScheme.tertiary,
    labelStyle: const TextStyle(
      fontSize: 16,
      fontVariations: <FontVariation>[FontVariation('wght', 800.0)],
    ),
  );

  static var lightChatTheme = ChatTheme(
    ownBubbles: BubbleTheme(
      backgroundColor: lightColorScheme.primary,
      textStyle: const TextStyle(
        fontFamily: fontFamily,
        fontVariations: <FontVariation>[FontVariation('wght', 600.0)],
        fontSize: 16,
        color: Colors.white,
      ),
    ),
    otherBubbles: const BubbleTheme(
      backgroundColor: Colors.white,
      textStyle: TextStyle(
        fontFamily: fontFamily,
        fontVariations: <FontVariation>[FontVariation('wght', 600.0)],
        fontSize: 16,
        color: Color(0xFF1F1D1B),
      ),
    ),
    buttons: TextButtonThemeData(
      style: ButtonStyle(
        backgroundColor: WidgetStateProperty.all<Color>(
          lightColorScheme.onSurface,
        ),
        foregroundColor: WidgetStateProperty.all<Color>(Colors.white),
        shape: WidgetStateProperty.all<RoundedRectangleBorder>(
          RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(12),
            side: const BorderSide(width: 0),
          ),
        ),
        textStyle: WidgetStateProperty.all<TextStyle>(
          const TextStyle(
            color: Colors.white,
            fontSize: 16,
            fontFamily: fontFamily,
            fontVariations: <FontVariation>[FontVariation('wght', 800.0)],
          ),
        ),
      ),
    ),
  );

  static var darkChatTheme = ChatTheme(
    ownBubbles: BubbleTheme(
      backgroundColor: darkColorScheme.primary,
      textStyle: const TextStyle(
        fontFamily: fontFamily,
        fontVariations: <FontVariation>[FontVariation('wght', 600.0)],
        fontSize: 16,
        color: Colors.white,
      ),
    ),
    otherBubbles: const BubbleTheme(
      backgroundColor: Colors.white,
      textStyle: TextStyle(
        fontFamily: fontFamily,
        fontVariations: <FontVariation>[FontVariation('wght', 600.0)],
        fontSize: 16,
        color: Color(0xFF1F1D1B),
      ),
    ),
    buttons: TextButtonThemeData(
      style: ButtonStyle(
        backgroundColor: WidgetStateProperty.all<Color>(
          darkColorScheme.onSurface,
        ),
        foregroundColor: WidgetStateProperty.all<Color>(Colors.white),
        shape: WidgetStateProperty.all<RoundedRectangleBorder>(
          RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(12),
            side: const BorderSide(width: 0),
          ),
        ),
        textStyle: WidgetStateProperty.all<TextStyle>(
          const TextStyle(
            color: Colors.white,
            fontSize: 16,
            fontFamily: fontFamily,
            fontVariations: <FontVariation>[FontVariation('wght', 800.0)],
          ),
        ),
      ),
    ),
  );

  static ThemeData get light {
    return ThemeData(
      useMaterial3: true,
      colorScheme: lightColorScheme,
      bottomAppBarTheme: BottomAppBarThemeData(
        color: lightColorScheme.primary,
        elevation: 0,
      ),
      bottomNavigationBarTheme: BottomNavigationBarThemeData(
        showSelectedLabels: true,
        type: BottomNavigationBarType.fixed,
        backgroundColor: lightColorScheme.primary,
        selectedItemColor: lightColorScheme.onPrimary,
        selectedLabelStyle: const TextStyle(
          fontSize: 12,
          fontWeight: FontWeight.bold,
        ),
        unselectedLabelStyle: const TextStyle(
          fontSize: 12,
          fontWeight: FontWeight.bold,
        ),
        unselectedItemColor: Color.lerp(
          lightColorScheme.onPrimary,
          lightColorScheme.primary,
          0.3,
        ),
      ),
      scaffoldBackgroundColor: lightColorScheme.surface,
      textTheme: textTheme,
      appBarTheme: AppBarTheme(
        titleTextStyle: textTheme.titleLarge,
        backgroundColor: lightColorScheme.surfaceContainer,
      ),
      fontFamily: fontFamily,
      extensions: [
        sectionTheme,
        lightToolCardTheme,
        lightChatTheme,
        ModuleThemes.blue,
        SessionThemes.main,
      ],
    );
  }

  static ThemeData get dark {
    return ThemeData(
      useMaterial3: true,
      colorScheme: darkColorScheme,
      bottomAppBarTheme: BottomAppBarThemeData(
        color: darkColorScheme.primary,
        elevation: 0,
      ),
      bottomNavigationBarTheme: BottomNavigationBarThemeData(
        showSelectedLabels: true,
        type: BottomNavigationBarType.fixed,
        backgroundColor: darkColorScheme.primary,
        selectedItemColor: darkColorScheme.onPrimary,
        selectedLabelStyle: const TextStyle(
          fontSize: 12,
          fontWeight: FontWeight.bold,
        ),
        unselectedLabelStyle: const TextStyle(
          fontSize: 12,
          fontWeight: FontWeight.bold,
        ),
        unselectedItemColor: Color.lerp(
          darkColorScheme.onPrimary,
          darkColorScheme.primary,
          0.3,
        ),
      ),
      scaffoldBackgroundColor: darkColorScheme.surface,
      textTheme: textTheme,
      appBarTheme: AppBarTheme(
        titleTextStyle: textTheme.titleLarge,
        backgroundColor: darkColorScheme.surfaceContainer,
      ),
      fontFamily: fontFamily,
      extensions: [
        sectionTheme,
        darkToolCardTheme,
        darkChatTheme,
        ModuleThemes.blue,
        SessionThemes.main,
      ],
    );
  }
}
