// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'journal_focus.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_JournalFocus _$JournalFocusFromJson(Map<String, dynamic> json) =>
    _JournalFocus(
      id: json['id'] as String,
      name: json['name'] as String,
      iconString: json['icon'] as String,
      hidden: json['hidden'] as bool,
      userID: json['user_id'] as String?,
    );

Map<String, dynamic> _$JournalFocusToJson(_JournalFocus instance) =>
    <String, dynamic>{
      'id': instance.id,
      'name': instance.name,
      'icon': instance.iconString,
      'hidden': instance.hidden,
      'user_id': instance.userID,
    };
