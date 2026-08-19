import 'package:json_annotation/json_annotation.dart';

part 'scale_data.g.dart';

@JsonSerializable()
class ScaleData {
  final String id;
  final String title;
  final double value;

  ScaleData({required this.title, required this.id, required this.value});

  factory ScaleData.fromJson(Map<String, dynamic> json) =>
      _$ScaleDataFromJson(json);

  Map<String, dynamic> toJson() => _$ScaleDataToJson(this);

  @override
  String toString() {
    return 'ScaleData(id: $id, title: $title, value: $value)';
  }
}

@JsonSerializable()
class TimedScaleData {
  final DateTime completed;
  final List<ScaleData> scales;

  TimedScaleData({required this.completed, required this.scales});

  factory TimedScaleData.fromJson(Map<String, dynamic> json) =>
      _$TimedScaleDataFromJson(json);

  Map<String, dynamic> toJson() => _$TimedScaleDataToJson(this);

  @override
  String toString() {
    return 'TimedScaleData(completed: $completed, scales: $scales)';
  }
}

@JsonSerializable()
class AssessmentScaleData {
  @JsonKey(name: 'assessment_id')
  final String assessmentId;
  final List<TimedScaleData> sessions;

  AssessmentScaleData({required this.assessmentId, required this.sessions});

  factory AssessmentScaleData.fromJson(Map<String, dynamic> json) =>
      _$AssessmentScaleDataFromJson(json);

  Map<String, dynamic> toJson() => _$AssessmentScaleDataToJson(this);

  @override
  String toString() {
    return 'AssessmentScaleData(assessmentId: $assessmentId, scales: $sessions)';
  }
}
