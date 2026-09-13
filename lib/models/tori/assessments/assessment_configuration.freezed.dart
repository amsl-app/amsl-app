// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'assessment_configuration.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;
/// @nodoc
mixin _$AssessmentConfiguration {

 Map<String, Assessment> get assessments;
/// Create a copy of AssessmentConfiguration
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$AssessmentConfigurationCopyWith<AssessmentConfiguration> get copyWith => _$AssessmentConfigurationCopyWithImpl<AssessmentConfiguration>(this as AssessmentConfiguration, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is AssessmentConfiguration&&const DeepCollectionEquality().equals(other.assessments, assessments));
}


@override
int get hashCode => Object.hash(runtimeType,const DeepCollectionEquality().hash(assessments));

@override
String toString() {
  return 'AssessmentConfiguration(assessments: $assessments)';
}


}

/// @nodoc
abstract mixin class $AssessmentConfigurationCopyWith<$Res>  {
  factory $AssessmentConfigurationCopyWith(AssessmentConfiguration value, $Res Function(AssessmentConfiguration) _then) = _$AssessmentConfigurationCopyWithImpl;
@useResult
$Res call({
 Map<String, Assessment> assessments
});




}
/// @nodoc
class _$AssessmentConfigurationCopyWithImpl<$Res>
    implements $AssessmentConfigurationCopyWith<$Res> {
  _$AssessmentConfigurationCopyWithImpl(this._self, this._then);

  final AssessmentConfiguration _self;
  final $Res Function(AssessmentConfiguration) _then;

/// Create a copy of AssessmentConfiguration
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? assessments = null,}) {
  return _then(_self.copyWith(
assessments: null == assessments ? _self.assessments : assessments // ignore: cast_nullable_to_non_nullable
as Map<String, Assessment>,
  ));
}

}


/// Adds pattern-matching-related methods to [AssessmentConfiguration].
extension AssessmentConfigurationPatterns on AssessmentConfiguration {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _AssessmentConfiguration value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _AssessmentConfiguration() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _AssessmentConfiguration value)  $default,){
final _that = this;
switch (_that) {
case _AssessmentConfiguration():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _AssessmentConfiguration value)?  $default,){
final _that = this;
switch (_that) {
case _AssessmentConfiguration() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( Map<String, Assessment> assessments)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _AssessmentConfiguration() when $default != null:
return $default(_that.assessments);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( Map<String, Assessment> assessments)  $default,) {final _that = this;
switch (_that) {
case _AssessmentConfiguration():
return $default(_that.assessments);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( Map<String, Assessment> assessments)?  $default,) {final _that = this;
switch (_that) {
case _AssessmentConfiguration() when $default != null:
return $default(_that.assessments);case _:
  return null;

}
}

}

/// @nodoc


class _AssessmentConfiguration extends AssessmentConfiguration {
   _AssessmentConfiguration({required final  Map<String, Assessment> assessments}): _assessments = assessments,super._();
  

 final  Map<String, Assessment> _assessments;
@override Map<String, Assessment> get assessments {
  if (_assessments is EqualUnmodifiableMapView) return _assessments;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableMapView(_assessments);
}


/// Create a copy of AssessmentConfiguration
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$AssessmentConfigurationCopyWith<_AssessmentConfiguration> get copyWith => __$AssessmentConfigurationCopyWithImpl<_AssessmentConfiguration>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _AssessmentConfiguration&&const DeepCollectionEquality().equals(other._assessments, _assessments));
}


@override
int get hashCode => Object.hash(runtimeType,const DeepCollectionEquality().hash(_assessments));

@override
String toString() {
  return 'AssessmentConfiguration(assessments: $assessments)';
}


}

/// @nodoc
abstract mixin class _$AssessmentConfigurationCopyWith<$Res> implements $AssessmentConfigurationCopyWith<$Res> {
  factory _$AssessmentConfigurationCopyWith(_AssessmentConfiguration value, $Res Function(_AssessmentConfiguration) _then) = __$AssessmentConfigurationCopyWithImpl;
@override @useResult
$Res call({
 Map<String, Assessment> assessments
});




}
/// @nodoc
class __$AssessmentConfigurationCopyWithImpl<$Res>
    implements _$AssessmentConfigurationCopyWith<$Res> {
  __$AssessmentConfigurationCopyWithImpl(this._self, this._then);

  final _AssessmentConfiguration _self;
  final $Res Function(_AssessmentConfiguration) _then;

/// Create a copy of AssessmentConfiguration
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? assessments = null,}) {
  return _then(_AssessmentConfiguration(
assessments: null == assessments ? _self._assessments : assessments // ignore: cast_nullable_to_non_nullable
as Map<String, Assessment>,
  ));
}


}

// dart format on
