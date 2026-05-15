import 'dart:convert';

import 'package:amsl_app/hikari/hikari_api.dart';
import 'package:amsl_app/models/hikari/quiz/question.dart';
import 'package:amsl_app/models/hikari/quiz/quiz.dart';
import 'package:amsl_app/models/hikari/quiz/score.dart';
import 'package:logging/logging.dart';

class HikariQuizApi {
  final BaseHikariApiClient hikari;
  static final log = Logger('hikariQuizApi');

  const HikariQuizApi(this.hikari);

  Future<List<Quiz>> getQuizzes() async => hikari.get(
    "/quizzes",
    queryParameters: {"deep": "true"},
    transform: (json) {
      List<Quiz> quizzes = [];
      for (Map<String, dynamic> element in json) {
        quizzes.add(Quiz.fromJson(element));
      }
      return quizzes;
    },
  );

  Future<Quiz> getQuiz(String quizId) async => hikari.get(
    "/quizzes/$quizId",
    transform: (json) {
      log.info("Loeaded Quiz: $quizId");
      return Quiz.fromJson(json);
    },
  );

  Future<Quiz> startQuiz(String moduleId, List<String> sessionIds) async =>
      hikari.post(
        "/modules/$moduleId/quizzes/start",
        body: json.encode({"session_ids": sessionIds}),
        transform: (json) {
          log.info("Started new Quiz");
          return Quiz.fromJson(json);
        },
      );

  Future<Question> getNextQuestion(String quizId) async => hikari.get(
    "/quizzes/$quizId/questions/next",
    transform: (json) {
      log.info("Next Question for quiz $quizId");
      return Question.fromJson(json);
    },
  );

  Future<Question> answerQuestion(
    String quizId,
    String questionId,
    String answer,
  ) async => hikari.post(
    "/quizzes/$quizId/questions/$questionId/answer",
    body: json.encode({"answer": answer}),
    transform: (json) {
      log.info("Answered Question $questionId for quiz $quizId");
      return Question.fromJson(json);
    },
  );

  Future skipQuestion(String quizId, String questionId) async =>
      hikari.post("/quizzes/$quizId/questions/$questionId/skip");

  Future feedbackQuestion(
    String quizId,
    String questionId,
    String feedback,
    String? explanation,
  ) async => hikari.post(
    "/quizzes/$quizId/questions/$questionId/feedback",
    body: json.encode({
      "feedback": feedback,
      "feedback_explanation": explanation,
    }),
  );

  Future<List<QuizScore>> loadScores() => hikari.get(
    "/quizzes/scores",
    transform: (json) {
      List<QuizScore> scores = [];
      for (Map<String, dynamic> element in json) {
        scores.add(QuizScore.fromJson(element));
      }
      return scores;
    },
  );

  Future<List<QuizScore>> loadModuleScores(String moduleId) => hikari.get(
    "/modules/$moduleId/quizzes/scores",
    transform: (json) {
      List<QuizScore> scores = [];
      for (Map<String, dynamic> element in json['scores']) {
        scores.add(QuizScore.fromJson(element));
      }
      return scores;
    },
  );
}
