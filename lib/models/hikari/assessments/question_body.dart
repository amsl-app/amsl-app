import 'package:amsl_app/models/hikari/assessments/question.dart';
import 'package:json_annotation/json_annotation.dart';

part 'question_body.g.dart';

sealed class QuestionBody<T> {
  static QuestionBody fromJson(Map<String, dynamic> json, QuestionType type) {
    switch (type) {
      case QuestionType.multiChoice:
        return MultiChoice.fromJson(json);
      case QuestionType.scale:
        return LikertScale.fromJson(json);
      case QuestionType.select:
        return Select.fromJson(json);
      case QuestionType.singleChoice:
        return SingleChoice.fromJson(json);
      case QuestionType.textarea:
        return TextArea.fromJson(json);
      case QuestionType.textfield:
        return TextField.fromJson(json);
    }
  }

  Map<String, dynamic> toJson();
}

@JsonSerializable()
class MultiChoice extends QuestionBody {
  final List<String> options;

  MultiChoice({required this.options});

  factory MultiChoice.fromJson(Map<String, dynamic> json) =>
      _$MultiChoiceFromJson(json);

  @override
  Map<String, dynamic> toJson() => _$MultiChoiceToJson(this);
}

@JsonSerializable()
class LikertScale extends QuestionBody {
  @JsonKey(name: "hint_max")
  final String? hintMax;
  @JsonKey(name: "hint_min")
  final String? hintMin;
  final int max;
  final int min;

  LikertScale({
    required this.max,
    required this.min,
    this.hintMax,
    this.hintMin,
  });

  factory LikertScale.fromJson(Map<String, dynamic> json) =>
      _$LikertScaleFromJson(json);

  @override
  Map<String, dynamic> toJson() => _$LikertScaleToJson(this);
}

@JsonSerializable()
class TextField extends QuestionBody {
  final String placeholder;

  TextField({required this.placeholder});

  factory TextField.fromJson(Map<String, dynamic> json) =>
      _$TextFieldFromJson(json);

  @override
  Map<String, dynamic> toJson() => _$TextFieldToJson(this);
}

@JsonSerializable()
class TextArea extends QuestionBody {
  final String placeholder;

  TextArea({required this.placeholder});

  factory TextArea.fromJson(Map<String, dynamic> json) =>
      _$TextAreaFromJson(json);

  @override
  Map<String, dynamic> toJson() => _$TextAreaToJson(this);
}

@JsonSerializable()
class Select extends QuestionBody {
  final String? yes;
  final String? no;

  Select({this.yes, this.no});

  factory Select.fromJson(Map<String, dynamic> json) => _$SelectFromJson(json);

  @override
  Map<String, dynamic> toJson() => _$SelectToJson(this);
}

@JsonSerializable()
class SingleChoice extends QuestionBody {
  SingleChoice();

  factory SingleChoice.fromJson(Map<String, dynamic> json) =>
      _$SingleChoiceFromJson(json);

  @override
  Map<String, dynamic> toJson() => _$SingleChoiceToJson(this);
}
