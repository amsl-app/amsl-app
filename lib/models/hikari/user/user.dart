import 'package:amsl_app/variants.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'user.g.dart';

@JsonSerializable()
class User {
  final bool onboarding;
  final String id;
  final DateTime? birthday;
  final Gender? gender;
  final String? name;
  final int? semester;
  final String? subject;
  final List<String> groups;

  User({
    required this.onboarding,
    required this.id,
    List<String>? groups,
    this.birthday,
    this.gender,
    this.name,
    this.semester,
    this.subject,
  }) : groups = groups ?? [];

  factory User.fromJson(Map<String, dynamic> json) => _$UserFromJson(json);

  Map<String, dynamic> toJson() => _$UserToJson(this);

  Variant get variant {
    return Variant(
      journalEnabled: !groups.contains("no-journal"),
      keyCompetenceEnabled: !groups.contains("no-key-competence"),
      onboardingEnabled: !groups.contains("no-onboarding"),
    );
  }
}

@JsonEnum(fieldRename: FieldRename.screamingSnake)
enum Gender { male, female, other }
