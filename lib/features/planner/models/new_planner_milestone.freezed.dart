// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'new_planner_milestone.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;

/// @nodoc
mixin _$NewPlannerMilestone {

 String get title; String get date; String? get description;
/// Create a copy of NewPlannerMilestone
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$NewPlannerMilestoneCopyWith<NewPlannerMilestone> get copyWith => _$NewPlannerMilestoneCopyWithImpl<NewPlannerMilestone>(this as NewPlannerMilestone, _$identity);

  /// Serializes this NewPlannerMilestone to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is NewPlannerMilestone&&(identical(other.title, title) || other.title == title)&&(identical(other.date, date) || other.date == date)&&(identical(other.description, description) || other.description == description));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,title,date,description);

@override
String toString() {
  return 'NewPlannerMilestone(title: $title, date: $date, description: $description)';
}


}

/// @nodoc
abstract mixin class $NewPlannerMilestoneCopyWith<$Res>  {
  factory $NewPlannerMilestoneCopyWith(NewPlannerMilestone value, $Res Function(NewPlannerMilestone) _then) = _$NewPlannerMilestoneCopyWithImpl;
@useResult
$Res call({
 String title, String date, String? description
});




}
/// @nodoc
class _$NewPlannerMilestoneCopyWithImpl<$Res>
    implements $NewPlannerMilestoneCopyWith<$Res> {
  _$NewPlannerMilestoneCopyWithImpl(this._self, this._then);

  final NewPlannerMilestone _self;
  final $Res Function(NewPlannerMilestone) _then;

/// Create a copy of NewPlannerMilestone
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? title = null,Object? date = null,Object? description = freezed,}) {
  return _then(_self.copyWith(
title: null == title ? _self.title : title // ignore: cast_nullable_to_non_nullable
as String,date: null == date ? _self.date : date // ignore: cast_nullable_to_non_nullable
as String,description: freezed == description ? _self.description : description // ignore: cast_nullable_to_non_nullable
as String?,
  ));
}

}


/// Adds pattern-matching-related methods to [NewPlannerMilestone].
extension NewPlannerMilestonePatterns on NewPlannerMilestone {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _NewPlannerMilestone value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _NewPlannerMilestone() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _NewPlannerMilestone value)  $default,){
final _that = this;
switch (_that) {
case _NewPlannerMilestone():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _NewPlannerMilestone value)?  $default,){
final _that = this;
switch (_that) {
case _NewPlannerMilestone() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( String title,  String date,  String? description)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _NewPlannerMilestone() when $default != null:
return $default(_that.title,_that.date,_that.description);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( String title,  String date,  String? description)  $default,) {final _that = this;
switch (_that) {
case _NewPlannerMilestone():
return $default(_that.title,_that.date,_that.description);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( String title,  String date,  String? description)?  $default,) {final _that = this;
switch (_that) {
case _NewPlannerMilestone() when $default != null:
return $default(_that.title,_that.date,_that.description);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _NewPlannerMilestone implements NewPlannerMilestone {
   _NewPlannerMilestone({required this.title, required this.date, this.description});
  factory _NewPlannerMilestone.fromJson(Map<String, dynamic> json) => _$NewPlannerMilestoneFromJson(json);

@override final  String title;
@override final  String date;
@override final  String? description;

/// Create a copy of NewPlannerMilestone
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$NewPlannerMilestoneCopyWith<_NewPlannerMilestone> get copyWith => __$NewPlannerMilestoneCopyWithImpl<_NewPlannerMilestone>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$NewPlannerMilestoneToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _NewPlannerMilestone&&(identical(other.title, title) || other.title == title)&&(identical(other.date, date) || other.date == date)&&(identical(other.description, description) || other.description == description));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,title,date,description);

@override
String toString() {
  return 'NewPlannerMilestone(title: $title, date: $date, description: $description)';
}


}

/// @nodoc
abstract mixin class _$NewPlannerMilestoneCopyWith<$Res> implements $NewPlannerMilestoneCopyWith<$Res> {
  factory _$NewPlannerMilestoneCopyWith(_NewPlannerMilestone value, $Res Function(_NewPlannerMilestone) _then) = __$NewPlannerMilestoneCopyWithImpl;
@override @useResult
$Res call({
 String title, String date, String? description
});




}
/// @nodoc
class __$NewPlannerMilestoneCopyWithImpl<$Res>
    implements _$NewPlannerMilestoneCopyWith<$Res> {
  __$NewPlannerMilestoneCopyWithImpl(this._self, this._then);

  final _NewPlannerMilestone _self;
  final $Res Function(_NewPlannerMilestone) _then;

/// Create a copy of NewPlannerMilestone
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? title = null,Object? date = null,Object? description = freezed,}) {
  return _then(_NewPlannerMilestone(
title: null == title ? _self.title : title // ignore: cast_nullable_to_non_nullable
as String,date: null == date ? _self.date : date // ignore: cast_nullable_to_non_nullable
as String,description: freezed == description ? _self.description : description // ignore: cast_nullable_to_non_nullable
as String?,
  ));
}


}

// dart format on
