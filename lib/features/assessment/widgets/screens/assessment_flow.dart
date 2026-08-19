import 'package:amsl_app/models/hikari/assessments/assessment_session.dart'
    as hikari_assessment;

sealed class AssessmentFlow {
  const AssessmentFlow();
}

class ModuleAssessmentFlow extends AssessmentFlow {
  final String moduleID;
  final hikari_assessment.AssessmentType prePost;

  const ModuleAssessmentFlow({required this.moduleID, required this.prePost});
}

class SelfAssessmentFlow extends AssessmentFlow {
  final List<String> assessmentIds;

  const SelfAssessmentFlow({required this.assessmentIds});
}
