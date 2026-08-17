import 'package:json_annotation/json_annotation.dart';

part 'video_content.g.dart';

@JsonSerializable()
class VideoContent {
  VideoContent({this.videoUrl});

  @JsonKey(name: 'video_url')
  String? videoUrl;

  factory VideoContent.fromJson(Map<String, dynamic> json) =>
      _$VideoContentFromJson(json);

  Map<String, dynamic> toJson() => _$VideoContentToJson(this);

  @override
  String toString() {
    return 'VideoContent{videoUrl: $videoUrl}';
  }
}
