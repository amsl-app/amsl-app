import '../../hikari/assessments/question.dart' as hikari_question;
import '../../hikari/assessments/question_body.dart';

sealed class Question<T> {
  final String id;
  final String title;
  T? answer;

  Question({this.answer, required this.title, required this.id});

  static Question fromHikari(hikari_question.Question question) {
    switch (question.body) {
      case MultiChoice(:final options):
        return MultiChoiceQuestion(
          options: options,
          id: question.id,
          title: question.title,
          answer: question.answer as String?,
        );
      case LikertScale(:final max, :final min, :final hintMin, :final hintMax):
        return LikertScaleQuestion(
          hintMax: hintMax,
          hintMin: hintMin,
          max: max,
          min: min,
          id: question.id,
          title: question.title,
          answer: question.answer as int?,
        );
      case TextField(:final placeholder):
        return TextFieldQuestion(
          placeholder: placeholder,
          id: question.id,
          title: question.title,
          answer: question.answer as String?,
        );
      case TextArea(:final placeholder):
        return TextAreaQuestion(
          placeholder: placeholder,
          id: question.id,
          title: question.title,
          answer: question.answer as String?,
        );
      case Select(:final yes, :final no):
        return SelectQuestion(
          yes: yes,
          no: no,
          id: question.id,
          title: question.title,
          answer: question.answer as bool?,
        );
      case SingleChoice():
        return SingleChoiceQuestion(
          id: question.id,
          title: question.title,
          answer: question.answer as bool?,
        );
    }
  }
}

class LikertScaleQuestion extends Question<int> {
  final String? hintMax;
  final String? hintMin;
  final int max;
  final int min;

  LikertScaleQuestion({
    required this.hintMax,
    required this.hintMin,
    required this.max,
    required this.min,
    required super.id,
    required super.title,
    super.answer,
  });
}

class TextFieldQuestion extends Question<String> {
  final String placeholder;

  TextFieldQuestion({
    required this.placeholder,
    required super.id,
    required super.title,
    super.answer,
  });
}

class TextAreaQuestion extends Question<String> {
  final String placeholder;

  TextAreaQuestion({
    required this.placeholder,
    required super.id,
    required super.title,
    super.answer,
  });
}

class SelectQuestion extends Question<bool> {
  final String? yes;
  final String? no;

  SelectQuestion({
    this.no,
    this.yes,
    required super.id,
    required super.title,
    super.answer,
  });
}

class MultiChoiceQuestion extends Question<String> {
  final List<String> options;

  MultiChoiceQuestion({
    required this.options,
    required super.id,
    super.answer,
    required super.title,
  });
}

class SingleChoiceQuestion extends Question<bool> {
  SingleChoiceQuestion({super.answer, required super.id, required super.title});
}
