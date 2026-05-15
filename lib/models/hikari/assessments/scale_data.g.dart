// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'scale_data.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

ScaleData _$ScaleDataFromJson(Map<String, dynamic> json) => ScaleData(
  title: json['title'] as String,
  id: json['id'] as String,
  value: (json['value'] as num).toDouble(),
);

Map<String, dynamic> _$ScaleDataToJson(ScaleData instance) => <String, dynamic>{
  'id': instance.id,
  'title': instance.title,
  'value': instance.value,
};
