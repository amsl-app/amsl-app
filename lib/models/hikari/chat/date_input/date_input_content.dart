import 'package:json_annotation/json_annotation.dart';

part 'date_input_content.g.dart';

@JsonSerializable()
class DateInputContent {
  final String title;
  final String? min;
  final String? max;

  DateInputContent({required this.title, required this.min, required this.max});

  factory DateInputContent.fromJson(Map<String, dynamic> json) =>
      _$DateInputContentFromJson(json);

  Map<String, dynamic> toJson() => _$DateInputContentToJson(this);
}
