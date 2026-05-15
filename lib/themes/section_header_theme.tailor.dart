// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'section_header_theme.dart';

// **************************************************************************
// TailorAnnotationsGenerator
// **************************************************************************

mixin _$SectionHeaderThemeTailorMixin on ThemeExtension<SectionHeaderTheme> {
  Color get iconColor;
  TextStyle get textStyle;

  @override
  SectionHeaderTheme copyWith({Color? iconColor, TextStyle? textStyle}) {
    return SectionHeaderTheme(
      iconColor: iconColor ?? this.iconColor,
      textStyle: textStyle ?? this.textStyle,
    );
  }

  @override
  SectionHeaderTheme lerp(
    covariant ThemeExtension<SectionHeaderTheme>? other,
    double t,
  ) {
    if (other is! SectionHeaderTheme) return this as SectionHeaderTheme;
    return SectionHeaderTheme(
      iconColor: Color.lerp(iconColor, other.iconColor, t)!,
      textStyle: TextStyle.lerp(textStyle, other.textStyle, t)!,
    );
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is SectionHeaderTheme &&
            const DeepCollectionEquality().equals(iconColor, other.iconColor) &&
            const DeepCollectionEquality().equals(textStyle, other.textStyle));
  }

  @override
  int get hashCode {
    return Object.hash(
      runtimeType.hashCode,
      const DeepCollectionEquality().hash(iconColor),
      const DeepCollectionEquality().hash(textStyle),
    );
  }
}

extension SectionHeaderThemeThemeData on ThemeData {
  SectionHeaderTheme get sectionHeaderTheme => extension<SectionHeaderTheme>()!;
}
