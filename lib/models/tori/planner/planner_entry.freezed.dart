// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'planner_entry.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;
/// @nodoc
mixin _$PlannerEntry {

 String get id; DateTime get date; String get title; bool get completed; int get priority; PlannerMilestone? get milestone; DateTime get createdAt; DateTime get updatedAt;
/// Create a copy of PlannerEntry
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$PlannerEntryCopyWith<PlannerEntry> get copyWith => _$PlannerEntryCopyWithImpl<PlannerEntry>(this as PlannerEntry, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is PlannerEntry&&(identical(other.id, id) || other.id == id)&&(identical(other.date, date) || other.date == date)&&(identical(other.title, title) || other.title == title)&&(identical(other.completed, completed) || other.completed == completed)&&(identical(other.priority, priority) || other.priority == priority)&&(identical(other.milestone, milestone) || other.milestone == milestone)&&(identical(other.createdAt, createdAt) || other.createdAt == createdAt)&&(identical(other.updatedAt, updatedAt) || other.updatedAt == updatedAt));
}


@override
int get hashCode => Object.hash(runtimeType,id,date,title,completed,priority,milestone,createdAt,updatedAt);

@override
String toString() {
  return 'PlannerEntry(id: $id, date: $date, title: $title, completed: $completed, priority: $priority, milestone: $milestone, createdAt: $createdAt, updatedAt: $updatedAt)';
}


}

/// @nodoc
abstract mixin class $PlannerEntryCopyWith<$Res>  {
  factory $PlannerEntryCopyWith(PlannerEntry value, $Res Function(PlannerEntry) _then) = _$PlannerEntryCopyWithImpl;
@useResult
$Res call({
 String id, DateTime date, String title, bool completed, int priority, PlannerMilestone? milestone, DateTime createdAt, DateTime updatedAt
});


$PlannerMilestoneCopyWith<$Res>? get milestone;

}
/// @nodoc
class _$PlannerEntryCopyWithImpl<$Res>
    implements $PlannerEntryCopyWith<$Res> {
  _$PlannerEntryCopyWithImpl(this._self, this._then);

  final PlannerEntry _self;
  final $Res Function(PlannerEntry) _then;

/// Create a copy of PlannerEntry
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? id = null,Object? date = null,Object? title = null,Object? completed = null,Object? priority = null,Object? milestone = freezed,Object? createdAt = null,Object? updatedAt = null,}) {
  return _then(_self.copyWith(
id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as String,date: null == date ? _self.date : date // ignore: cast_nullable_to_non_nullable
as DateTime,title: null == title ? _self.title : title // ignore: cast_nullable_to_non_nullable
as String,completed: null == completed ? _self.completed : completed // ignore: cast_nullable_to_non_nullable
as bool,priority: null == priority ? _self.priority : priority // ignore: cast_nullable_to_non_nullable
as int,milestone: freezed == milestone ? _self.milestone : milestone // ignore: cast_nullable_to_non_nullable
as PlannerMilestone?,createdAt: null == createdAt ? _self.createdAt : createdAt // ignore: cast_nullable_to_non_nullable
as DateTime,updatedAt: null == updatedAt ? _self.updatedAt : updatedAt // ignore: cast_nullable_to_non_nullable
as DateTime,
  ));
}
/// Create a copy of PlannerEntry
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$PlannerMilestoneCopyWith<$Res>? get milestone {
    if (_self.milestone == null) {
    return null;
  }

  return $PlannerMilestoneCopyWith<$Res>(_self.milestone!, (value) {
    return _then(_self.copyWith(milestone: value));
  });
}
}


/// Adds pattern-matching-related methods to [PlannerEntry].
extension PlannerEntryPatterns on PlannerEntry {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _PlannerEntry value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _PlannerEntry() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _PlannerEntry value)  $default,){
final _that = this;
switch (_that) {
case _PlannerEntry():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _PlannerEntry value)?  $default,){
final _that = this;
switch (_that) {
case _PlannerEntry() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( String id,  DateTime date,  String title,  bool completed,  int priority,  PlannerMilestone? milestone,  DateTime createdAt,  DateTime updatedAt)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _PlannerEntry() when $default != null:
return $default(_that.id,_that.date,_that.title,_that.completed,_that.priority,_that.milestone,_that.createdAt,_that.updatedAt);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( String id,  DateTime date,  String title,  bool completed,  int priority,  PlannerMilestone? milestone,  DateTime createdAt,  DateTime updatedAt)  $default,) {final _that = this;
switch (_that) {
case _PlannerEntry():
return $default(_that.id,_that.date,_that.title,_that.completed,_that.priority,_that.milestone,_that.createdAt,_that.updatedAt);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( String id,  DateTime date,  String title,  bool completed,  int priority,  PlannerMilestone? milestone,  DateTime createdAt,  DateTime updatedAt)?  $default,) {final _that = this;
switch (_that) {
case _PlannerEntry() when $default != null:
return $default(_that.id,_that.date,_that.title,_that.completed,_that.priority,_that.milestone,_that.createdAt,_that.updatedAt);case _:
  return null;

}
}

}

/// @nodoc


class _PlannerEntry extends PlannerEntry {
  const _PlannerEntry({required this.id, required this.date, required this.title, required this.completed, required this.priority, this.milestone, required this.createdAt, required this.updatedAt}): super._();
  

@override final  String id;
@override final  DateTime date;
@override final  String title;
@override final  bool completed;
@override final  int priority;
@override final  PlannerMilestone? milestone;
@override final  DateTime createdAt;
@override final  DateTime updatedAt;

/// Create a copy of PlannerEntry
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$PlannerEntryCopyWith<_PlannerEntry> get copyWith => __$PlannerEntryCopyWithImpl<_PlannerEntry>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _PlannerEntry&&(identical(other.id, id) || other.id == id)&&(identical(other.date, date) || other.date == date)&&(identical(other.title, title) || other.title == title)&&(identical(other.completed, completed) || other.completed == completed)&&(identical(other.priority, priority) || other.priority == priority)&&(identical(other.milestone, milestone) || other.milestone == milestone)&&(identical(other.createdAt, createdAt) || other.createdAt == createdAt)&&(identical(other.updatedAt, updatedAt) || other.updatedAt == updatedAt));
}


@override
int get hashCode => Object.hash(runtimeType,id,date,title,completed,priority,milestone,createdAt,updatedAt);

@override
String toString() {
  return 'PlannerEntry(id: $id, date: $date, title: $title, completed: $completed, priority: $priority, milestone: $milestone, createdAt: $createdAt, updatedAt: $updatedAt)';
}


}

/// @nodoc
abstract mixin class _$PlannerEntryCopyWith<$Res> implements $PlannerEntryCopyWith<$Res> {
  factory _$PlannerEntryCopyWith(_PlannerEntry value, $Res Function(_PlannerEntry) _then) = __$PlannerEntryCopyWithImpl;
@override @useResult
$Res call({
 String id, DateTime date, String title, bool completed, int priority, PlannerMilestone? milestone, DateTime createdAt, DateTime updatedAt
});


@override $PlannerMilestoneCopyWith<$Res>? get milestone;

}
/// @nodoc
class __$PlannerEntryCopyWithImpl<$Res>
    implements _$PlannerEntryCopyWith<$Res> {
  __$PlannerEntryCopyWithImpl(this._self, this._then);

  final _PlannerEntry _self;
  final $Res Function(_PlannerEntry) _then;

/// Create a copy of PlannerEntry
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? id = null,Object? date = null,Object? title = null,Object? completed = null,Object? priority = null,Object? milestone = freezed,Object? createdAt = null,Object? updatedAt = null,}) {
  return _then(_PlannerEntry(
id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as String,date: null == date ? _self.date : date // ignore: cast_nullable_to_non_nullable
as DateTime,title: null == title ? _self.title : title // ignore: cast_nullable_to_non_nullable
as String,completed: null == completed ? _self.completed : completed // ignore: cast_nullable_to_non_nullable
as bool,priority: null == priority ? _self.priority : priority // ignore: cast_nullable_to_non_nullable
as int,milestone: freezed == milestone ? _self.milestone : milestone // ignore: cast_nullable_to_non_nullable
as PlannerMilestone?,createdAt: null == createdAt ? _self.createdAt : createdAt // ignore: cast_nullable_to_non_nullable
as DateTime,updatedAt: null == updatedAt ? _self.updatedAt : updatedAt // ignore: cast_nullable_to_non_nullable
as DateTime,
  ));
}

/// Create a copy of PlannerEntry
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$PlannerMilestoneCopyWith<$Res>? get milestone {
    if (_self.milestone == null) {
    return null;
  }

  return $PlannerMilestoneCopyWith<$Res>(_self.milestone!, (value) {
    return _then(_self.copyWith(milestone: value));
  });
}
}

// dart format on
