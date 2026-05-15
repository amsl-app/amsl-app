import 'package:freezed_annotation/freezed_annotation.dart';

part 'assistant_wordings.g.dart';

@JsonSerializable()
class AssistantWording {
  final List<String> alternatives;

  const AssistantWording({required this.alternatives});

  factory AssistantWording.fromJson(Map<String, dynamic> json) =>
      _$AssistantWordingFromJson(json);

  Map<String, dynamic> toJson() => _$AssistantWordingToJson(this);
}
