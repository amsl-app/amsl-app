// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'module_configuration.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;
/// @nodoc
mixin _$ModuleConfiguration {

 Map<ModuleCategory, List<ModuleAssessmentSet>> get modules; Map<String, ModuleGroup> get groups;
/// Create a copy of ModuleConfiguration
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$ModuleConfigurationCopyWith<ModuleConfiguration> get copyWith => _$ModuleConfigurationCopyWithImpl<ModuleConfiguration>(this as ModuleConfiguration, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is ModuleConfiguration&&const DeepCollectionEquality().equals(other.modules, modules)&&const DeepCollectionEquality().equals(other.groups, groups));
}


@override
int get hashCode => Object.hash(runtimeType,const DeepCollectionEquality().hash(modules),const DeepCollectionEquality().hash(groups));

@override
String toString() {
  return 'ModuleConfiguration(modules: $modules, groups: $groups)';
}


}

/// @nodoc
abstract mixin class $ModuleConfigurationCopyWith<$Res>  {
  factory $ModuleConfigurationCopyWith(ModuleConfiguration value, $Res Function(ModuleConfiguration) _then) = _$ModuleConfigurationCopyWithImpl;
@useResult
$Res call({
 Map<ModuleCategory, List<ModuleAssessmentSet>> modules, Map<String, ModuleGroup> groups
});




}
/// @nodoc
class _$ModuleConfigurationCopyWithImpl<$Res>
    implements $ModuleConfigurationCopyWith<$Res> {
  _$ModuleConfigurationCopyWithImpl(this._self, this._then);

  final ModuleConfiguration _self;
  final $Res Function(ModuleConfiguration) _then;

/// Create a copy of ModuleConfiguration
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? modules = null,Object? groups = null,}) {
  return _then(_self.copyWith(
modules: null == modules ? _self.modules : modules // ignore: cast_nullable_to_non_nullable
as Map<ModuleCategory, List<ModuleAssessmentSet>>,groups: null == groups ? _self.groups : groups // ignore: cast_nullable_to_non_nullable
as Map<String, ModuleGroup>,
  ));
}

}


/// Adds pattern-matching-related methods to [ModuleConfiguration].
extension ModuleConfigurationPatterns on ModuleConfiguration {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _ModuleConfiguration value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _ModuleConfiguration() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _ModuleConfiguration value)  $default,){
final _that = this;
switch (_that) {
case _ModuleConfiguration():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _ModuleConfiguration value)?  $default,){
final _that = this;
switch (_that) {
case _ModuleConfiguration() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( Map<ModuleCategory, List<ModuleAssessmentSet>> modules,  Map<String, ModuleGroup> groups)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _ModuleConfiguration() when $default != null:
return $default(_that.modules,_that.groups);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( Map<ModuleCategory, List<ModuleAssessmentSet>> modules,  Map<String, ModuleGroup> groups)  $default,) {final _that = this;
switch (_that) {
case _ModuleConfiguration():
return $default(_that.modules,_that.groups);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( Map<ModuleCategory, List<ModuleAssessmentSet>> modules,  Map<String, ModuleGroup> groups)?  $default,) {final _that = this;
switch (_that) {
case _ModuleConfiguration() when $default != null:
return $default(_that.modules,_that.groups);case _:
  return null;

}
}

}

/// @nodoc


class _ModuleConfiguration extends ModuleConfiguration {
   _ModuleConfiguration({required final  Map<ModuleCategory, List<ModuleAssessmentSet>> modules, required final  Map<String, ModuleGroup> groups}): _modules = modules,_groups = groups,super._();
  

 final  Map<ModuleCategory, List<ModuleAssessmentSet>> _modules;
@override Map<ModuleCategory, List<ModuleAssessmentSet>> get modules {
  if (_modules is EqualUnmodifiableMapView) return _modules;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableMapView(_modules);
}

 final  Map<String, ModuleGroup> _groups;
@override Map<String, ModuleGroup> get groups {
  if (_groups is EqualUnmodifiableMapView) return _groups;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableMapView(_groups);
}


/// Create a copy of ModuleConfiguration
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$ModuleConfigurationCopyWith<_ModuleConfiguration> get copyWith => __$ModuleConfigurationCopyWithImpl<_ModuleConfiguration>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _ModuleConfiguration&&const DeepCollectionEquality().equals(other._modules, _modules)&&const DeepCollectionEquality().equals(other._groups, _groups));
}


@override
int get hashCode => Object.hash(runtimeType,const DeepCollectionEquality().hash(_modules),const DeepCollectionEquality().hash(_groups));

@override
String toString() {
  return 'ModuleConfiguration(modules: $modules, groups: $groups)';
}


}

/// @nodoc
abstract mixin class _$ModuleConfigurationCopyWith<$Res> implements $ModuleConfigurationCopyWith<$Res> {
  factory _$ModuleConfigurationCopyWith(_ModuleConfiguration value, $Res Function(_ModuleConfiguration) _then) = __$ModuleConfigurationCopyWithImpl;
@override @useResult
$Res call({
 Map<ModuleCategory, List<ModuleAssessmentSet>> modules, Map<String, ModuleGroup> groups
});




}
/// @nodoc
class __$ModuleConfigurationCopyWithImpl<$Res>
    implements _$ModuleConfigurationCopyWith<$Res> {
  __$ModuleConfigurationCopyWithImpl(this._self, this._then);

  final _ModuleConfiguration _self;
  final $Res Function(_ModuleConfiguration) _then;

/// Create a copy of ModuleConfiguration
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? modules = null,Object? groups = null,}) {
  return _then(_ModuleConfiguration(
modules: null == modules ? _self._modules : modules // ignore: cast_nullable_to_non_nullable
as Map<ModuleCategory, List<ModuleAssessmentSet>>,groups: null == groups ? _self._groups : groups // ignore: cast_nullable_to_non_nullable
as Map<String, ModuleGroup>,
  ));
}


}

// dart format on
