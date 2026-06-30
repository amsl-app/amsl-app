import 'package:amsl_app/features/assessment/providers/assessment_sessions.dart';
import 'package:amsl_app/features/self_management/models/score_entry.dart';
import 'package:amsl_app/models/hikari/assessments/assessment_session.dart'
    as hikari_assessment;
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'competency_groups_provider.g.dart';

@Riverpod(dependencies: [AssessmentSessions])
Future<Map<String, List<ScoreEntry>>> competencyGroups(Ref ref) async {
  final sessions = await ref.watch(assessmentSessionsProvider.future);

  final grouped = <String, List<ScoreEntry>>{};

  for (final session in sessions.values) {
    if (session.status != hikari_assessment.AssessmentStatus.finished ||
        session.completed == null) {
      continue;
    }
    for (final scale in session.scales) {
      if (scale.value == null) continue;
      final entry = ScoreEntry(
        value: scale.value!,
        min: scale.min,
        max: scale.max,
        assessmentTitle: session.title,
        completed: session.completed!,
      );
      grouped.putIfAbsent(scale.title, () => []).add(entry);
    }
  }

  for (final entries in grouped.values) {
    entries.sort((a, b) => b.completed.compareTo(a.completed));
  }

  return grouped;
}
