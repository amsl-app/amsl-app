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
mixin _$QuestionOption {

 String get option; bool? get correct;
/// Create a copy of QuestionOption
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$QuestionOptionCopyWith<QuestionOption> get copyWith => _$QuestionOptionCopyWithImpl<QuestionOption>(this as QuestionOption, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is QuestionOption&&(identical(other.option, option) || other.option == option)&&(identical(other.correct, correct) || other.correct == correct));
}


@override
int get hashCode => Object.hash(runtimeType,option,correct);

@override
String toString() {
  return 'QuestionOption(option: $option, correct: $correct)';
}


}

/// @nodoc
abstract mixin class $QuestionOptionCopyWith<$Res>  {
  factory $QuestionOptionCopyWith(QuestionOption value, $Res Function(QuestionOption) _then) = _$QuestionOptionCopyWithImpl;
@useResult
$Res call({
 String option, bool? correct
});




}
/// @nodoc
class _$QuestionOptionCopyWithImpl<$Res>
    implements $QuestionOptionCopyWith<$Res> {
  _$QuestionOptionCopyWithImpl(this._self, this._then);

  final QuestionOption _self;
  final $Res Function(QuestionOption) _then;

/// Create a copy of QuestionOption
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? option = null,Object? correct = freezed,}) {
  return _then(_self.copyWith(
option: null == option ? _self.option : option // ignore: cast_nullable_to_non_nullable
as String,correct: freezed == correct ? _self.correct : correct // ignore: cast_nullable_to_non_nullable
as bool?,
  ));
}

}


/// Adds pattern-matching-related methods to [QuestionOption].
extension QuestionOptionPatterns on QuestionOption {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _QuestionOption value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _QuestionOption() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _QuestionOption value)  $default,){
final _that = this;
switch (_that) {
case _QuestionOption():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _QuestionOption value)?  $default,){
final _that = this;
switch (_that) {
case _QuestionOption() when $default != null:
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
case _QuestionOption() when $default != null:
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
case _QuestionOption():
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
case _QuestionOption() when $default != null:
return $default(_that.option,_that.correct);case _:
  return null;

}
}

}

/// @nodoc


class _QuestionOption implements QuestionOption {
  const _QuestionOption({required this.option, required this.correct});
  

@override final  String option;
@override final  bool? correct;

/// Create a copy of QuestionOption
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$QuestionOptionCopyWith<_QuestionOption> get copyWith => __$QuestionOptionCopyWithImpl<_QuestionOption>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _QuestionOption&&(identical(other.option, option) || other.option == option)&&(identical(other.correct, correct) || other.correct == correct));
}


@override
int get hashCode => Object.hash(runtimeType,option,correct);

@override
String toString() {
  return 'QuestionOption(option: $option, correct: $correct)';
}


}

/// @nodoc
abstract mixin class _$QuestionOptionCopyWith<$Res> implements $QuestionOptionCopyWith<$Res> {
  factory _$QuestionOptionCopyWith(_QuestionOption value, $Res Function(_QuestionOption) _then) = __$QuestionOptionCopyWithImpl;
@override @useResult
$Res call({
 String option, bool? correct
});




}
/// @nodoc
class __$QuestionOptionCopyWithImpl<$Res>
    implements _$QuestionOptionCopyWith<$Res> {
  __$QuestionOptionCopyWithImpl(this._self, this._then);

  final _QuestionOption _self;
  final $Res Function(_QuestionOption) _then;

/// Create a copy of QuestionOption
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? option = null,Object? correct = freezed,}) {
  return _then(_QuestionOption(
option: null == option ? _self.option : option // ignore: cast_nullable_to_non_nullable
as String,correct: freezed == correct ? _self.correct : correct // ignore: cast_nullable_to_non_nullable
as bool?,
  ));
}


}

/// @nodoc
mixin _$Question {

 String get id; String get quizId; String get sessionId; String get topic; String get content; String get question; List<QuestionOption>? get options; hikari_question.QuestionType get type; hikari_question.QuestionStatus get status; String? get aiSolution; hikari_question.BloomLevel get level; String? get answer; String? get evaluation; int? get grade;
/// Create a copy of Question
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$QuestionCopyWith<Question> get copyWith => _$QuestionCopyWithImpl<Question>(this as Question, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is Question&&(identical(other.id, id) || other.id == id)&&(identical(other.quizId, quizId) || other.quizId == quizId)&&(identical(other.sessionId, sessionId) || other.sessionId == sessionId)&&(identical(other.topic, topic) || other.topic == topic)&&(identical(other.content, content) || other.content == content)&&(identical(other.question, question) || other.question == question)&&const DeepCollectionEquality().equals(other.options, options)&&(identical(other.type, type) || other.type == type)&&(identical(other.status, status) || other.status == status)&&(identical(other.aiSolution, aiSolution) || other.aiSolution == aiSolution)&&(identical(other.level, level) || other.level == level)&&(identical(other.answer, answer) || other.answer == answer)&&(identical(other.evaluation, evaluation) || other.evaluation == evaluation)&&(identical(other.grade, grade) || other.grade == grade));
}


@override
int get hashCode => Object.hash(runtimeType,id,quizId,sessionId,topic,content,question,const DeepCollectionEquality().hash(options),type,status,aiSolution,level,answer,evaluation,grade);

@override
String toString() {
  return 'Question(id: $id, quizId: $quizId, sessionId: $sessionId, topic: $topic, content: $content, question: $question, options: $options, type: $type, status: $status, aiSolution: $aiSolution, level: $level, answer: $answer, evaluation: $evaluation, grade: $grade)';
}


}

/// @nodoc
abstract mixin class $QuestionCopyWith<$Res>  {
  factory $QuestionCopyWith(Question value, $Res Function(Question) _then) = _$QuestionCopyWithImpl;
@useResult
$Res call({
 String id, String quizId, String sessionId, String topic, String content, String question, List<QuestionOption>? options, hikari_question.QuestionType type, hikari_question.QuestionStatus status, String? aiSolution, hikari_question.BloomLevel level, String? answer, String? evaluation, int? grade
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
@pragma('vm:prefer-inline') @override $Res call({Object? id = null,Object? quizId = null,Object? sessionId = null,Object? topic = null,Object? content = null,Object? question = null,Object? options = freezed,Object? type = null,Object? status = null,Object? aiSolution = freezed,Object? level = null,Object? answer = freezed,Object? evaluation = freezed,Object? grade = freezed,}) {
  return _then(_self.copyWith(
id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as String,quizId: null == quizId ? _self.quizId : quizId // ignore: cast_nullable_to_non_nullable
as String,sessionId: null == sessionId ? _self.sessionId : sessionId // ignore: cast_nullable_to_non_nullable
as String,topic: null == topic ? _self.topic : topic // ignore: cast_nullable_to_non_nullable
as String,content: null == content ? _self.content : content // ignore: cast_nullable_to_non_nullable
as String,question: null == question ? _self.question : question // ignore: cast_nullable_to_non_nullable
as String,options: freezed == options ? _self.options : options // ignore: cast_nullable_to_non_nullable
as List<QuestionOption>?,type: null == type ? _self.type : type // ignore: cast_nullable_to_non_nullable
as hikari_question.QuestionType,status: null == status ? _self.status : status // ignore: cast_nullable_to_non_nullable
as hikari_question.QuestionStatus,aiSolution: freezed == aiSolution ? _self.aiSolution : aiSolution // ignore: cast_nullable_to_non_nullable
as String?,level: null == level ? _self.level : level // ignore: cast_nullable_to_non_nullable
as hikari_question.BloomLevel,answer: freezed == answer ? _self.answer : answer // ignore: cast_nullable_to_non_nullable
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( String id,  String quizId,  String sessionId,  String topic,  String content,  String question,  List<QuestionOption>? options,  hikari_question.QuestionType type,  hikari_question.QuestionStatus status,  String? aiSolution,  hikari_question.BloomLevel level,  String? answer,  String? evaluation,  int? grade)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _Question() when $default != null:
return $default(_that.id,_that.quizId,_that.sessionId,_that.topic,_that.content,_that.question,_that.options,_that.type,_that.status,_that.aiSolution,_that.level,_that.answer,_that.evaluation,_that.grade);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( String id,  String quizId,  String sessionId,  String topic,  String content,  String question,  List<QuestionOption>? options,  hikari_question.QuestionType type,  hikari_question.QuestionStatus status,  String? aiSolution,  hikari_question.BloomLevel level,  String? answer,  String? evaluation,  int? grade)  $default,) {final _that = this;
switch (_that) {
case _Question():
return $default(_that.id,_that.quizId,_that.sessionId,_that.topic,_that.content,_that.question,_that.options,_that.type,_that.status,_that.aiSolution,_that.level,_that.answer,_that.evaluation,_that.grade);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( String id,  String quizId,  String sessionId,  String topic,  String content,  String question,  List<QuestionOption>? options,  hikari_question.QuestionType type,  hikari_question.QuestionStatus status,  String? aiSolution,  hikari_question.BloomLevel level,  String? answer,  String? evaluation,  int? grade)?  $default,) {final _that = this;
switch (_that) {
case _Question() when $default != null:
return $default(_that.id,_that.quizId,_that.sessionId,_that.topic,_that.content,_that.question,_that.options,_that.type,_that.status,_that.aiSolution,_that.level,_that.answer,_that.evaluation,_that.grade);case _:
  return null;

}
}

}

/// @nodoc


class _Question implements Question {
  const _Question({required this.id, required this.quizId, required this.sessionId, required this.topic, required this.content, required this.question, final  List<QuestionOption>? options, required this.type, required this.status, required this.aiSolution, required this.level, this.answer, this.evaluation, this.grade}): _options = options;
  

@override final  String id;
@override final  String quizId;
@override final  String sessionId;
@override final  String topic;
@override final  String content;
@override final  String question;
 final  List<QuestionOption>? _options;
@override List<QuestionOption>? get options {
  final value = _options;
  if (value == null) return null;
  if (_options is EqualUnmodifiableListView) return _options;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(value);
}

@override final  hikari_question.QuestionType type;
@override final  hikari_question.QuestionStatus status;
@override final  String? aiSolution;
@override final  hikari_question.BloomLevel level;
@override final  String? answer;
@override final  String? evaluation;
@override final  int? grade;

/// Create a copy of Question
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$QuestionCopyWith<_Question> get copyWith => __$QuestionCopyWithImpl<_Question>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _Question&&(identical(other.id, id) || other.id == id)&&(identical(other.quizId, quizId) || other.quizId == quizId)&&(identical(other.sessionId, sessionId) || other.sessionId == sessionId)&&(identical(other.topic, topic) || other.topic == topic)&&(identical(other.content, content) || other.content == content)&&(identical(other.question, question) || other.question == question)&&const DeepCollectionEquality().equals(other._options, _options)&&(identical(other.type, type) || other.type == type)&&(identical(other.status, status) || other.status == status)&&(identical(other.aiSolution, aiSolution) || other.aiSolution == aiSolution)&&(identical(other.level, level) || other.level == level)&&(identical(other.answer, answer) || other.answer == answer)&&(identical(other.evaluation, evaluation) || other.evaluation == evaluation)&&(identical(other.grade, grade) || other.grade == grade));
}


@override
int get hashCode => Object.hash(runtimeType,id,quizId,sessionId,topic,content,question,const DeepCollectionEquality().hash(_options),type,status,aiSolution,level,answer,evaluation,grade);

@override
String toString() {
  return 'Question(id: $id, quizId: $quizId, sessionId: $sessionId, topic: $topic, content: $content, question: $question, options: $options, type: $type, status: $status, aiSolution: $aiSolution, level: $level, answer: $answer, evaluation: $evaluation, grade: $grade)';
}


}

/// @nodoc
abstract mixin class _$QuestionCopyWith<$Res> implements $QuestionCopyWith<$Res> {
  factory _$QuestionCopyWith(_Question value, $Res Function(_Question) _then) = __$QuestionCopyWithImpl;
@override @useResult
$Res call({
 String id, String quizId, String sessionId, String topic, String content, String question, List<QuestionOption>? options, hikari_question.QuestionType type, hikari_question.QuestionStatus status, String? aiSolution, hikari_question.BloomLevel level, String? answer, String? evaluation, int? grade
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
@override @pragma('vm:prefer-inline') $Res call({Object? id = null,Object? quizId = null,Object? sessionId = null,Object? topic = null,Object? content = null,Object? question = null,Object? options = freezed,Object? type = null,Object? status = null,Object? aiSolution = freezed,Object? level = null,Object? answer = freezed,Object? evaluation = freezed,Object? grade = freezed,}) {
  return _then(_Question(
id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as String,quizId: null == quizId ? _self.quizId : quizId // ignore: cast_nullable_to_non_nullable
as String,sessionId: null == sessionId ? _self.sessionId : sessionId // ignore: cast_nullable_to_non_nullable
as String,topic: null == topic ? _self.topic : topic // ignore: cast_nullable_to_non_nullable
as String,content: null == content ? _self.content : content // ignore: cast_nullable_to_non_nullable
as String,question: null == question ? _self.question : question // ignore: cast_nullable_to_non_nullable
as String,options: freezed == options ? _self._options : options // ignore: cast_nullable_to_non_nullable
as List<QuestionOption>?,type: null == type ? _self.type : type // ignore: cast_nullable_to_non_nullable
as hikari_question.QuestionType,status: null == status ? _self.status : status // ignore: cast_nullable_to_non_nullable
as hikari_question.QuestionStatus,aiSolution: freezed == aiSolution ? _self.aiSolution : aiSolution // ignore: cast_nullable_to_non_nullable
as String?,level: null == level ? _self.level : level // ignore: cast_nullable_to_non_nullable
as hikari_question.BloomLevel,answer: freezed == answer ? _self.answer : answer // ignore: cast_nullable_to_non_nullable
as String?,evaluation: freezed == evaluation ? _self.evaluation : evaluation // ignore: cast_nullable_to_non_nullable
as String?,grade: freezed == grade ? _self.grade : grade // ignore: cast_nullable_to_non_nullable
as int?,
  ));
}


}

// dart format on
