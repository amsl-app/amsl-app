import 'package:amsl_app/models/hikari/quiz/quiz.dart' as hikari_quiz;
import 'package:amsl_app/models/tori/quiz/question.dart';

import 'package:freezed_annotation/freezed_annotation.dart';

part 'quiz.freezed.dart';

@freezed
abstract class Quiz with _$Quiz {
  const Quiz._();

  const factory Quiz({
    required String id,
    required String moduleId,
    required hikari_quiz.QuizStatus status,
    required DateTime createdAt,
    required List<String> sessionIds,
    required List<Question> questions,
  }) = _Quiz;

  factory Quiz.fromHikari(hikari_quiz.Quiz hikariQuiz) {
    return Quiz(
      id: hikariQuiz.id,
      moduleId: hikariQuiz.moduleId,
      status: hikariQuiz.status,
      createdAt: hikariQuiz.createdAt,
      sessionIds: hikariQuiz.sessionIds,
      questions: hikariQuiz.questions
          .map((q) => Question.fromHikari(q))
          .toList(),
    );
  }

  @override
  String toString() {
    return "Quiz(id: $id, moduleId: $moduleId, status: $status, createdAt: $createdAt, sessionIds: $sessionIds, questions: ${questions.length})";
  }
}
