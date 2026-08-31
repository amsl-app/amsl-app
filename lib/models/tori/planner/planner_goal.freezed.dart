// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'planner_goal.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;
/// @nodoc
mixin _$PlannerGoal {

 String get id; String get name; bool get fulfilled; String? get description; DateTime get createdAt; DateTime get updatedAt; DateTime get date;
/// Create a copy of PlannerGoal
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$PlannerGoalCopyWith<PlannerGoal> get copyWith => _$PlannerGoalCopyWithImpl<PlannerGoal>(this as PlannerGoal, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is PlannerGoal&&(identical(other.id, id) || other.id == id)&&(identical(other.name, name) || other.name == name)&&(identical(other.fulfilled, fulfilled) || other.fulfilled == fulfilled)&&(identical(other.description, description) || other.description == description)&&(identical(other.createdAt, createdAt) || other.createdAt == createdAt)&&(identical(other.updatedAt, updatedAt) || other.updatedAt == updatedAt)&&(identical(other.date, date) || other.date == date));
}


@override
int get hashCode => Object.hash(runtimeType,id,name,fulfilled,description,createdAt,updatedAt,date);

@override
String toString() {
  return 'PlannerGoal(id: $id, name: $name, fulfilled: $fulfilled, description: $description, createdAt: $createdAt, updatedAt: $updatedAt, date: $date)';
}


}

/// @nodoc
abstract mixin class $PlannerGoalCopyWith<$Res>  {
  factory $PlannerGoalCopyWith(PlannerGoal value, $Res Function(PlannerGoal) _then) = _$PlannerGoalCopyWithImpl;
@useResult
$Res call({
 String id, String name, bool fulfilled, String? description, DateTime createdAt, DateTime updatedAt, DateTime date
});




}
/// @nodoc
class _$PlannerGoalCopyWithImpl<$Res>
    implements $PlannerGoalCopyWith<$Res> {
  _$PlannerGoalCopyWithImpl(this._self, this._then);

  final PlannerGoal _self;
  final $Res Function(PlannerGoal) _then;

/// Create a copy of PlannerGoal
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? id = null,Object? name = null,Object? fulfilled = null,Object? description = freezed,Object? createdAt = null,Object? updatedAt = null,Object? date = null,}) {
  return _then(_self.copyWith(
id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as String,name: null == name ? _self.name : name // ignore: cast_nullable_to_non_nullable
as String,fulfilled: null == fulfilled ? _self.fulfilled : fulfilled // ignore: cast_nullable_to_non_nullable
as bool,description: freezed == description ? _self.description : description // ignore: cast_nullable_to_non_nullable
as String?,createdAt: null == createdAt ? _self.createdAt : createdAt // ignore: cast_nullable_to_non_nullable
as DateTime,updatedAt: null == updatedAt ? _self.updatedAt : updatedAt // ignore: cast_nullable_to_non_nullable
as DateTime,date: null == date ? _self.date : date // ignore: cast_nullable_to_non_nullable
as DateTime,
  ));
}

}


/// Adds pattern-matching-related methods to [PlannerGoal].
extension PlannerGoalPatterns on PlannerGoal {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _PlannerGoal value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _PlannerGoal() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _PlannerGoal value)  $default,){
final _that = this;
switch (_that) {
case _PlannerGoal():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _PlannerGoal value)?  $default,){
final _that = this;
switch (_that) {
case _PlannerGoal() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( String id,  String name,  bool fulfilled,  String? description,  DateTime createdAt,  DateTime updatedAt,  DateTime date)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _PlannerGoal() when $default != null:
return $default(_that.id,_that.name,_that.fulfilled,_that.description,_that.createdAt,_that.updatedAt,_that.date);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( String id,  String name,  bool fulfilled,  String? description,  DateTime createdAt,  DateTime updatedAt,  DateTime date)  $default,) {final _that = this;
switch (_that) {
case _PlannerGoal():
return $default(_that.id,_that.name,_that.fulfilled,_that.description,_that.createdAt,_that.updatedAt,_that.date);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( String id,  String name,  bool fulfilled,  String? description,  DateTime createdAt,  DateTime updatedAt,  DateTime date)?  $default,) {final _that = this;
switch (_that) {
case _PlannerGoal() when $default != null:
return $default(_that.id,_that.name,_that.fulfilled,_that.description,_that.createdAt,_that.updatedAt,_that.date);case _:
  return null;

}
}

}

/// @nodoc


class _PlannerGoal implements PlannerGoal {
   _PlannerGoal({required this.id, required this.name, required this.fulfilled, this.description, required this.createdAt, required this.updatedAt, required this.date});
  

@override final  String id;
@override final  String name;
@override final  bool fulfilled;
@override final  String? description;
@override final  DateTime createdAt;
@override final  DateTime updatedAt;
@override final  DateTime date;

/// Create a copy of PlannerGoal
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$PlannerGoalCopyWith<_PlannerGoal> get copyWith => __$PlannerGoalCopyWithImpl<_PlannerGoal>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _PlannerGoal&&(identical(other.id, id) || other.id == id)&&(identical(other.name, name) || other.name == name)&&(identical(other.fulfilled, fulfilled) || other.fulfilled == fulfilled)&&(identical(other.description, description) || other.description == description)&&(identical(other.createdAt, createdAt) || other.createdAt == createdAt)&&(identical(other.updatedAt, updatedAt) || other.updatedAt == updatedAt)&&(identical(other.date, date) || other.date == date));
}


@override
int get hashCode => Object.hash(runtimeType,id,name,fulfilled,description,createdAt,updatedAt,date);

@override
String toString() {
  return 'PlannerGoal(id: $id, name: $name, fulfilled: $fulfilled, description: $description, createdAt: $createdAt, updatedAt: $updatedAt, date: $date)';
}


}

/// @nodoc
abstract mixin class _$PlannerGoalCopyWith<$Res> implements $PlannerGoalCopyWith<$Res> {
  factory _$PlannerGoalCopyWith(_PlannerGoal value, $Res Function(_PlannerGoal) _then) = __$PlannerGoalCopyWithImpl;
@override @useResult
$Res call({
 String id, String name, bool fulfilled, String? description, DateTime createdAt, DateTime updatedAt, DateTime date
});




}
/// @nodoc
class __$PlannerGoalCopyWithImpl<$Res>
    implements _$PlannerGoalCopyWith<$Res> {
  __$PlannerGoalCopyWithImpl(this._self, this._then);

  final _PlannerGoal _self;
  final $Res Function(_PlannerGoal) _then;

/// Create a copy of PlannerGoal
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? id = null,Object? name = null,Object? fulfilled = null,Object? description = freezed,Object? createdAt = null,Object? updatedAt = null,Object? date = null,}) {
  return _then(_PlannerGoal(
id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as String,name: null == name ? _self.name : name // ignore: cast_nullable_to_non_nullable
as String,fulfilled: null == fulfilled ? _self.fulfilled : fulfilled // ignore: cast_nullable_to_non_nullable
as bool,description: freezed == description ? _self.description : description // ignore: cast_nullable_to_non_nullable
as String?,createdAt: null == createdAt ? _self.createdAt : createdAt // ignore: cast_nullable_to_non_nullable
as DateTime,updatedAt: null == updatedAt ? _self.updatedAt : updatedAt // ignore: cast_nullable_to_non_nullable
as DateTime,date: null == date ? _self.date : date // ignore: cast_nullable_to_non_nullable
as DateTime,
  ));
}


}

// dart format on
