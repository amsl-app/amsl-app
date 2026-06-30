// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'new_planner_entry.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;

/// @nodoc
mixin _$NewPlannerEntry {

 String get date; String get title; int get priority;@JsonKey(name: 'module_id') String? get moduleId;@JsonKey(name: 'session_id') String? get sessionId;
/// Create a copy of NewPlannerEntry
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$NewPlannerEntryCopyWith<NewPlannerEntry> get copyWith => _$NewPlannerEntryCopyWithImpl<NewPlannerEntry>(this as NewPlannerEntry, _$identity);

  /// Serializes this NewPlannerEntry to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is NewPlannerEntry&&(identical(other.date, date) || other.date == date)&&(identical(other.title, title) || other.title == title)&&(identical(other.priority, priority) || other.priority == priority)&&(identical(other.moduleId, moduleId) || other.moduleId == moduleId)&&(identical(other.sessionId, sessionId) || other.sessionId == sessionId));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,date,title,priority,moduleId,sessionId);

@override
String toString() {
  return 'NewPlannerEntry(date: $date, title: $title, priority: $priority, moduleId: $moduleId, sessionId: $sessionId)';
}


}

/// @nodoc
abstract mixin class $NewPlannerEntryCopyWith<$Res>  {
  factory $NewPlannerEntryCopyWith(NewPlannerEntry value, $Res Function(NewPlannerEntry) _then) = _$NewPlannerEntryCopyWithImpl;
@useResult
$Res call({
 String date, String title, int priority,@JsonKey(name: 'module_id') String? moduleId,@JsonKey(name: 'session_id') String? sessionId
});




}
/// @nodoc
class _$NewPlannerEntryCopyWithImpl<$Res>
    implements $NewPlannerEntryCopyWith<$Res> {
  _$NewPlannerEntryCopyWithImpl(this._self, this._then);

  final NewPlannerEntry _self;
  final $Res Function(NewPlannerEntry) _then;

/// Create a copy of NewPlannerEntry
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? date = null,Object? title = null,Object? priority = null,Object? moduleId = freezed,Object? sessionId = freezed,}) {
  return _then(_self.copyWith(
date: null == date ? _self.date : date // ignore: cast_nullable_to_non_nullable
as String,title: null == title ? _self.title : title // ignore: cast_nullable_to_non_nullable
as String,priority: null == priority ? _self.priority : priority // ignore: cast_nullable_to_non_nullable
as int,moduleId: freezed == moduleId ? _self.moduleId : moduleId // ignore: cast_nullable_to_non_nullable
as String?,sessionId: freezed == sessionId ? _self.sessionId : sessionId // ignore: cast_nullable_to_non_nullable
as String?,
  ));
}

}


/// Adds pattern-matching-related methods to [NewPlannerEntry].
extension NewPlannerEntryPatterns on NewPlannerEntry {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _NewPlannerEntry value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _NewPlannerEntry() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _NewPlannerEntry value)  $default,){
final _that = this;
switch (_that) {
case _NewPlannerEntry():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _NewPlannerEntry value)?  $default,){
final _that = this;
switch (_that) {
case _NewPlannerEntry() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( String date,  String title,  int priority, @JsonKey(name: 'module_id')  String? moduleId, @JsonKey(name: 'session_id')  String? sessionId)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _NewPlannerEntry() when $default != null:
return $default(_that.date,_that.title,_that.priority,_that.moduleId,_that.sessionId);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( String date,  String title,  int priority, @JsonKey(name: 'module_id')  String? moduleId, @JsonKey(name: 'session_id')  String? sessionId)  $default,) {final _that = this;
switch (_that) {
case _NewPlannerEntry():
return $default(_that.date,_that.title,_that.priority,_that.moduleId,_that.sessionId);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( String date,  String title,  int priority, @JsonKey(name: 'module_id')  String? moduleId, @JsonKey(name: 'session_id')  String? sessionId)?  $default,) {final _that = this;
switch (_that) {
case _NewPlannerEntry() when $default != null:
return $default(_that.date,_that.title,_that.priority,_that.moduleId,_that.sessionId);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _NewPlannerEntry implements NewPlannerEntry {
   _NewPlannerEntry({required this.date, required this.title, required this.priority, @JsonKey(name: 'module_id') this.moduleId, @JsonKey(name: 'session_id') this.sessionId});
  factory _NewPlannerEntry.fromJson(Map<String, dynamic> json) => _$NewPlannerEntryFromJson(json);

@override final  String date;
@override final  String title;
@override final  int priority;
@override@JsonKey(name: 'module_id') final  String? moduleId;
@override@JsonKey(name: 'session_id') final  String? sessionId;

/// Create a copy of NewPlannerEntry
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$NewPlannerEntryCopyWith<_NewPlannerEntry> get copyWith => __$NewPlannerEntryCopyWithImpl<_NewPlannerEntry>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$NewPlannerEntryToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _NewPlannerEntry&&(identical(other.date, date) || other.date == date)&&(identical(other.title, title) || other.title == title)&&(identical(other.priority, priority) || other.priority == priority)&&(identical(other.moduleId, moduleId) || other.moduleId == moduleId)&&(identical(other.sessionId, sessionId) || other.sessionId == sessionId));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,date,title,priority,moduleId,sessionId);

@override
String toString() {
  return 'NewPlannerEntry(date: $date, title: $title, priority: $priority, moduleId: $moduleId, sessionId: $sessionId)';
}


}

/// @nodoc
abstract mixin class _$NewPlannerEntryCopyWith<$Res> implements $NewPlannerEntryCopyWith<$Res> {
  factory _$NewPlannerEntryCopyWith(_NewPlannerEntry value, $Res Function(_NewPlannerEntry) _then) = __$NewPlannerEntryCopyWithImpl;
@override @useResult
$Res call({
 String date, String title, int priority,@JsonKey(name: 'module_id') String? moduleId,@JsonKey(name: 'session_id') String? sessionId
});




}
/// @nodoc
class __$NewPlannerEntryCopyWithImpl<$Res>
    implements _$NewPlannerEntryCopyWith<$Res> {
  __$NewPlannerEntryCopyWithImpl(this._self, this._then);

  final _NewPlannerEntry _self;
  final $Res Function(_NewPlannerEntry) _then;

/// Create a copy of NewPlannerEntry
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? date = null,Object? title = null,Object? priority = null,Object? moduleId = freezed,Object? sessionId = freezed,}) {
  return _then(_NewPlannerEntry(
date: null == date ? _self.date : date // ignore: cast_nullable_to_non_nullable
as String,title: null == title ? _self.title : title // ignore: cast_nullable_to_non_nullable
as String,priority: null == priority ? _self.priority : priority // ignore: cast_nullable_to_non_nullable
as int,moduleId: freezed == moduleId ? _self.moduleId : moduleId // ignore: cast_nullable_to_non_nullable
as String?,sessionId: freezed == sessionId ? _self.sessionId : sessionId // ignore: cast_nullable_to_non_nullable
as String?,
  ));
}


}

// dart format on
