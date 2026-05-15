import 'package:freezed_annotation/freezed_annotation.dart';

part 'question.freezed.dart';
part 'question.g.dart';

@JsonEnum(fieldRename: FieldRename.snake)
enum BloomLevel { remember, understand, apply, analyze, evaluate, create }

@JsonEnum(fieldRename: FieldRename.snake)
enum QuestionType { multipleChoice, text }

@freezed
abstract class QuestionOptions with _$QuestionOptions {
  factory QuestionOptions({required String option, bool? correct}) =
      _QuestionOptions;

  factory QuestionOptions.fromJson(Map<String, dynamic> json) =>
      _$QuestionOptionsFromJson(json);
}

@JsonEnum(fieldRename: FieldRename.snake)
enum QuestionStatus { open, finished, skipped }

@freezed
abstract class Question with _$Question {
  factory Question({
    required String id,
    @JsonKey(name: "quiz_id") required String quizId,
    @JsonKey(name: "session_id") required String sessionId,
    required String topic,
    required String content,
    required String question,
    required BloomLevel level,
    required QuestionStatus status,
    @Default(QuestionType.text) QuestionType type,
    List<QuestionOptions>? options,
    @JsonKey(name: "ai_solution") String? aiSolution,
    String? answer,
    String? evaluation,
    int? grade,
  }) = _Question;

  factory Question.fromJson(Map<String, dynamic> json) =>
      _$QuestionFromJson(json);
}
