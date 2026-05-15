// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'access_approvals.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

AccessApprovals _$AccessApprovalsFromJson(Map<String, dynamic> json) =>
    AccessApprovals(
      declarationOfConsent: json['declaration_of_consent'] as String,
      privacyPolicy: json['privacy_policy'] as String,
      participantInformation: json['participant_information'] as String?,
    );

Map<String, dynamic> _$AccessApprovalsToJson(AccessApprovals instance) =>
    <String, dynamic>{
      'declaration_of_consent': instance.declarationOfConsent,
      'privacy_policy': instance.privacyPolicy,
      'participant_information': instance.participantInformation,
    };
