// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'planner_theme.dart';

// **************************************************************************
// TailorAnnotationsGenerator
// **************************************************************************

mixin _$PlannerThemeTailorMixin on ThemeExtension<PlannerTheme> {
  Color get lowPriorityBackground;
  Color get lowPriorityForeground;
  Color get mediumPriorityBackground;
  Color get mediumPriorityForeground;
  Color get highPriorityBackground;
  Color get highPriorityForeground;

  @override
  PlannerTheme copyWith({
    Color? lowPriorityBackground,
    Color? lowPriorityForeground,
    Color? mediumPriorityBackground,
    Color? mediumPriorityForeground,
    Color? highPriorityBackground,
    Color? highPriorityForeground,
  }) {
    return PlannerTheme(
      lowPriorityBackground:
          lowPriorityBackground ?? this.lowPriorityBackground,
      lowPriorityForeground:
          lowPriorityForeground ?? this.lowPriorityForeground,
      mediumPriorityBackground:
          mediumPriorityBackground ?? this.mediumPriorityBackground,
      mediumPriorityForeground:
          mediumPriorityForeground ?? this.mediumPriorityForeground,
      highPriorityBackground:
          highPriorityBackground ?? this.highPriorityBackground,
      highPriorityForeground:
          highPriorityForeground ?? this.highPriorityForeground,
    );
  }

  @override
  PlannerTheme lerp(covariant ThemeExtension<PlannerTheme>? other, double t) {
    if (other is! PlannerTheme) return this as PlannerTheme;
    return PlannerTheme(
      lowPriorityBackground: Color.lerp(
        lowPriorityBackground,
        other.lowPriorityBackground,
        t,
      )!,
      lowPriorityForeground: Color.lerp(
        lowPriorityForeground,
        other.lowPriorityForeground,
        t,
      )!,
      mediumPriorityBackground: Color.lerp(
        mediumPriorityBackground,
        other.mediumPriorityBackground,
        t,
      )!,
      mediumPriorityForeground: Color.lerp(
        mediumPriorityForeground,
        other.mediumPriorityForeground,
        t,
      )!,
      highPriorityBackground: Color.lerp(
        highPriorityBackground,
        other.highPriorityBackground,
        t,
      )!,
      highPriorityForeground: Color.lerp(
        highPriorityForeground,
        other.highPriorityForeground,
        t,
      )!,
    );
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is PlannerTheme &&
            const DeepCollectionEquality().equals(
              lowPriorityBackground,
              other.lowPriorityBackground,
            ) &&
            const DeepCollectionEquality().equals(
              lowPriorityForeground,
              other.lowPriorityForeground,
            ) &&
            const DeepCollectionEquality().equals(
              mediumPriorityBackground,
              other.mediumPriorityBackground,
            ) &&
            const DeepCollectionEquality().equals(
              mediumPriorityForeground,
              other.mediumPriorityForeground,
            ) &&
            const DeepCollectionEquality().equals(
              highPriorityBackground,
              other.highPriorityBackground,
            ) &&
            const DeepCollectionEquality().equals(
              highPriorityForeground,
              other.highPriorityForeground,
            ));
  }

  @override
  int get hashCode {
    return Object.hash(
      runtimeType.hashCode,
      const DeepCollectionEquality().hash(lowPriorityBackground),
      const DeepCollectionEquality().hash(lowPriorityForeground),
      const DeepCollectionEquality().hash(mediumPriorityBackground),
      const DeepCollectionEquality().hash(mediumPriorityForeground),
      const DeepCollectionEquality().hash(highPriorityBackground),
      const DeepCollectionEquality().hash(highPriorityForeground),
    );
  }
}

extension PlannerThemeThemeData on ThemeData {
  PlannerTheme get plannerTheme => extension<PlannerTheme>()!;
}
