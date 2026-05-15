// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'session_theme.dart';

// **************************************************************************
// TailorAnnotationsGenerator
// **************************************************************************

mixin _$SessionThemeTailorMixin on ThemeExtension<SessionTheme> {
  Color get textColor;
  Color get descriptionColor;

  @override
  SessionTheme copyWith({Color? textColor, Color? descriptionColor}) {
    return SessionTheme(
      textColor: textColor ?? this.textColor,
      descriptionColor: descriptionColor ?? this.descriptionColor,
    );
  }

  @override
  SessionTheme lerp(covariant ThemeExtension<SessionTheme>? other, double t) {
    if (other is! SessionTheme) return this as SessionTheme;
    return SessionTheme(
      textColor: Color.lerp(textColor, other.textColor, t)!,
      descriptionColor: Color.lerp(
        descriptionColor,
        other.descriptionColor,
        t,
      )!,
    );
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is SessionTheme &&
            const DeepCollectionEquality().equals(textColor, other.textColor) &&
            const DeepCollectionEquality().equals(
              descriptionColor,
              other.descriptionColor,
            ));
  }

  @override
  int get hashCode {
    return Object.hash(
      runtimeType.hashCode,
      const DeepCollectionEquality().hash(textColor),
      const DeepCollectionEquality().hash(descriptionColor),
    );
  }
}

extension SessionThemeThemeData on ThemeData {
  SessionTheme get sessionTheme => extension<SessionTheme>()!;
}
