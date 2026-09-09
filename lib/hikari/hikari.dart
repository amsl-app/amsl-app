import 'package:amsl_app/hikari/apis/hikari_assessment_api.dart';
import 'package:amsl_app/hikari/apis/hikari_journal_api.dart';
import 'package:amsl_app/hikari/apis/hikari_planner_api.dart';
import 'package:amsl_app/hikari/apis/hikari_quiz_api.dart';
import 'package:amsl_app/hikari/hikari_api.dart';
import 'package:logging/logging.dart';

import 'apis/hikari_module_api.dart';
import 'apis/hikari_user_api.dart';
import 'apis/hikari_util_api.dart';

class Hikari {
  static final log = Logger('hikari');
  final BaseHikariApiClient apiClient;

  final HikariAssessmentApi assessmentApi;
  final HikariJournalApi journalApi;
  final HikariModuleApi moduleApi;
  final HikariUserApi userApi;
  final HikariUtilApi utilApi;
  final HikariQuizApi quizApi;
  final HikariPlannerApi plannerApi;

  Hikari({required this.apiClient})
    : assessmentApi = HikariAssessmentApi(apiClient),
      journalApi = HikariJournalApi(apiClient),
      moduleApi = HikariModuleApi(apiClient),
      userApi = HikariUserApi(apiClient),
      utilApi = HikariUtilApi(apiClient),
      quizApi = HikariQuizApi(apiClient),
      plannerApi = HikariPlannerApi(apiClient);
}
