import 'package:amsl_app/models/hikari/assessments/assessment.dart';
import 'package:json_annotation/json_annotation.dart';

part 'assessment_session.g.dart';

@JsonEnum(fieldRename: FieldRename.snake)
enum AssessmentStatus { notStarted, running, finished }

@JsonSerializable()
class AssessmentSession {
  final Assessment assessment;
  @JsonKey(name: "session_id")
  final String sessionId;
  final AssessmentStatus status;
  final DateTime? completed;

  const AssessmentSession({
    required this.assessment,
    required this.sessionId,
    required this.status,
    this.completed,
  });

  factory AssessmentSession.fromJson(Map<String, dynamic> json) =>
      _$AssessmentSessionFromJson(json);

  Map<String, dynamic> toJson() => _$AssessmentSessionToJson(this);
}

enum AssessmentType { pre, post }
