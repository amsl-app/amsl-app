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
}
