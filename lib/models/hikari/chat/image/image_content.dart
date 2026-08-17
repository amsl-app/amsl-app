import 'package:json_annotation/json_annotation.dart';

part 'image_content.g.dart';

@JsonSerializable()
class ImageContent {
  ImageContent({this.imageUrl});

  @JsonKey(name: 'image_url')
  String? imageUrl;

  factory ImageContent.fromJson(Map<String, dynamic> json) =>
      _$ImageContentFromJson(json);

  Map<String, dynamic> toJson() => _$ImageContentToJson(this);
}
