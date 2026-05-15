import 'package:json_annotation/json_annotation.dart';

part 'access_approvals.g.dart';

@JsonSerializable()
class AccessApprovals {
  @JsonKey(name: "declaration_of_consent")
  final String declarationOfConsent;
  @JsonKey(name: "privacy_policy")
  final String privacyPolicy;
  @JsonKey(name: "participant_information")
  final String? participantInformation;

  AccessApprovals({
    required this.declarationOfConsent,
    required this.privacyPolicy,
    this.participantInformation,
  });

  factory AccessApprovals.fromJson(Map<String, dynamic> json) =>
      _$AccessApprovalsFromJson(json);

  Map<String, dynamic> toJson() => _$AccessApprovalsToJson(this);
}
