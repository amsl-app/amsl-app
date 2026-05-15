import 'package:amsl_app/models/hikari/assessments/question_body.dart';
import 'package:json_annotation/json_annotation.dart';

part 'question.g.dart';

class Question {
  final String id;
  final String title;
  final QuestionBody body;
  final QuestionType type;
  final dynamic answer;

  const Question({
    required this.id,
    required this.title,
    required this.body,
    required this.type,
    this.answer,
  });

  factory Question.fromJson(Map<String, dynamic> json) {
    final type = $enumDecode(_$QuestionTypeEnumMap, json['type']);
    return Question(
      id: json['id'],
      title: json['title'],
      body: QuestionBody.fromJson(json['body'], type),
      type: type,
      answer: json['answer'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      "id": id,
      "title": title,
      "body": body.toJson(),
      "type": type,
      "answer": answer,
    };
  }
}

@JsonEnum(alwaysCreate: true, fieldRename: FieldRename.snake)
enum QuestionType {
  select,
  multiChoice,
  singleChoice,
  scale,
  textarea,
  textfield,
}
