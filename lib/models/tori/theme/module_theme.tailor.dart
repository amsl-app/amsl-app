// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'module_theme.dart';

// **************************************************************************
// TailorAnnotationsGenerator
// **************************************************************************

mixin _$ModuleThemeTailorMixin on ThemeExtension<ModuleTheme> {
  Color get color;
  Color get containerColor;
  Color get textColor;
  Color get descriptionColor;
  ProgressBarTheme get progressBarTheme;
  SessionTheme get sessionTheme;

  @override
  ModuleTheme copyWith({
    Color? color,
    Color? containerColor,
    Color? textColor,
    Color? descriptionColor,
    ProgressBarTheme? progressBarTheme,
    SessionTheme? sessionTheme,
  }) {
    return ModuleTheme(
      color: color ?? this.color,
      containerColor: containerColor ?? this.containerColor,
      textColor: textColor ?? this.textColor,
      descriptionColor: descriptionColor ?? this.descriptionColor,
      progressBarTheme: progressBarTheme ?? this.progressBarTheme,
      sessionTheme: sessionTheme ?? this.sessionTheme,
    );
  }

  @override
  ModuleTheme lerp(covariant ThemeExtension<ModuleTheme>? other, double t) {
    if (other is! ModuleTheme) return this as ModuleTheme;
    return ModuleTheme(
      color: Color.lerp(color, other.color, t)!,
      containerColor: Color.lerp(containerColor, other.containerColor, t)!,
      textColor: Color.lerp(textColor, other.textColor, t)!,
      descriptionColor: Color.lerp(
        descriptionColor,
        other.descriptionColor,
        t,
      )!,
      progressBarTheme: progressBarTheme.lerp(other.progressBarTheme, t),
      sessionTheme: sessionTheme.lerp(other.sessionTheme, t),
    );
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is ModuleTheme &&
            const DeepCollectionEquality().equals(color, other.color) &&
            const DeepCollectionEquality().equals(
              containerColor,
              other.containerColor,
            ) &&
            const DeepCollectionEquality().equals(textColor, other.textColor) &&
            const DeepCollectionEquality().equals(
              descriptionColor,
              other.descriptionColor,
            ) &&
            const DeepCollectionEquality().equals(
              progressBarTheme,
              other.progressBarTheme,
            ) &&
            const DeepCollectionEquality().equals(
              sessionTheme,
              other.sessionTheme,
            ));
  }

  @override
  int get hashCode {
    return Object.hash(
      runtimeType.hashCode,
      const DeepCollectionEquality().hash(color),
      const DeepCollectionEquality().hash(containerColor),
      const DeepCollectionEquality().hash(textColor),
      const DeepCollectionEquality().hash(descriptionColor),
      const DeepCollectionEquality().hash(progressBarTheme),
      const DeepCollectionEquality().hash(sessionTheme),
    );
  }
}

extension ModuleThemeThemeData on ThemeData {
  ModuleTheme get moduleTheme => extension<ModuleTheme>()!;
}
