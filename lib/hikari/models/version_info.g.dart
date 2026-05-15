// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'version_info.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

VersionDescription _$VersionDescriptionFromJson(Map<String, dynamic> json) =>
    VersionDescription(min: json['min'] as String);

Map<String, dynamic> _$VersionDescriptionToJson(VersionDescription instance) =>
    <String, dynamic>{'min': instance.min};

VersionInfo _$VersionInfoFromJson(Map<String, dynamic> json) => VersionInfo(
  frontend: VersionDescription.fromJson(
    json['frontend'] as Map<String, dynamic>,
  ),
);

Map<String, dynamic> _$VersionInfoToJson(VersionInfo instance) =>
    <String, dynamic>{'frontend': instance.frontend};
