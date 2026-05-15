// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'tool_card_theme.dart';

// **************************************************************************
// TailorAnnotationsGenerator
// **************************************************************************

mixin _$ToolCardThemeTailorMixin on ThemeExtension<ToolCardTheme> {
  Color get backgroundColor;
  Color get decorationColor;
  TextStyle get labelStyle;

  @override
  ToolCardTheme copyWith({
    Color? backgroundColor,
    Color? decorationColor,
    TextStyle? labelStyle,
  }) {
    return ToolCardTheme(
      backgroundColor: backgroundColor ?? this.backgroundColor,
      decorationColor: decorationColor ?? this.decorationColor,
      labelStyle: labelStyle ?? this.labelStyle,
    );
  }

  @override
  ToolCardTheme lerp(covariant ThemeExtension<ToolCardTheme>? other, double t) {
    if (other is! ToolCardTheme) return this as ToolCardTheme;
    return ToolCardTheme(
      backgroundColor: Color.lerp(backgroundColor, other.backgroundColor, t)!,
      decorationColor: Color.lerp(decorationColor, other.decorationColor, t)!,
      labelStyle: TextStyle.lerp(labelStyle, other.labelStyle, t)!,
    );
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is ToolCardTheme &&
            const DeepCollectionEquality().equals(
              backgroundColor,
              other.backgroundColor,
            ) &&
            const DeepCollectionEquality().equals(
              decorationColor,
              other.decorationColor,
            ) &&
            const DeepCollectionEquality().equals(
              labelStyle,
              other.labelStyle,
            ));
  }

  @override
  int get hashCode {
    return Object.hash(
      runtimeType.hashCode,
      const DeepCollectionEquality().hash(backgroundColor),
      const DeepCollectionEquality().hash(decorationColor),
      const DeepCollectionEquality().hash(labelStyle),
    );
  }
}

extension ToolCardThemeThemeData on ThemeData {
  ToolCardTheme get toolCardTheme => extension<ToolCardTheme>()!;
}
