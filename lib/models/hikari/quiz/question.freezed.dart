// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'question.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;

/// @nodoc
mixin _$QuestionOptions {

 String get option; bool? get correct;
/// Create a copy of QuestionOptions
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$QuestionOptionsCopyWith<QuestionOptions> get copyWith => _$QuestionOptionsCopyWithImpl<QuestionOptions>(this as QuestionOptions, _$identity);

  /// Serializes this QuestionOptions to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is QuestionOptions&&(identical(other.option, option) || other.option == option)&&(identical(other.correct, correct) || other.correct == correct));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,option,correct);

@override
String toString() {
  return 'QuestionOptions(option: $option, correct: $correct)';
}


}

/// @nodoc
abstract mixin class $QuestionOptionsCopyWith<$Res>  {
  factory $QuestionOptionsCopyWith(QuestionOptions value, $Res Function(QuestionOptions) _then) = _$QuestionOptionsCopyWithImpl;
@useResult
$Res call({
 String option, bool? correct
});




}
/// @nodoc
class _$QuestionOptionsCopyWithImpl<$Res>
    implements $QuestionOptionsCopyWith<$Res> {
  _$QuestionOptionsCopyWithImpl(this._self, this._then);

  final QuestionOptions _self;
  final $Res Function(QuestionOptions) _then;

/// Create a copy of QuestionOptions
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? option = null,Object? correct = freezed,}) {
  return _then(_self.copyWith(
option: null == option ? _self.option : option // ignore: cast_nullable_to_non_nullable
as String,correct: freezed == correct ? _self.correct : correct // ignore: cast_nullable_to_non_nullable
as bool?,
  ));
}

}


/// Adds pattern-matching-related methods to [QuestionOptions].
extension QuestionOptionsPatterns on QuestionOptions {
/// A variant of `map` that fallback to returning `orElse`.
///
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case final Subclass value:
///     return ...;
///   case _:
///     return orElse();
/// }
/// ```

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _QuestionOptions value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _QuestionOptions() when $default != null:
return $default(_that);case _:
  return orElse();

}
}
/// A `switch`-like method, using callbacks.
///
/// Callbacks receives the raw object, upcasted.
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case final Subclass value:
///     return ...;
///   case final Subclass2 value:
///     return ...;
/// }
/// ```

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _QuestionOptions value)  $default,){
final _that = this;
switch (_that) {
case _QuestionOptions():
return $default(_that);case _:
  throw StateError('Unexpected subclass');

}
}
/// A variant of `map` that fallback to returning `null`.
///
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case final Subclass value:
///     return ...;
///   case _:
///     return null;
/// }
/// ```

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _QuestionOptions value)?  $default,){
final _that = this;
switch (_that) {
case _QuestionOptions() when $default != null:
return $default(_that);case _:
  return null;

}
}
/// A variant of `when` that fallback to an `orElse` callback.
///
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case Subclass(:final field):
///     return ...;
///   case _:
///     return orElse();
/// }
/// ```

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( String option,  bool? correct)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _QuestionOptions() when $default != null:
return $default(_that.option,_that.correct);case _:
  return orElse();

}
}
/// A `switch`-like method, using callbacks.
///
/// As opposed to `map`, this offers destructuring.
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case Subclass(:final field):
///     return ...;
///   case Subclass2(:final field2):
///     return ...;
/// }
/// ```

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( String option,  bool? correct)  $default,) {final _that = this;
switch (_that) {
case _QuestionOptions():
return $default(_that.option,_that.correct);case _:
  throw StateError('Unexpected subclass');

}
}
/// A variant of `when` that fallback to returning `null`
///
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case Subclass(:final field):
///     return ...;
///   case _:
///     return null;
/// }
/// ```

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( String option,  bool? correct)?  $default,) {final _that = this;
switch (_that) {
case _QuestionOptions() when $default != null:
return $default(_that.option,_that.correct);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _QuestionOptions implements QuestionOptions {
   _QuestionOptions({required this.option, this.correct});
  factory _QuestionOptions.fromJson(Map<String, dynamic> json) => _$QuestionOptionsFromJson(json);

@override final  String option;
@override final  bool? correct;

/// Create a copy of QuestionOptions
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$QuestionOptionsCopyWith<_QuestionOptions> get copyWith => __$QuestionOptionsCopyWithImpl<_QuestionOptions>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$QuestionOptionsToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _QuestionOptions&&(identical(other.option, option) || other.option == option)&&(identical(other.correct, correct) || other.correct == correct));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,option,correct);

@override
String toString() {
  return 'QuestionOptions(option: $option, correct: $correct)';
}


}

/// @nodoc
abstract mixin class _$QuestionOptionsCopyWith<$Res> implements $QuestionOptionsCopyWith<$Res> {
  factory _$QuestionOptionsCopyWith(_QuestionOptions value, $Res Function(_QuestionOptions) _then) = __$QuestionOptionsCopyWithImpl;
@override @useResult
$Res call({
 String option, bool? correct
});




}
/// @nodoc
class __$QuestionOptionsCopyWithImpl<$Res>
    implements _$QuestionOptionsCopyWith<$Res> {
  __$QuestionOptionsCopyWithImpl(this._self, this._then);

  final _QuestionOptions _self;
  final $Res Function(_QuestionOptions) _then;

/// Create a copy of QuestionOptions
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? option = null,Object? correct = freezed,}) {
  return _then(_QuestionOptions(
option: null == option ? _self.option : option // ignore: cast_nullable_to_non_nullable
as String,correct: freezed == correct ? _self.correct : correct // ignore: cast_nullable_to_non_nullable
as bool?,
  ));
}


}


/// @nodoc
mixin _$Question {

 String get id;@JsonKey(name: "quiz_id") String get quizId;@JsonKey(name: "session_id") String get sessionId; String get topic; String get content; String get question; BloomLevel get level; QuestionStatus get status; QuestionType get type; List<QuestionOptions>? get options;@JsonKey(name: "ai_solution") String? get aiSolution; String? get answer; String? get evaluation; int? get grade;
/// Create a copy of Question
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$QuestionCopyWith<Question> get copyWith => _$QuestionCopyWithImpl<Question>(this as Question, _$identity);

  /// Serializes this Question to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is Question&&(identical(other.id, id) || other.id == id)&&(identical(other.quizId, quizId) || other.quizId == quizId)&&(identical(other.sessionId, sessionId) || other.sessionId == sessionId)&&(identical(other.topic, topic) || other.topic == topic)&&(identical(other.content, content) || other.content == content)&&(identical(other.question, question) || other.question == question)&&(identical(other.level, level) || other.level == level)&&(identical(other.status, status) || other.status == status)&&(identical(other.type, type) || other.type == type)&&const DeepCollectionEquality().equals(other.options, options)&&(identical(other.aiSolution, aiSolution) || other.aiSolution == aiSolution)&&(identical(other.answer, answer) || other.answer == answer)&&(identical(other.evaluation, evaluation) || other.evaluation == evaluation)&&(identical(other.grade, grade) || other.grade == grade));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,id,quizId,sessionId,topic,content,question,level,status,type,const DeepCollectionEquality().hash(options),aiSolution,answer,evaluation,grade);

@override
String toString() {
  return 'Question(id: $id, quizId: $quizId, sessionId: $sessionId, topic: $topic, content: $content, question: $question, level: $level, status: $status, type: $type, options: $options, aiSolution: $aiSolution, answer: $answer, evaluation: $evaluation, grade: $grade)';
}


}

/// @nodoc
abstract mixin class $QuestionCopyWith<$Res>  {
  factory $QuestionCopyWith(Question value, $Res Function(Question) _then) = _$QuestionCopyWithImpl;
@useResult
$Res call({
 String id,@JsonKey(name: "quiz_id") String quizId,@JsonKey(name: "session_id") String sessionId, String topic, String content, String question, BloomLevel level, QuestionStatus status, QuestionType type, List<QuestionOptions>? options,@JsonKey(name: "ai_solution") String? aiSolution, String? answer, String? evaluation, int? grade
});




}
/// @nodoc
class _$QuestionCopyWithImpl<$Res>
    implements $QuestionCopyWith<$Res> {
  _$QuestionCopyWithImpl(this._self, this._then);

  final Question _self;
  final $Res Function(Question) _then;

/// Create a copy of Question
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? id = null,Object? quizId = null,Object? sessionId = null,Object? topic = null,Object? content = null,Object? question = null,Object? level = null,Object? status = null,Object? type = null,Object? options = freezed,Object? aiSolution = freezed,Object? answer = freezed,Object? evaluation = freezed,Object? grade = freezed,}) {
  return _then(_self.copyWith(
id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as String,quizId: null == quizId ? _self.quizId : quizId // ignore: cast_nullable_to_non_nullable
as String,sessionId: null == sessionId ? _self.sessionId : sessionId // ignore: cast_nullable_to_non_nullable
as String,topic: null == topic ? _self.topic : topic // ignore: cast_nullable_to_non_nullable
as String,content: null == content ? _self.content : content // ignore: cast_nullable_to_non_nullable
as String,question: null == question ? _self.question : question // ignore: cast_nullable_to_non_nullable
as String,level: null == level ? _self.level : level // ignore: cast_nullable_to_non_nullable
as BloomLevel,status: null == status ? _self.status : status // ignore: cast_nullable_to_non_nullable
as QuestionStatus,type: null == type ? _self.type : type // ignore: cast_nullable_to_non_nullable
as QuestionType,options: freezed == options ? _self.options : options // ignore: cast_nullable_to_non_nullable
as List<QuestionOptions>?,aiSolution: freezed == aiSolution ? _self.aiSolution : aiSolution // ignore: cast_nullable_to_non_nullable
as String?,answer: freezed == answer ? _self.answer : answer // ignore: cast_nullable_to_non_nullable
as String?,evaluation: freezed == evaluation ? _self.evaluation : evaluation // ignore: cast_nullable_to_non_nullable
as String?,grade: freezed == grade ? _self.grade : grade // ignore: cast_nullable_to_non_nullable
as int?,
  ));
}

}


/// Adds pattern-matching-related methods to [Question].
extension QuestionPatterns on Question {
/// A variant of `map` that fallback to returning `orElse`.
///
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case final Subclass value:
///     return ...;
///   case _:
///     return orElse();
/// }
/// ```

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _Question value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _Question() when $default != null:
return $default(_that);case _:
  return orElse();

}
}
/// A `switch`-like method, using callbacks.
///
/// Callbacks receives the raw object, upcasted.
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case final Subclass value:
///     return ...;
///   case final Subclass2 value:
///     return ...;
/// }
/// ```

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _Question value)  $default,){
final _that = this;
switch (_that) {
case _Question():
return $default(_that);case _:
  throw StateError('Unexpected subclass');

}
}
/// A variant of `map` that fallback to returning `null`.
///
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case final Subclass value:
///     return ...;
///   case _:
///     return null;
/// }
/// ```

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _Question value)?  $default,){
final _that = this;
switch (_that) {
case _Question() when $default != null:
return $default(_that);case _:
  return null;

}
}
/// A variant of `when` that fallback to an `orElse` callback.
///
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case Subclass(:final field):
///     return ...;
///   case _:
///     return orElse();
/// }
/// ```

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( String id, @JsonKey(name: "quiz_id")  String quizId, @JsonKey(name: "session_id")  String sessionId,  String topic,  String content,  String question,  BloomLevel level,  QuestionStatus status,  QuestionType type,  List<QuestionOptions>? options, @JsonKey(name: "ai_solution")  String? aiSolution,  String? answer,  String? evaluation,  int? grade)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _Question() when $default != null:
return $default(_that.id,_that.quizId,_that.sessionId,_that.topic,_that.content,_that.question,_that.level,_that.status,_that.type,_that.options,_that.aiSolution,_that.answer,_that.evaluation,_that.grade);case _:
  return orElse();

}
}
/// A `switch`-like method, using callbacks.
///
/// As opposed to `map`, this offers destructuring.
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case Subclass(:final field):
///     return ...;
///   case Subclass2(:final field2):
///     return ...;
/// }
/// ```

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( String id, @JsonKey(name: "quiz_id")  String quizId, @JsonKey(name: "session_id")  String sessionId,  String topic,  String content,  String question,  BloomLevel level,  QuestionStatus status,  QuestionType type,  List<QuestionOptions>? options, @JsonKey(name: "ai_solution")  String? aiSolution,  String? answer,  String? evaluation,  int? grade)  $default,) {final _that = this;
switch (_that) {
case _Question():
return $default(_that.id,_that.quizId,_that.sessionId,_that.topic,_that.content,_that.question,_that.level,_that.status,_that.type,_that.options,_that.aiSolution,_that.answer,_that.evaluation,_that.grade);case _:
  throw StateError('Unexpected subclass');

}
}
/// A variant of `when` that fallback to returning `null`
///
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case Subclass(:final field):
///     return ...;
///   case _:
///     return null;
/// }
/// ```

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( String id, @JsonKey(name: "quiz_id")  String quizId, @JsonKey(name: "session_id")  String sessionId,  String topic,  String content,  String question,  BloomLevel level,  QuestionStatus status,  QuestionType type,  List<QuestionOptions>? options, @JsonKey(name: "ai_solution")  String? aiSolution,  String? answer,  String? evaluation,  int? grade)?  $default,) {final _that = this;
switch (_that) {
case _Question() when $default != null:
return $default(_that.id,_that.quizId,_that.sessionId,_that.topic,_that.content,_that.question,_that.level,_that.status,_that.type,_that.options,_that.aiSolution,_that.answer,_that.evaluation,_that.grade);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _Question implements Question {
   _Question({required this.id, @JsonKey(name: "quiz_id") required this.quizId, @JsonKey(name: "session_id") required this.sessionId, required this.topic, required this.content, required this.question, required this.level, required this.status, this.type = QuestionType.text, final  List<QuestionOptions>? options, @JsonKey(name: "ai_solution") this.aiSolution, this.answer, this.evaluation, this.grade}): _options = options;
  factory _Question.fromJson(Map<String, dynamic> json) => _$QuestionFromJson(json);

@override final  String id;
@override@JsonKey(name: "quiz_id") final  String quizId;
@override@JsonKey(name: "session_id") final  String sessionId;
@override final  String topic;
@override final  String content;
@override final  String question;
@override final  BloomLevel level;
@override final  QuestionStatus status;
@override@JsonKey() final  QuestionType type;
 final  List<QuestionOptions>? _options;
@override List<QuestionOptions>? get options {
  final value = _options;
  if (value == null) return null;
  if (_options is EqualUnmodifiableListView) return _options;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(value);
}

@override@JsonKey(name: "ai_solution") final  String? aiSolution;
@override final  String? answer;
@override final  String? evaluation;
@override final  int? grade;

/// Create a copy of Question
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$QuestionCopyWith<_Question> get copyWith => __$QuestionCopyWithImpl<_Question>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$QuestionToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _Question&&(identical(other.id, id) || other.id == id)&&(identical(other.quizId, quizId) || other.quizId == quizId)&&(identical(other.sessionId, sessionId) || other.sessionId == sessionId)&&(identical(other.topic, topic) || other.topic == topic)&&(identical(other.content, content) || other.content == content)&&(identical(other.question, question) || other.question == question)&&(identical(other.level, level) || other.level == level)&&(identical(other.status, status) || other.status == status)&&(identical(other.type, type) || other.type == type)&&const DeepCollectionEquality().equals(other._options, _options)&&(identical(other.aiSolution, aiSolution) || other.aiSolution == aiSolution)&&(identical(other.answer, answer) || other.answer == answer)&&(identical(other.evaluation, evaluation) || other.evaluation == evaluation)&&(identical(other.grade, grade) || other.grade == grade));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,id,quizId,sessionId,topic,content,question,level,status,type,const DeepCollectionEquality().hash(_options),aiSolution,answer,evaluation,grade);

@override
String toString() {
  return 'Question(id: $id, quizId: $quizId, sessionId: $sessionId, topic: $topic, content: $content, question: $question, level: $level, status: $status, type: $type, options: $options, aiSolution: $aiSolution, answer: $answer, evaluation: $evaluation, grade: $grade)';
}


}

/// @nodoc
abstract mixin class _$QuestionCopyWith<$Res> implements $QuestionCopyWith<$Res> {
  factory _$QuestionCopyWith(_Question value, $Res Function(_Question) _then) = __$QuestionCopyWithImpl;
@override @useResult
$Res call({
 String id,@JsonKey(name: "quiz_id") String quizId,@JsonKey(name: "session_id") String sessionId, String topic, String content, String question, BloomLevel level, QuestionStatus status, QuestionType type, List<QuestionOptions>? options,@JsonKey(name: "ai_solution") String? aiSolution, String? answer, String? evaluation, int? grade
});




}
/// @nodoc
class __$QuestionCopyWithImpl<$Res>
    implements _$QuestionCopyWith<$Res> {
  __$QuestionCopyWithImpl(this._self, this._then);

  final _Question _self;
  final $Res Function(_Question) _then;

/// Create a copy of Question
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? id = null,Object? quizId = null,Object? sessionId = null,Object? topic = null,Object? content = null,Object? question = null,Object? level = null,Object? status = null,Object? type = null,Object? options = freezed,Object? aiSolution = freezed,Object? answer = freezed,Object? evaluation = freezed,Object? grade = freezed,}) {
  return _then(_Question(
id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as String,quizId: null == quizId ? _self.quizId : quizId // ignore: cast_nullable_to_non_nullable
as String,sessionId: null == sessionId ? _self.sessionId : sessionId // ignore: cast_nullable_to_non_nullable
as String,topic: null == topic ? _self.topic : topic // ignore: cast_nullable_to_non_nullable
as String,content: null == content ? _self.content : content // ignore: cast_nullable_to_non_nullable
as String,question: null == question ? _self.question : question // ignore: cast_nullable_to_non_nullable
as String,level: null == level ? _self.level : level // ignore: cast_nullable_to_non_nullable
as BloomLevel,status: null == status ? _self.status : status // ignore: cast_nullable_to_non_nullable
as QuestionStatus,type: null == type ? _self.type : type // ignore: cast_nullable_to_non_nullable
as QuestionType,options: freezed == options ? _self._options : options // ignore: cast_nullable_to_non_nullable
as List<QuestionOptions>?,aiSolution: freezed == aiSolution ? _self.aiSolution : aiSolution // ignore: cast_nullable_to_non_nullable
as String?,answer: freezed == answer ? _self.answer : answer // ignore: cast_nullable_to_non_nullable
as String?,evaluation: freezed == evaluation ? _self.evaluation : evaluation // ignore: cast_nullable_to_non_nullable
as String?,grade: freezed == grade ? _self.grade : grade // ignore: cast_nullable_to_non_nullable
as int?,
  ));
}


}

// dart format on
