import 'package:freezed_annotation/freezed_annotation.dart';

part 'score.freezed.dart';
part 'score.g.dart';

@freezed
abstract class QuizScore with _$QuizScore {
  factory QuizScore({
    @JsonKey(name: "module_id") required String moduleId,
    @JsonKey(name: "session_id") required String sessionId,
    required String topic,
    required int score,
  }) = _QuizScore;

  factory QuizScore.fromJson(Map<String, dynamic> json) =>
      _$QuizScoreFromJson(json);
}
