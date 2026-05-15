import 'package:json_annotation/json_annotation.dart';

part 'scale.g.dart';

@JsonSerializable()
class Scale {
  final String id;
  final String title;
  final ScaleMode mode;
  final ScaleType type;

  final ScaleBody body;
  final List<ScaleItem> items;

  const Scale({
    required this.id,
    required this.title,
    required this.mode,
    required this.items,
    required this.body,
    required this.type,
  });

  factory Scale.fromJson(Map<String, dynamic> json) => _$ScaleFromJson(json);

  Map<String, dynamic> toJson() => _$ScaleToJson(this);
}

@JsonSerializable()
class ScaleItem {
  final String id;
  final bool? reverse;

  ScaleItem({required this.id, this.reverse});

  factory ScaleItem.fromJson(Map<String, dynamic> json) =>
      _$ScaleItemFromJson(json);

  Map<String, dynamic> toJson() => _$ScaleItemToJson(this);
}

@JsonSerializable()
class ScaleBody {
  final double min;
  final double max;

  ScaleBody({required this.min, required this.max});

  factory ScaleBody.fromJson(Map<String, dynamic> json) =>
      _$ScaleBodyFromJson(json);

  Map<String, dynamic> toJson() => _$ScaleBodyToJson(this);
}

@JsonEnum(fieldRename: FieldRename.snake)
enum ScaleMode { sum, average }

@JsonEnum(fieldRename: FieldRename.snake)
enum ScaleType { scale }
