import 'package:freezed_annotation/freezed_annotation.dart';
import '../../hikari/quiz/question.dart' as hikari_question;

part 'question.freezed.dart';

@freezed
abstract class QuestionOption with _$QuestionOption {
  const factory QuestionOption({
    required String option,
    required bool? correct,
  }) = _QuestionOption;
}

@freezed
abstract class Question with _$Question {
  const factory Question({
    required String id,
    required String quizId,
    required String sessionId,
    required String topic,
    required String content,
    required String question,
    List<QuestionOption>? options,
    required hikari_question.QuestionType type,
    required hikari_question.QuestionStatus status,
    required String? aiSolution,
    required hikari_question.BloomLevel level,
    String? answer,
    String? evaluation,
    int? grade,
  }) = _Question;

  factory Question.fromHikari(hikari_question.Question question) => Question(
    id: question.id,
    quizId: question.quizId,
    sessionId: question.sessionId,
    topic: question.topic,
    content: question.content,
    question: question.question,
    options: question.options
        ?.map(
          (option) =>
              QuestionOption(option: option.option, correct: option.correct),
        )
        .toList(),
    type: question.type,
    status: question.status,
    aiSolution: question.aiSolution,
    level: question.level,
    answer: question.answer,
    evaluation: question.evaluation,
    grade: question.grade,
  );
}
