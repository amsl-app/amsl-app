// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'score.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;

/// @nodoc
mixin _$QuizScore {

@JsonKey(name: "module_id") String get moduleId;@JsonKey(name: "session_id") String get sessionId; String get topic; int get score;
/// Create a copy of QuizScore
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$QuizScoreCopyWith<QuizScore> get copyWith => _$QuizScoreCopyWithImpl<QuizScore>(this as QuizScore, _$identity);

  /// Serializes this QuizScore to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is QuizScore&&(identical(other.moduleId, moduleId) || other.moduleId == moduleId)&&(identical(other.sessionId, sessionId) || other.sessionId == sessionId)&&(identical(other.topic, topic) || other.topic == topic)&&(identical(other.score, score) || other.score == score));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,moduleId,sessionId,topic,score);

@override
String toString() {
  return 'QuizScore(moduleId: $moduleId, sessionId: $sessionId, topic: $topic, score: $score)';
}


}

/// @nodoc
abstract mixin class $QuizScoreCopyWith<$Res>  {
  factory $QuizScoreCopyWith(QuizScore value, $Res Function(QuizScore) _then) = _$QuizScoreCopyWithImpl;
@useResult
$Res call({
@JsonKey(name: "module_id") String moduleId,@JsonKey(name: "session_id") String sessionId, String topic, int score
});




}
/// @nodoc
class _$QuizScoreCopyWithImpl<$Res>
    implements $QuizScoreCopyWith<$Res> {
  _$QuizScoreCopyWithImpl(this._self, this._then);

  final QuizScore _self;
  final $Res Function(QuizScore) _then;

/// Create a copy of QuizScore
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? moduleId = null,Object? sessionId = null,Object? topic = null,Object? score = null,}) {
  return _then(_self.copyWith(
moduleId: null == moduleId ? _self.moduleId : moduleId // ignore: cast_nullable_to_non_nullable
as String,sessionId: null == sessionId ? _self.sessionId : sessionId // ignore: cast_nullable_to_non_nullable
as String,topic: null == topic ? _self.topic : topic // ignore: cast_nullable_to_non_nullable
as String,score: null == score ? _self.score : score // ignore: cast_nullable_to_non_nullable
as int,
  ));
}

}


/// Adds pattern-matching-related methods to [QuizScore].
extension QuizScorePatterns on QuizScore {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _QuizScore value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _QuizScore() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _QuizScore value)  $default,){
final _that = this;
switch (_that) {
case _QuizScore():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _QuizScore value)?  $default,){
final _that = this;
switch (_that) {
case _QuizScore() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function(@JsonKey(name: "module_id")  String moduleId, @JsonKey(name: "session_id")  String sessionId,  String topic,  int score)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _QuizScore() when $default != null:
return $default(_that.moduleId,_that.sessionId,_that.topic,_that.score);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function(@JsonKey(name: "module_id")  String moduleId, @JsonKey(name: "session_id")  String sessionId,  String topic,  int score)  $default,) {final _that = this;
switch (_that) {
case _QuizScore():
return $default(_that.moduleId,_that.sessionId,_that.topic,_that.score);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function(@JsonKey(name: "module_id")  String moduleId, @JsonKey(name: "session_id")  String sessionId,  String topic,  int score)?  $default,) {final _that = this;
switch (_that) {
case _QuizScore() when $default != null:
return $default(_that.moduleId,_that.sessionId,_that.topic,_that.score);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _QuizScore implements QuizScore {
   _QuizScore({@JsonKey(name: "module_id") required this.moduleId, @JsonKey(name: "session_id") required this.sessionId, required this.topic, required this.score});
  factory _QuizScore.fromJson(Map<String, dynamic> json) => _$QuizScoreFromJson(json);

@override@JsonKey(name: "module_id") final  String moduleId;
@override@JsonKey(name: "session_id") final  String sessionId;
@override final  String topic;
@override final  int score;

/// Create a copy of QuizScore
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$QuizScoreCopyWith<_QuizScore> get copyWith => __$QuizScoreCopyWithImpl<_QuizScore>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$QuizScoreToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _QuizScore&&(identical(other.moduleId, moduleId) || other.moduleId == moduleId)&&(identical(other.sessionId, sessionId) || other.sessionId == sessionId)&&(identical(other.topic, topic) || other.topic == topic)&&(identical(other.score, score) || other.score == score));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,moduleId,sessionId,topic,score);

@override
String toString() {
  return 'QuizScore(moduleId: $moduleId, sessionId: $sessionId, topic: $topic, score: $score)';
}


}

/// @nodoc
abstract mixin class _$QuizScoreCopyWith<$Res> implements $QuizScoreCopyWith<$Res> {
  factory _$QuizScoreCopyWith(_QuizScore value, $Res Function(_QuizScore) _then) = __$QuizScoreCopyWithImpl;
@override @useResult
$Res call({
@JsonKey(name: "module_id") String moduleId,@JsonKey(name: "session_id") String sessionId, String topic, int score
});




}
/// @nodoc
class __$QuizScoreCopyWithImpl<$Res>
    implements _$QuizScoreCopyWith<$Res> {
  __$QuizScoreCopyWithImpl(this._self, this._then);

  final _QuizScore _self;
  final $Res Function(_QuizScore) _then;

/// Create a copy of QuizScore
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? moduleId = null,Object? sessionId = null,Object? topic = null,Object? score = null,}) {
  return _then(_QuizScore(
moduleId: null == moduleId ? _self.moduleId : moduleId // ignore: cast_nullable_to_non_nullable
as String,sessionId: null == sessionId ? _self.sessionId : sessionId // ignore: cast_nullable_to_non_nullable
as String,topic: null == topic ? _self.topic : topic // ignore: cast_nullable_to_non_nullable
as String,score: null == score ? _self.score : score // ignore: cast_nullable_to_non_nullable
as int,
  ));
}


}

// dart format on
