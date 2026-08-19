// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'planner_milestone.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;

/// @nodoc
mixin _$PlannerMilestone {

 String get id; String get title; DateTime get date; String? get description;@JsonKey(name: 'module_id') String? get moduleId;@JsonKey(name: 'origin_id') String? get originId;@JsonKey(name: 'created_at') DateTime get createdAt;@JsonKey(name: 'updated_at') DateTime get updatedAt;
/// Create a copy of PlannerMilestone
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$PlannerMilestoneCopyWith<PlannerMilestone> get copyWith => _$PlannerMilestoneCopyWithImpl<PlannerMilestone>(this as PlannerMilestone, _$identity);

  /// Serializes this PlannerMilestone to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is PlannerMilestone&&(identical(other.id, id) || other.id == id)&&(identical(other.title, title) || other.title == title)&&(identical(other.date, date) || other.date == date)&&(identical(other.description, description) || other.description == description)&&(identical(other.moduleId, moduleId) || other.moduleId == moduleId)&&(identical(other.originId, originId) || other.originId == originId)&&(identical(other.createdAt, createdAt) || other.createdAt == createdAt)&&(identical(other.updatedAt, updatedAt) || other.updatedAt == updatedAt));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,id,title,date,description,moduleId,originId,createdAt,updatedAt);

@override
String toString() {
  return 'PlannerMilestone(id: $id, title: $title, date: $date, description: $description, moduleId: $moduleId, originId: $originId, createdAt: $createdAt, updatedAt: $updatedAt)';
}


}

/// @nodoc
abstract mixin class $PlannerMilestoneCopyWith<$Res>  {
  factory $PlannerMilestoneCopyWith(PlannerMilestone value, $Res Function(PlannerMilestone) _then) = _$PlannerMilestoneCopyWithImpl;
@useResult
$Res call({
 String id, String title, DateTime date, String? description,@JsonKey(name: 'module_id') String? moduleId,@JsonKey(name: 'origin_id') String? originId,@JsonKey(name: 'created_at') DateTime createdAt,@JsonKey(name: 'updated_at') DateTime updatedAt
});




}
/// @nodoc
class _$PlannerMilestoneCopyWithImpl<$Res>
    implements $PlannerMilestoneCopyWith<$Res> {
  _$PlannerMilestoneCopyWithImpl(this._self, this._then);

  final PlannerMilestone _self;
  final $Res Function(PlannerMilestone) _then;

/// Create a copy of PlannerMilestone
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? id = null,Object? title = null,Object? date = null,Object? description = freezed,Object? moduleId = freezed,Object? originId = freezed,Object? createdAt = null,Object? updatedAt = null,}) {
  return _then(_self.copyWith(
id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as String,title: null == title ? _self.title : title // ignore: cast_nullable_to_non_nullable
as String,date: null == date ? _self.date : date // ignore: cast_nullable_to_non_nullable
as DateTime,description: freezed == description ? _self.description : description // ignore: cast_nullable_to_non_nullable
as String?,moduleId: freezed == moduleId ? _self.moduleId : moduleId // ignore: cast_nullable_to_non_nullable
as String?,originId: freezed == originId ? _self.originId : originId // ignore: cast_nullable_to_non_nullable
as String?,createdAt: null == createdAt ? _self.createdAt : createdAt // ignore: cast_nullable_to_non_nullable
as DateTime,updatedAt: null == updatedAt ? _self.updatedAt : updatedAt // ignore: cast_nullable_to_non_nullable
as DateTime,
  ));
}

}


/// Adds pattern-matching-related methods to [PlannerMilestone].
extension PlannerMilestonePatterns on PlannerMilestone {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _PlannerMilestone value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _PlannerMilestone() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _PlannerMilestone value)  $default,){
final _that = this;
switch (_that) {
case _PlannerMilestone():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _PlannerMilestone value)?  $default,){
final _that = this;
switch (_that) {
case _PlannerMilestone() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( String id,  String title,  DateTime date,  String? description, @JsonKey(name: 'module_id')  String? moduleId, @JsonKey(name: 'origin_id')  String? originId, @JsonKey(name: 'created_at')  DateTime createdAt, @JsonKey(name: 'updated_at')  DateTime updatedAt)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _PlannerMilestone() when $default != null:
return $default(_that.id,_that.title,_that.date,_that.description,_that.moduleId,_that.originId,_that.createdAt,_that.updatedAt);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( String id,  String title,  DateTime date,  String? description, @JsonKey(name: 'module_id')  String? moduleId, @JsonKey(name: 'origin_id')  String? originId, @JsonKey(name: 'created_at')  DateTime createdAt, @JsonKey(name: 'updated_at')  DateTime updatedAt)  $default,) {final _that = this;
switch (_that) {
case _PlannerMilestone():
return $default(_that.id,_that.title,_that.date,_that.description,_that.moduleId,_that.originId,_that.createdAt,_that.updatedAt);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( String id,  String title,  DateTime date,  String? description, @JsonKey(name: 'module_id')  String? moduleId, @JsonKey(name: 'origin_id')  String? originId, @JsonKey(name: 'created_at')  DateTime createdAt, @JsonKey(name: 'updated_at')  DateTime updatedAt)?  $default,) {final _that = this;
switch (_that) {
case _PlannerMilestone() when $default != null:
return $default(_that.id,_that.title,_that.date,_that.description,_that.moduleId,_that.originId,_that.createdAt,_that.updatedAt);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _PlannerMilestone implements PlannerMilestone {
   _PlannerMilestone({required this.id, required this.title, required this.date, this.description, @JsonKey(name: 'module_id') this.moduleId, @JsonKey(name: 'origin_id') this.originId, @JsonKey(name: 'created_at') required this.createdAt, @JsonKey(name: 'updated_at') required this.updatedAt});
  factory _PlannerMilestone.fromJson(Map<String, dynamic> json) => _$PlannerMilestoneFromJson(json);

@override final  String id;
@override final  String title;
@override final  DateTime date;
@override final  String? description;
@override@JsonKey(name: 'module_id') final  String? moduleId;
@override@JsonKey(name: 'origin_id') final  String? originId;
@override@JsonKey(name: 'created_at') final  DateTime createdAt;
@override@JsonKey(name: 'updated_at') final  DateTime updatedAt;

/// Create a copy of PlannerMilestone
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$PlannerMilestoneCopyWith<_PlannerMilestone> get copyWith => __$PlannerMilestoneCopyWithImpl<_PlannerMilestone>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$PlannerMilestoneToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _PlannerMilestone&&(identical(other.id, id) || other.id == id)&&(identical(other.title, title) || other.title == title)&&(identical(other.date, date) || other.date == date)&&(identical(other.description, description) || other.description == description)&&(identical(other.moduleId, moduleId) || other.moduleId == moduleId)&&(identical(other.originId, originId) || other.originId == originId)&&(identical(other.createdAt, createdAt) || other.createdAt == createdAt)&&(identical(other.updatedAt, updatedAt) || other.updatedAt == updatedAt));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,id,title,date,description,moduleId,originId,createdAt,updatedAt);

@override
String toString() {
  return 'PlannerMilestone(id: $id, title: $title, date: $date, description: $description, moduleId: $moduleId, originId: $originId, createdAt: $createdAt, updatedAt: $updatedAt)';
}


}

/// @nodoc
abstract mixin class _$PlannerMilestoneCopyWith<$Res> implements $PlannerMilestoneCopyWith<$Res> {
  factory _$PlannerMilestoneCopyWith(_PlannerMilestone value, $Res Function(_PlannerMilestone) _then) = __$PlannerMilestoneCopyWithImpl;
@override @useResult
$Res call({
 String id, String title, DateTime date, String? description,@JsonKey(name: 'module_id') String? moduleId,@JsonKey(name: 'origin_id') String? originId,@JsonKey(name: 'created_at') DateTime createdAt,@JsonKey(name: 'updated_at') DateTime updatedAt
});




}
/// @nodoc
class __$PlannerMilestoneCopyWithImpl<$Res>
    implements _$PlannerMilestoneCopyWith<$Res> {
  __$PlannerMilestoneCopyWithImpl(this._self, this._then);

  final _PlannerMilestone _self;
  final $Res Function(_PlannerMilestone) _then;

/// Create a copy of PlannerMilestone
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? id = null,Object? title = null,Object? date = null,Object? description = freezed,Object? moduleId = freezed,Object? originId = freezed,Object? createdAt = null,Object? updatedAt = null,}) {
  return _then(_PlannerMilestone(
id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as String,title: null == title ? _self.title : title // ignore: cast_nullable_to_non_nullable
as String,date: null == date ? _self.date : date // ignore: cast_nullable_to_non_nullable
as DateTime,description: freezed == description ? _self.description : description // ignore: cast_nullable_to_non_nullable
as String?,moduleId: freezed == moduleId ? _self.moduleId : moduleId // ignore: cast_nullable_to_non_nullable
as String?,originId: freezed == originId ? _self.originId : originId // ignore: cast_nullable_to_non_nullable
as String?,createdAt: null == createdAt ? _self.createdAt : createdAt // ignore: cast_nullable_to_non_nullable
as DateTime,updatedAt: null == updatedAt ? _self.updatedAt : updatedAt // ignore: cast_nullable_to_non_nullable
as DateTime,
  ));
}


}

// dart format on
