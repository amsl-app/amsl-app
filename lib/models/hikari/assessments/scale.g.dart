// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'scale.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Scale _$ScaleFromJson(Map<String, dynamic> json) => Scale(
  id: json['id'] as String,
  title: json['title'] as String,
  mode: $enumDecode(_$ScaleModeEnumMap, json['mode']),
  items: (json['items'] as List<dynamic>)
      .map((e) => ScaleItem.fromJson(e as Map<String, dynamic>))
      .toList(),
  body: ScaleBody.fromJson(json['body'] as Map<String, dynamic>),
  type: $enumDecode(_$ScaleTypeEnumMap, json['type']),
);

Map<String, dynamic> _$ScaleToJson(Scale instance) => <String, dynamic>{
  'id': instance.id,
  'title': instance.title,
  'mode': _$ScaleModeEnumMap[instance.mode]!,
  'type': _$ScaleTypeEnumMap[instance.type]!,
  'body': instance.body,
  'items': instance.items,
};

const _$ScaleModeEnumMap = {ScaleMode.sum: 'sum', ScaleMode.average: 'average'};

const _$ScaleTypeEnumMap = {ScaleType.scale: 'scale'};

ScaleItem _$ScaleItemFromJson(Map<String, dynamic> json) =>
    ScaleItem(id: json['id'] as String, reverse: json['reverse'] as bool?);

Map<String, dynamic> _$ScaleItemToJson(ScaleItem instance) => <String, dynamic>{
  'id': instance.id,
  'reverse': instance.reverse,
};

ScaleBody _$ScaleBodyFromJson(Map<String, dynamic> json) => ScaleBody(
  min: (json['min'] as num).toDouble(),
  max: (json['max'] as num).toDouble(),
);

Map<String, dynamic> _$ScaleBodyToJson(ScaleBody instance) => <String, dynamic>{
  'min': instance.min,
  'max': instance.max,
};
