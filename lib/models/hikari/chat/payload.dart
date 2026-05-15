import 'package:amsl_app/models/hikari/chat/date_input/date_input_content.dart';
import 'package:amsl_app/models/hikari/chat/duration_input/duration_input_content.dart';
import 'package:amsl_app/models/hikari/chat/journal/focus_input_content.dart';
import 'package:amsl_app/models/hikari/chat/journal/journal_content_input_content.dart';
import 'package:amsl_app/models/hikari/chat/journal/journal_title_input_content.dart';
import 'package:amsl_app/models/hikari/chat/journal/mood_input_content.dart';
import 'package:json_annotation/json_annotation.dart';

import 'card/card_content.dart';
import 'carousel/carousel_content.dart';
import 'number_input/number_input_content.dart';
import 'payload_content.dart';

class Payload {
  Payload({required this.content, required this.contentType});

  dynamic content;
  @JsonKey(name: "content_type")
  String? contentType;

  static dynamic loadContent(
    String? contentType,
    Map<String, dynamic>? content,
  ) {
    switch (contentType) {
      case "durationinput":
        return DurationInputContent.fromJson(content!);
      case "journaltitleinput":
        return JournalTitleInputContent.fromJson(content!);
      case "journalcontentinput":
        return JournalContentInputContent.fromJson(content!);
      case "journalfocusinput":
        return FocusInputContent.fromJson(content!);
      case "journalmoodinput":
        return MoodInputContent.fromJson(content!);
      case "dateinput":
        return DateInputContent.fromJson(content!);
      case "numberinput":
        return NumberInputContent.fromJson(content!);
      case "carousel":
        return CarouselContent.fromJson(content!);
      case "card":
        return CardContent.fromJson(content!);
      default:
        return PayloadContent.fromJson(content ?? {});
    }
  }

  factory Payload.fromJson(Map<String, dynamic> json) => Payload(
    content: loadContent(
      json['content_type'] as String?,
      json['content'] as Map<String, dynamic>?,
    ),
    contentType: json['content_type'] as String?,
  );

  Map<String, dynamic> toJson() => <String, dynamic>{
    'content': content,
    'content_type': contentType,
  };

  @override
  String toString() {
    return "HikariPayload { content: $content, contentType: $contentType }";
  }
}
