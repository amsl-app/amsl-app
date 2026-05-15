import 'package:amsl_app/models/hikari/assessments/question.dart';
import 'package:amsl_app/models/hikari/assessments/scale.dart';
import 'package:json_annotation/json_annotation.dart';

part 'assessment.g.dart';

@JsonSerializable()
class Assessment {
  @JsonKey(name: "assessment_id")
  final String assessmentId;
  final String title;
  final List<Question> questions;
  final List<Scale> scales;

  Assessment({
    required this.assessmentId,
    required this.title,
    required this.questions,
    required this.scales,
  });

  Map<String, dynamic> toJson() => _$AssessmentToJson(this);

  factory Assessment.fromJson(Map<String, dynamic> json) =>
      _$AssessmentFromJson(json);
}
