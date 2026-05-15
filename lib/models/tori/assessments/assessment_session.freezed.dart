// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'assessment_session.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;
/// @nodoc
mixin _$ToriAssessmentSession {

 String get sessionId; String get assessmentId; String get title; Map<String, Question> get questions; List<Scale> get scales; hikari_assessment.AssessmentStatus get status; DateTime? get completed;
/// Create a copy of ToriAssessmentSession
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$ToriAssessmentSessionCopyWith<ToriAssessmentSession> get copyWith => _$ToriAssessmentSessionCopyWithImpl<ToriAssessmentSession>(this as ToriAssessmentSession, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is ToriAssessmentSession&&(identical(other.sessionId, sessionId) || other.sessionId == sessionId)&&(identical(other.assessmentId, assessmentId) || other.assessmentId == assessmentId)&&(identical(other.title, title) || other.title == title)&&const DeepCollectionEquality().equals(other.questions, questions)&&const DeepCollectionEquality().equals(other.scales, scales)&&(identical(other.status, status) || other.status == status)&&(identical(other.completed, completed) || other.completed == completed));
}


@override
int get hashCode => Object.hash(runtimeType,sessionId,assessmentId,title,const DeepCollectionEquality().hash(questions),const DeepCollectionEquality().hash(scales),status,completed);

@override
String toString() {
  return 'ToriAssessmentSession(sessionId: $sessionId, assessmentId: $assessmentId, title: $title, questions: $questions, scales: $scales, status: $status, completed: $completed)';
}


}

/// @nodoc
abstract mixin class $ToriAssessmentSessionCopyWith<$Res>  {
  factory $ToriAssessmentSessionCopyWith(ToriAssessmentSession value, $Res Function(ToriAssessmentSession) _then) = _$ToriAssessmentSessionCopyWithImpl;
@useResult
$Res call({
 String sessionId, String assessmentId, String title, Map<String, Question> questions, List<Scale> scales, hikari_assessment.AssessmentStatus status, DateTime? completed
});




}
/// @nodoc
class _$ToriAssessmentSessionCopyWithImpl<$Res>
    implements $ToriAssessmentSessionCopyWith<$Res> {
  _$ToriAssessmentSessionCopyWithImpl(this._self, this._then);

  final ToriAssessmentSession _self;
  final $Res Function(ToriAssessmentSession) _then;

/// Create a copy of ToriAssessmentSession
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? sessionId = null,Object? assessmentId = null,Object? title = null,Object? questions = null,Object? scales = null,Object? status = null,Object? completed = freezed,}) {
  return _then(_self.copyWith(
sessionId: null == sessionId ? _self.sessionId : sessionId // ignore: cast_nullable_to_non_nullable
as String,assessmentId: null == assessmentId ? _self.assessmentId : assessmentId // ignore: cast_nullable_to_non_nullable
as String,title: null == title ? _self.title : title // ignore: cast_nullable_to_non_nullable
as String,questions: null == questions ? _self.questions : questions // ignore: cast_nullable_to_non_nullable
as Map<String, Question>,scales: null == scales ? _self.scales : scales // ignore: cast_nullable_to_non_nullable
as List<Scale>,status: null == status ? _self.status : status // ignore: cast_nullable_to_non_nullable
as hikari_assessment.AssessmentStatus,completed: freezed == completed ? _self.completed : completed // ignore: cast_nullable_to_non_nullable
as DateTime?,
  ));
}

}


/// Adds pattern-matching-related methods to [ToriAssessmentSession].
extension ToriAssessmentSessionPatterns on ToriAssessmentSession {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _ToriAssessmentSession value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _ToriAssessmentSession() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _ToriAssessmentSession value)  $default,){
final _that = this;
switch (_that) {
case _ToriAssessmentSession():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _ToriAssessmentSession value)?  $default,){
final _that = this;
switch (_that) {
case _ToriAssessmentSession() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( String sessionId,  String assessmentId,  String title,  Map<String, Question> questions,  List<Scale> scales,  hikari_assessment.AssessmentStatus status,  DateTime? completed)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _ToriAssessmentSession() when $default != null:
return $default(_that.sessionId,_that.assessmentId,_that.title,_that.questions,_that.scales,_that.status,_that.completed);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( String sessionId,  String assessmentId,  String title,  Map<String, Question> questions,  List<Scale> scales,  hikari_assessment.AssessmentStatus status,  DateTime? completed)  $default,) {final _that = this;
switch (_that) {
case _ToriAssessmentSession():
return $default(_that.sessionId,_that.assessmentId,_that.title,_that.questions,_that.scales,_that.status,_that.completed);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( String sessionId,  String assessmentId,  String title,  Map<String, Question> questions,  List<Scale> scales,  hikari_assessment.AssessmentStatus status,  DateTime? completed)?  $default,) {final _that = this;
switch (_that) {
case _ToriAssessmentSession() when $default != null:
return $default(_that.sessionId,_that.assessmentId,_that.title,_that.questions,_that.scales,_that.status,_that.completed);case _:
  return null;

}
}

}

/// @nodoc


class _ToriAssessmentSession extends ToriAssessmentSession {
   _ToriAssessmentSession({required this.sessionId, required this.assessmentId, required this.title, required final  Map<String, Question> questions, required final  List<Scale> scales, required this.status, required this.completed}): _questions = questions,_scales = scales,super._();
  

@override final  String sessionId;
@override final  String assessmentId;
@override final  String title;
 final  Map<String, Question> _questions;
@override Map<String, Question> get questions {
  if (_questions is EqualUnmodifiableMapView) return _questions;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableMapView(_questions);
}

 final  List<Scale> _scales;
@override List<Scale> get scales {
  if (_scales is EqualUnmodifiableListView) return _scales;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(_scales);
}

@override final  hikari_assessment.AssessmentStatus status;
@override final  DateTime? completed;

/// Create a copy of ToriAssessmentSession
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$ToriAssessmentSessionCopyWith<_ToriAssessmentSession> get copyWith => __$ToriAssessmentSessionCopyWithImpl<_ToriAssessmentSession>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _ToriAssessmentSession&&(identical(other.sessionId, sessionId) || other.sessionId == sessionId)&&(identical(other.assessmentId, assessmentId) || other.assessmentId == assessmentId)&&(identical(other.title, title) || other.title == title)&&const DeepCollectionEquality().equals(other._questions, _questions)&&const DeepCollectionEquality().equals(other._scales, _scales)&&(identical(other.status, status) || other.status == status)&&(identical(other.completed, completed) || other.completed == completed));
}


@override
int get hashCode => Object.hash(runtimeType,sessionId,assessmentId,title,const DeepCollectionEquality().hash(_questions),const DeepCollectionEquality().hash(_scales),status,completed);

@override
String toString() {
  return 'ToriAssessmentSession(sessionId: $sessionId, assessmentId: $assessmentId, title: $title, questions: $questions, scales: $scales, status: $status, completed: $completed)';
}


}

/// @nodoc
abstract mixin class _$ToriAssessmentSessionCopyWith<$Res> implements $ToriAssessmentSessionCopyWith<$Res> {
  factory _$ToriAssessmentSessionCopyWith(_ToriAssessmentSession value, $Res Function(_ToriAssessmentSession) _then) = __$ToriAssessmentSessionCopyWithImpl;
@override @useResult
$Res call({
 String sessionId, String assessmentId, String title, Map<String, Question> questions, List<Scale> scales, hikari_assessment.AssessmentStatus status, DateTime? completed
});




}
/// @nodoc
class __$ToriAssessmentSessionCopyWithImpl<$Res>
    implements _$ToriAssessmentSessionCopyWith<$Res> {
  __$ToriAssessmentSessionCopyWithImpl(this._self, this._then);

  final _ToriAssessmentSession _self;
  final $Res Function(_ToriAssessmentSession) _then;

/// Create a copy of ToriAssessmentSession
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? sessionId = null,Object? assessmentId = null,Object? title = null,Object? questions = null,Object? scales = null,Object? status = null,Object? completed = freezed,}) {
  return _then(_ToriAssessmentSession(
sessionId: null == sessionId ? _self.sessionId : sessionId // ignore: cast_nullable_to_non_nullable
as String,assessmentId: null == assessmentId ? _self.assessmentId : assessmentId // ignore: cast_nullable_to_non_nullable
as String,title: null == title ? _self.title : title // ignore: cast_nullable_to_non_nullable
as String,questions: null == questions ? _self._questions : questions // ignore: cast_nullable_to_non_nullable
as Map<String, Question>,scales: null == scales ? _self._scales : scales // ignore: cast_nullable_to_non_nullable
as List<Scale>,status: null == status ? _self.status : status // ignore: cast_nullable_to_non_nullable
as hikari_assessment.AssessmentStatus,completed: freezed == completed ? _self.completed : completed // ignore: cast_nullable_to_non_nullable
as DateTime?,
  ));
}


}

// dart format on
