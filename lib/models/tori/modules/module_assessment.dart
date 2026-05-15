import 'package:amsl_app/models/hikari/assessments/assessment_session.dart'
    as hikari_assessment;
import 'package:amsl_app/models/tori/modules/module.dart';

import '../assessments/assessment_session.dart';

class ModuleAssessmentSet {
  final Module module;
  final ModuleAssessmentSession preAssessment;
  final ModuleAssessmentSession postAssessment;

  ModuleAssessmentSet({
    required this.module,
    required this.preAssessment,
    required this.postAssessment,
  });

  bool get isDone {
    return !assessmentToDo && module.completion != null;
  }

  bool get assessmentToDo {
    return preAssessment.isOpen || postAssessment.isOpen;
  }

  int get sessionsToDo => module.sessionsToDo;

  int get sessionsDone => module.doneCount;

  bool get isStarted => module.started || preAssessment.isStarted;

  bool get isRunning => !isDone && isStarted;

  DateTime? get completion {
    if (postAssessment.isDefined) {
      return postAssessment.assessmentSession?.completed;
    } else {
      return module.completion;
    }
  }

  @override
  String toString() {
    return 'ModuleAssessmentSet{module: $module, preAssessment: $preAssessment (open: ${preAssessment.isOpen}), postAssessment: $postAssessment (open: ${postAssessment.isOpen}), isDone: $isDone, completion: ${module.completion}';
  }
}

class ModuleAssessmentSession {
  final ToriAssessmentSession? assessmentSession;
  final bool isDefined;

  ModuleAssessmentSession({required this.isDefined, this.assessmentSession});

  bool get isOpen {
    return isDefined &&
        assessmentSession?.status !=
            hikari_assessment.AssessmentStatus.finished;
  }

  bool get isStarted {
    return isDefined &&
        assessmentSession != null &&
        assessmentSession!.status !=
            hikari_assessment.AssessmentStatus.notStarted;
  }
}
