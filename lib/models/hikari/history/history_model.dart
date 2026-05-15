import 'package:freezed_annotation/freezed_annotation.dart';

part 'history_model.g.dart';

sealed class HistoryModel {
  final DateTime completed;
  final HistoryType type;

  const HistoryModel({required this.completed, required this.type});

  static HistoryModel fromJson(Map<String, dynamic> json) {
    switch (HistoryType.values.byName(json['type'].toString().toLowerCase())) {
      case HistoryType.assessment:
        return AssessmentHistoryModel.fromJson(json);
      case HistoryType.module:
        return ModuleHistoryModel.fromJson(json);
      case HistoryType.session:
        return SessionHistoryModel.fromJson(json);
    }
  }
}

@JsonSerializable()
class AssessmentHistoryModel extends HistoryModel {
  @JsonKey(name: "assessment_type")
  final String assessmentType; //pre, post
  @JsonKey(name: "session_id")
  final String sessionId;

  AssessmentHistoryModel({
    required super.completed,
    required super.type,
    required this.assessmentType,
    required this.sessionId,
  });

  factory AssessmentHistoryModel.fromJson(Map<String, dynamic> json) =>
      _$AssessmentHistoryModelFromJson(json);

  Map<String, dynamic> toJson() => _$AssessmentHistoryModelToJson(this);
}

@JsonSerializable()
class ModuleHistoryModel extends HistoryModel {
  final String module;

  ModuleHistoryModel({
    required super.completed,
    required super.type,
    required this.module,
  });

  factory ModuleHistoryModel.fromJson(Map<String, dynamic> json) =>
      _$ModuleHistoryModelFromJson(json);

  Map<String, dynamic> toJson() => _$ModuleHistoryModelToJson(this);
}

@JsonSerializable()
class SessionHistoryModel extends HistoryModel {
  final String module;
  final String session;

  SessionHistoryModel({
    required super.completed,
    required super.type,
    required this.module,
    required this.session,
  });

  factory SessionHistoryModel.fromJson(Map<String, dynamic> json) =>
      _$SessionHistoryModelFromJson(json);

  Map<String, dynamic> toJson() => _$SessionHistoryModelToJson(this);

  @override
  String toString() {
    return "SessionHistoryModel { module: $module, session: $session }";
  }
}

enum HistoryType {
  @JsonValue("Assessment")
  assessment,
  @JsonValue("Module")
  module,
  @JsonValue("Session")
  session,
}
