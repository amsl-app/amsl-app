import 'package:amsl_app/features/journal/models/focus_icons.dart';
import 'package:amsl_app/models/hikari/journal/entry/journal_focus.dart'
    as hikari_focus;
import 'package:flutter/material.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'journal_focus.freezed.dart';

@freezed
abstract class JournalFocus with _$JournalFocus {
  const JournalFocus._();

  const factory JournalFocus({
    required String id,
    required String name,
    required String iconString,
    @Default(false) bool hidden,
    String? userId,
  }) = _JournalFocus;

  Widget getIcon({double? width, double? height, Color? color}) {
    return FocusIcons.getIconFromString(
          iconString,
          width: width,
          height: height,
          color: color,
        ) ??
        SizedBox(width: width, height: height);
  }

  factory JournalFocus.fromHikari(hikari_focus.JournalFocus focus) =>
      JournalFocus(
        id: focus.id,
        userId: focus.userID,
        name: focus.name,
        iconString: focus.iconString,
        hidden: focus.hidden,
      );
}
