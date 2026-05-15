// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'chat_theme.dart';

// **************************************************************************
// TailorAnnotationsGenerator
// **************************************************************************

mixin _$ChatThemeTailorMixin on ThemeExtension<ChatTheme> {
  BubbleTheme get ownBubbles;
  BubbleTheme get otherBubbles;
  TextButtonThemeData get buttons;

  @override
  ChatTheme copyWith({
    BubbleTheme? ownBubbles,
    BubbleTheme? otherBubbles,
    TextButtonThemeData? buttons,
  }) {
    return ChatTheme(
      ownBubbles: ownBubbles ?? this.ownBubbles,
      otherBubbles: otherBubbles ?? this.otherBubbles,
      buttons: buttons ?? this.buttons,
    );
  }

  @override
  ChatTheme lerp(covariant ThemeExtension<ChatTheme>? other, double t) {
    if (other is! ChatTheme) return this as ChatTheme;
    return ChatTheme(
      ownBubbles: ownBubbles.lerp(other.ownBubbles, t),
      otherBubbles: otherBubbles.lerp(other.otherBubbles, t),
      buttons: t < 0.5 ? buttons : other.buttons,
    );
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is ChatTheme &&
            const DeepCollectionEquality().equals(
              ownBubbles,
              other.ownBubbles,
            ) &&
            const DeepCollectionEquality().equals(
              otherBubbles,
              other.otherBubbles,
            ) &&
            const DeepCollectionEquality().equals(buttons, other.buttons));
  }

  @override
  int get hashCode {
    return Object.hash(
      runtimeType.hashCode,
      const DeepCollectionEquality().hash(ownBubbles),
      const DeepCollectionEquality().hash(otherBubbles),
      const DeepCollectionEquality().hash(buttons),
    );
  }
}

extension ChatThemeThemeData on ThemeData {
  ChatTheme get chatTheme => extension<ChatTheme>()!;
}

mixin _$BubbleThemeTailorMixin on ThemeExtension<BubbleTheme> {
  Color get backgroundColor;
  TextStyle get textStyle;

  @override
  BubbleTheme copyWith({Color? backgroundColor, TextStyle? textStyle}) {
    return BubbleTheme(
      backgroundColor: backgroundColor ?? this.backgroundColor,
      textStyle: textStyle ?? this.textStyle,
    );
  }

  @override
  BubbleTheme lerp(covariant ThemeExtension<BubbleTheme>? other, double t) {
    if (other is! BubbleTheme) return this as BubbleTheme;
    return BubbleTheme(
      backgroundColor: Color.lerp(backgroundColor, other.backgroundColor, t)!,
      textStyle: TextStyle.lerp(textStyle, other.textStyle, t)!,
    );
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is BubbleTheme &&
            const DeepCollectionEquality().equals(
              backgroundColor,
              other.backgroundColor,
            ) &&
            const DeepCollectionEquality().equals(textStyle, other.textStyle));
  }

  @override
  int get hashCode {
    return Object.hash(
      runtimeType.hashCode,
      const DeepCollectionEquality().hash(backgroundColor),
      const DeepCollectionEquality().hash(textStyle),
    );
  }
}
