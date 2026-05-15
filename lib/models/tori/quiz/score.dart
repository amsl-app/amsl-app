import 'package:amsl_app/models/hikari/quiz/score.dart' as hikari_quiz;

class Score {
  String moduleId;
  String sessionId;
  String topic;
  int score;

  Score({
    required this.moduleId,
    required this.sessionId,
    required this.topic,
    required this.score,
  });

  factory Score.fromHikari(hikari_quiz.QuizScore hikariScore) {
    return Score(
      moduleId: hikariScore.moduleId,
      sessionId: hikariScore.sessionId,
      topic: hikariScore.topic,
      score: hikariScore.score,
    );
  }
}
