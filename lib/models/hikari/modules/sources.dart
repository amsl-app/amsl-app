import 'package:json_annotation/json_annotation.dart';

part 'sources.g.dart';

@JsonSerializable()
class SessionSource {
  @JsonKey(name: "file_name")
  final String fileName;
  @JsonKey(name: "file_id")
  final String fileId;

  SessionSource({required this.fileName, required this.fileId});

  factory SessionSource.fromJson(Map<String, dynamic> json) =>
      _$SessionSourceFromJson(json);

  Map<String, dynamic> toJson() => _$SessionSourceToJson(this);
}
