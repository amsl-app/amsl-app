import 'package:json_annotation/json_annotation.dart';
import 'package:logging/logging.dart';
import 'created_entity.dart';
import 'message.dart';

part 'post.g.dart';

@JsonSerializable()
class Post {
  static final log = Logger('Post');
  Post({
    required this.conversationEnd,
    this.createdEntities,
    required this.messages,
    this.history = false,
  });

  @JsonKey(name: "conversation_end")
  bool conversationEnd;
  List<Message> messages;
  bool history;
  @JsonKey(name: "created_entities")
  List<CreatedEntity>? createdEntities;

  factory Post.fromJson(Map<String, dynamic> json) {
    log.fine("PostFromChat: $json");
    return _$PostFromJson(json);
  }

  Map<String, dynamic> toJson() => _$PostToJson(this);

  @override
  String toString() {
    return 'Post{conversationEnd: $conversationEnd, messages: $messages, history: $history, createdEntities: $createdEntities}';
  }
}
