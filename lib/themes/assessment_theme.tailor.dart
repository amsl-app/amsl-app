// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'assessment_theme.dart';

// **************************************************************************
// TailorAnnotationsGenerator
// **************************************************************************

mixin _$AssessmentThemeTailorMixin on ThemeExtension<AssessmentTheme> {
  List<Color> get scaleColors;

  @override
  AssessmentTheme copyWith({List<Color>? scaleColors}) {
    return AssessmentTheme(scaleColors: scaleColors ?? this.scaleColors);
  }

  @override
  AssessmentTheme lerp(
    covariant ThemeExtension<AssessmentTheme>? other,
    double t,
  ) {
    if (other is! AssessmentTheme) return this as AssessmentTheme;
    return AssessmentTheme(
      scaleColors: t < 0.5 ? scaleColors : other.scaleColors,
    );
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is AssessmentTheme &&
            const DeepCollectionEquality().equals(
              scaleColors,
              other.scaleColors,
            ));
  }

  @override
  int get hashCode {
    return Object.hash(
      runtimeType.hashCode,
      const DeepCollectionEquality().hash(scaleColors),
    );
  }
}

extension AssessmentThemeThemeData on ThemeData {
  AssessmentTheme get assessmentTheme => extension<AssessmentTheme>()!;
}
