import 'package:amsl_app/models/hikari/quiz/question.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'quiz.freezed.dart';
part 'quiz.g.dart';

@JsonEnum(fieldRename: FieldRename.snake)
enum QuizStatus { open, closed }

@freezed
abstract class Quiz with _$Quiz {
  factory Quiz({
    required String id,
    @JsonKey(name: "module_id") required String moduleId,
    required QuizStatus status,
    @JsonKey(name: "created_at") required DateTime createdAt,
    @JsonKey(name: "session_ids") required List<String> sessionIds,
    @Default(<Question>[]) List<Question> questions,
  }) = _Quiz;

  factory Quiz.fromJson(Map<String, dynamic> json) => _$QuizFromJson(json);
}
