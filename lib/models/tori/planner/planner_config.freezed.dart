// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'planner_config.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;
/// @nodoc
mixin _$PlannerConfig {

 List<PlannerEntry> get entries; Map<String, PlannerMilestone> get milestones;
/// Create a copy of PlannerConfig
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$PlannerConfigCopyWith<PlannerConfig> get copyWith => _$PlannerConfigCopyWithImpl<PlannerConfig>(this as PlannerConfig, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is PlannerConfig&&const DeepCollectionEquality().equals(other.entries, entries)&&const DeepCollectionEquality().equals(other.milestones, milestones));
}


@override
int get hashCode => Object.hash(runtimeType,const DeepCollectionEquality().hash(entries),const DeepCollectionEquality().hash(milestones));

@override
String toString() {
  return 'PlannerConfig(entries: $entries, milestones: $milestones)';
}


}

/// @nodoc
abstract mixin class $PlannerConfigCopyWith<$Res>  {
  factory $PlannerConfigCopyWith(PlannerConfig value, $Res Function(PlannerConfig) _then) = _$PlannerConfigCopyWithImpl;
@useResult
$Res call({
 List<PlannerEntry> entries, Map<String, PlannerMilestone> milestones
});




}
/// @nodoc
class _$PlannerConfigCopyWithImpl<$Res>
    implements $PlannerConfigCopyWith<$Res> {
  _$PlannerConfigCopyWithImpl(this._self, this._then);

  final PlannerConfig _self;
  final $Res Function(PlannerConfig) _then;

/// Create a copy of PlannerConfig
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? entries = null,Object? milestones = null,}) {
  return _then(_self.copyWith(
entries: null == entries ? _self.entries : entries // ignore: cast_nullable_to_non_nullable
as List<PlannerEntry>,milestones: null == milestones ? _self.milestones : milestones // ignore: cast_nullable_to_non_nullable
as Map<String, PlannerMilestone>,
  ));
}

}


/// Adds pattern-matching-related methods to [PlannerConfig].
extension PlannerConfigPatterns on PlannerConfig {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _PlannerConfig value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _PlannerConfig() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _PlannerConfig value)  $default,){
final _that = this;
switch (_that) {
case _PlannerConfig():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _PlannerConfig value)?  $default,){
final _that = this;
switch (_that) {
case _PlannerConfig() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( List<PlannerEntry> entries,  Map<String, PlannerMilestone> milestones)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _PlannerConfig() when $default != null:
return $default(_that.entries,_that.milestones);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( List<PlannerEntry> entries,  Map<String, PlannerMilestone> milestones)  $default,) {final _that = this;
switch (_that) {
case _PlannerConfig():
return $default(_that.entries,_that.milestones);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( List<PlannerEntry> entries,  Map<String, PlannerMilestone> milestones)?  $default,) {final _that = this;
switch (_that) {
case _PlannerConfig() when $default != null:
return $default(_that.entries,_that.milestones);case _:
  return null;

}
}

}

/// @nodoc


class _PlannerConfig extends PlannerConfig {
  const _PlannerConfig({required final  List<PlannerEntry> entries, required final  Map<String, PlannerMilestone> milestones}): _entries = entries,_milestones = milestones,super._();
  

 final  List<PlannerEntry> _entries;
@override List<PlannerEntry> get entries {
  if (_entries is EqualUnmodifiableListView) return _entries;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(_entries);
}

 final  Map<String, PlannerMilestone> _milestones;
@override Map<String, PlannerMilestone> get milestones {
  if (_milestones is EqualUnmodifiableMapView) return _milestones;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableMapView(_milestones);
}


/// Create a copy of PlannerConfig
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$PlannerConfigCopyWith<_PlannerConfig> get copyWith => __$PlannerConfigCopyWithImpl<_PlannerConfig>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _PlannerConfig&&const DeepCollectionEquality().equals(other._entries, _entries)&&const DeepCollectionEquality().equals(other._milestones, _milestones));
}


@override
int get hashCode => Object.hash(runtimeType,const DeepCollectionEquality().hash(_entries),const DeepCollectionEquality().hash(_milestones));

@override
String toString() {
  return 'PlannerConfig(entries: $entries, milestones: $milestones)';
}


}

/// @nodoc
abstract mixin class _$PlannerConfigCopyWith<$Res> implements $PlannerConfigCopyWith<$Res> {
  factory _$PlannerConfigCopyWith(_PlannerConfig value, $Res Function(_PlannerConfig) _then) = __$PlannerConfigCopyWithImpl;
@override @useResult
$Res call({
 List<PlannerEntry> entries, Map<String, PlannerMilestone> milestones
});




}
/// @nodoc
class __$PlannerConfigCopyWithImpl<$Res>
    implements _$PlannerConfigCopyWith<$Res> {
  __$PlannerConfigCopyWithImpl(this._self, this._then);

  final _PlannerConfig _self;
  final $Res Function(_PlannerConfig) _then;

/// Create a copy of PlannerConfig
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? entries = null,Object? milestones = null,}) {
  return _then(_PlannerConfig(
entries: null == entries ? _self._entries : entries // ignore: cast_nullable_to_non_nullable
as List<PlannerEntry>,milestones: null == milestones ? _self._milestones : milestones // ignore: cast_nullable_to_non_nullable
as Map<String, PlannerMilestone>,
  ));
}


}

// dart format on
