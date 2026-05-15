// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'user.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

User _$UserFromJson(Map<String, dynamic> json) => User(
  onboarding: json['onboarding'] as bool,
  id: json['id'] as String,
  groups: (json['groups'] as List<dynamic>?)?.map((e) => e as String).toList(),
  birthday: json['birthday'] == null
      ? null
      : DateTime.parse(json['birthday'] as String),
  gender: $enumDecodeNullable(_$GenderEnumMap, json['gender']),
  name: json['name'] as String?,
  semester: (json['semester'] as num?)?.toInt(),
  subject: json['subject'] as String?,
);

Map<String, dynamic> _$UserToJson(User instance) => <String, dynamic>{
  'onboarding': instance.onboarding,
  'id': instance.id,
  'birthday': instance.birthday?.toIso8601String(),
  'gender': _$GenderEnumMap[instance.gender],
  'name': instance.name,
  'semester': instance.semester,
  'subject': instance.subject,
  'groups': instance.groups,
};

const _$GenderEnumMap = {
  Gender.male: 'MALE',
  Gender.female: 'FEMALE',
  Gender.other: 'OTHER',
};
