// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'progress_bar_theme.dart';

// **************************************************************************
// TailorAnnotationsGenerator
// **************************************************************************

mixin _$ProgressBarThemeTailorMixin on ThemeExtension<ProgressBarTheme> {
  Color get color;
  Color get trackColor;
  Color get textColor;

  @override
  ProgressBarTheme copyWith({
    Color? color,
    Color? trackColor,
    Color? textColor,
  }) {
    return ProgressBarTheme(
      color: color ?? this.color,
      trackColor: trackColor ?? this.trackColor,
      textColor: textColor ?? this.textColor,
    );
  }

  @override
  ProgressBarTheme lerp(
    covariant ThemeExtension<ProgressBarTheme>? other,
    double t,
  ) {
    if (other is! ProgressBarTheme) return this as ProgressBarTheme;
    return ProgressBarTheme(
      color: Color.lerp(color, other.color, t)!,
      trackColor: Color.lerp(trackColor, other.trackColor, t)!,
      textColor: Color.lerp(textColor, other.textColor, t)!,
    );
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is ProgressBarTheme &&
            const DeepCollectionEquality().equals(color, other.color) &&
            const DeepCollectionEquality().equals(
              trackColor,
              other.trackColor,
            ) &&
            const DeepCollectionEquality().equals(textColor, other.textColor));
  }

  @override
  int get hashCode {
    return Object.hash(
      runtimeType.hashCode,
      const DeepCollectionEquality().hash(color),
      const DeepCollectionEquality().hash(trackColor),
      const DeepCollectionEquality().hash(textColor),
    );
  }
}
