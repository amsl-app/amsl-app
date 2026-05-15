import 'package:amsl_app/hikari/exception.dart';
import 'package:amsl_app/hikari/hikari.dart';
import 'package:amsl_app/models/hikari/quiz/question.dart' as hikari_question;
import 'package:amsl_app/models/tori/quiz/question.dart';
import 'package:amsl_app/providers/hikari_provider.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

import '../../../models/tori/quiz/quiz.dart';

part 'quiz.g.dart';

@Riverpod(keepAlive: true, dependencies: [HikariPod])
class QuizProvider extends _$QuizProvider {
  @override
  Future<List<Quiz>> build() async {
    final hikari = ref.watch(hikariPodProvider);
    return _loadQuizzesFromApi(hikari);
  }

  Future<List<Quiz>> _loadQuizzesFromApi(Hikari hikari) async {
    try {
      final quizzes = await hikari.quizApi.getQuizzes();
      return quizzes.map((e) => Quiz.fromHikari(e)).toList();
    } on HikariException catch (e) {
      throw e.copyWith(resolve: reloadQuizzes);
    }
  }

  Future<List<Quiz>> reloadQuizzes() async {
    ref.invalidateSelf();
    return future;
  }

  Future<Quiz> startQuiz(String moduleId, List<String> sessionIds) async {
    final hikari = ref.read(hikariPodProvider);
    try {
      final quiz = await hikari.quizApi.startQuiz(moduleId, sessionIds);
      final tori_quiz = Quiz.fromHikari(quiz);
      reloadQuizzes(); // Since generating new quizzes has effects on other quizzes, we reload all quizzes
      return tori_quiz;
    } on HikariException catch (e) {
      throw e.copyWith(resolve: () => startQuiz(moduleId, sessionIds));
    }
  }

  Future<Question> getNextQuestion(String quizId) async {
    final hikari = ref.read(hikariPodProvider);
    try {
      final question = await hikari.quizApi.getNextQuestion(quizId);
      final tori_question = Question.fromHikari(question);
      _upsertQuestionInQuiz(quizId, tori_question);
      return tori_question;
    } on HikariException catch (e) {
      throw e.copyWith(resolve: () => getNextQuestion(quizId));
    }
  }

  Future<Question> submitAnswer(
    String quizId,
    String questionId,
    String answer,
  ) async {
    final hikari = ref.read(hikariPodProvider);
    try {
      final question = await hikari.quizApi.answerQuestion(
        quizId,
        questionId,
        answer,
      );
      final tori_question = Question.fromHikari(question);
      _upsertQuestionInQuiz(quizId, tori_question);
      return tori_question;
    } on HikariException catch (e) {
      throw e.copyWith(resolve: () => submitAnswer(quizId, questionId, answer));
    }
  }

  Future<Question> skipQuestion(String quizId, String questionId) async {
    final hikari = ref.read(hikariPodProvider);
    try {
      await hikari.quizApi.skipQuestion(quizId, questionId);
      final question = state.value!
          .firstWhere((quiz) => quiz.id == quizId)
          .questions
          .firstWhere((q) => q.id == questionId);
      final tori_question = question.copyWith(
        status: hikari_question.QuestionStatus.skipped,
      );
      _upsertQuestionInQuiz(quizId, tori_question);
      return tori_question;
    } on HikariException catch (e) {
      throw e.copyWith(resolve: () => skipQuestion(quizId, questionId));
    }
  }

  Future sendFeedback(
    String quizId,
    String questionId,
    String feedback,
    String? explanation,
  ) async {
    final hikari = ref.read(hikariPodProvider);
    try {
      await hikari.quizApi.feedbackQuestion(
        quizId,
        questionId,
        feedback,
        explanation,
      );
    } on HikariException catch (e) {
      throw e.copyWith(
        resolve: () => sendFeedback(quizId, questionId, feedback, explanation),
      );
    }
  }

  void _upsertQuestionInQuiz(String quizId, Question updatedQuestion) {
    update((state) async {
      return state.map((quiz) {
        if (quiz.id == quizId) {
          final questionIndex = quiz.questions.indexWhere(
            (q) => q.id == updatedQuestion.id,
          );
          final updatedQuestions = [...quiz.questions];
          if (questionIndex == -1) {
            updatedQuestions.add(updatedQuestion);
          } else {
            updatedQuestions[questionIndex] = updatedQuestion;
          }
          return quiz.copyWith(questions: updatedQuestions);
        }
        return quiz;
      }).toList();
    });
  }
}
