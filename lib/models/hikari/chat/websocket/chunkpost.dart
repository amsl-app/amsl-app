import 'package:json_annotation/json_annotation.dart';
import 'package:logging/logging.dart';

part 'chunkpost.g.dart';

@JsonSerializable()
class ChunkPost {
  static final log = Logger('ChunkPost');
  ChunkPost({required this.id, required this.content});

  int id;
  String content;

  factory ChunkPost.fromJson(Map<String, dynamic> json) {
    log.fine("PostFromChunk: $json");
    return _$ChunkPostFromJson(json);
  }

  Map<String, dynamic> toJson() => _$ChunkPostToJson(this);

  @override
  String toString() {
    return 'ChunkPost{messageId: $id, textChunk: $content}';
  }
}
