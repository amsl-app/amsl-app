import 'package:json_annotation/json_annotation.dart';

part 'version_info.g.dart';

@JsonSerializable()
class VersionDescription {
  String min;

  VersionDescription({required this.min});

  factory VersionDescription.fromJson(Map<String, dynamic> json) =>
      _$VersionDescriptionFromJson(json);

  Map<String, dynamic> toJson() => _$VersionDescriptionToJson(this);
}

@JsonSerializable()
class VersionInfo {
  VersionDescription frontend;

  VersionInfo({required this.frontend});

  factory VersionInfo.fromJson(Map<String, dynamic> json) =>
      _$VersionInfoFromJson(json);

  Map<String, dynamic> toJson() => _$VersionInfoToJson(this);
}
