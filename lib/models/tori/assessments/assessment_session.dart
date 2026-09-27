import 'package:freezed_annotation/freezed_annotation.dart';
import '../../hikari/assessments/assessment_session.dart' as hikari_assessment;
import 'question.dart';

part 'assessment_session.freezed.dart';

@Freezed(copyWith: true)
abstract class ToriAssessmentSession with _$ToriAssessmentSession {
  factory ToriAssessmentSession({
    required String sessionId,
    required String assessmentId,
    required String title,
    required Map<String, Question> questions,
    required hikari_assessment.AssessmentStatus status,
    required DateTime? completed,
  }) = _ToriAssessmentSession;

  const ToriAssessmentSession._();

  factory ToriAssessmentSession.fromHikari(
    hikari_assessment.AssessmentSession session,
  ) {
    return ToriAssessmentSession(
      sessionId: session.sessionId,
      assessmentId: session.assessment.assessmentId,
      title: session.assessment.title,
      questions: {
        for (var question in session.assessment.questions)
          question.id: Question.fromHikari(question),
      },
      status: session.status,
      completed: session.completed,
    );
  }

  List<Map<String, dynamic>> questionsToJson() {
    return List.generate(
      questions.length,
      (index) => {
        "question_id": questions.values.elementAt(index).id,
        "value": questions.values.elementAt(index).answer,
      },
    );
  }
}
