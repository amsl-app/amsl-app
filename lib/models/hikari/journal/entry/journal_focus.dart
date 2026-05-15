import 'package:freezed_annotation/freezed_annotation.dart';

part 'journal_focus.freezed.dart';
part 'journal_focus.g.dart';

@freezed
abstract class JournalFocus with _$JournalFocus {
  const factory JournalFocus({
    required String id,
    required String name,
    @JsonKey(name: "icon") required String iconString,
    required bool hidden,
    @JsonKey(name: "user_id") String? userID,
  }) = _JournalFocus;

  factory JournalFocus.fromJson(Map<String, dynamic> json) =>
      _$JournalFocusFromJson(json);
}
