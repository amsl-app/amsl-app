// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'module_milestone.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;
/// @nodoc
mixin _$ModuleMilestone {

 String get id; String get title; DateTime get date; bool get alreadyImported; String? get description;
/// Create a copy of ModuleMilestone
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$ModuleMilestoneCopyWith<ModuleMilestone> get copyWith => _$ModuleMilestoneCopyWithImpl<ModuleMilestone>(this as ModuleMilestone, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is ModuleMilestone&&(identical(other.id, id) || other.id == id)&&(identical(other.title, title) || other.title == title)&&(identical(other.date, date) || other.date == date)&&(identical(other.alreadyImported, alreadyImported) || other.alreadyImported == alreadyImported)&&(identical(other.description, description) || other.description == description));
}


@override
int get hashCode => Object.hash(runtimeType,id,title,date,alreadyImported,description);

@override
String toString() {
  return 'ModuleMilestone(id: $id, title: $title, date: $date, alreadyImported: $alreadyImported, description: $description)';
}


}

/// @nodoc
abstract mixin class $ModuleMilestoneCopyWith<$Res>  {
  factory $ModuleMilestoneCopyWith(ModuleMilestone value, $Res Function(ModuleMilestone) _then) = _$ModuleMilestoneCopyWithImpl;
@useResult
$Res call({
 String id, String title, DateTime date, bool alreadyImported, String? description
});




}
/// @nodoc
class _$ModuleMilestoneCopyWithImpl<$Res>
    implements $ModuleMilestoneCopyWith<$Res> {
  _$ModuleMilestoneCopyWithImpl(this._self, this._then);

  final ModuleMilestone _self;
  final $Res Function(ModuleMilestone) _then;

/// Create a copy of ModuleMilestone
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? id = null,Object? title = null,Object? date = null,Object? alreadyImported = null,Object? description = freezed,}) {
  return _then(_self.copyWith(
id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as String,title: null == title ? _self.title : title // ignore: cast_nullable_to_non_nullable
as String,date: null == date ? _self.date : date // ignore: cast_nullable_to_non_nullable
as DateTime,alreadyImported: null == alreadyImported ? _self.alreadyImported : alreadyImported // ignore: cast_nullable_to_non_nullable
as bool,description: freezed == description ? _self.description : description // ignore: cast_nullable_to_non_nullable
as String?,
  ));
}

}


/// Adds pattern-matching-related methods to [ModuleMilestone].
extension ModuleMilestonePatterns on ModuleMilestone {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _ModuleMilestone value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _ModuleMilestone() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _ModuleMilestone value)  $default,){
final _that = this;
switch (_that) {
case _ModuleMilestone():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _ModuleMilestone value)?  $default,){
final _that = this;
switch (_that) {
case _ModuleMilestone() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( String id,  String title,  DateTime date,  bool alreadyImported,  String? description)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _ModuleMilestone() when $default != null:
return $default(_that.id,_that.title,_that.date,_that.alreadyImported,_that.description);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( String id,  String title,  DateTime date,  bool alreadyImported,  String? description)  $default,) {final _that = this;
switch (_that) {
case _ModuleMilestone():
return $default(_that.id,_that.title,_that.date,_that.alreadyImported,_that.description);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( String id,  String title,  DateTime date,  bool alreadyImported,  String? description)?  $default,) {final _that = this;
switch (_that) {
case _ModuleMilestone() when $default != null:
return $default(_that.id,_that.title,_that.date,_that.alreadyImported,_that.description);case _:
  return null;

}
}

}

/// @nodoc


class _ModuleMilestone extends ModuleMilestone {
  const _ModuleMilestone({required this.id, required this.title, required this.date, required this.alreadyImported, this.description}): super._();
  

@override final  String id;
@override final  String title;
@override final  DateTime date;
@override final  bool alreadyImported;
@override final  String? description;

/// Create a copy of ModuleMilestone
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$ModuleMilestoneCopyWith<_ModuleMilestone> get copyWith => __$ModuleMilestoneCopyWithImpl<_ModuleMilestone>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _ModuleMilestone&&(identical(other.id, id) || other.id == id)&&(identical(other.title, title) || other.title == title)&&(identical(other.date, date) || other.date == date)&&(identical(other.alreadyImported, alreadyImported) || other.alreadyImported == alreadyImported)&&(identical(other.description, description) || other.description == description));
}


@override
int get hashCode => Object.hash(runtimeType,id,title,date,alreadyImported,description);

@override
String toString() {
  return 'ModuleMilestone(id: $id, title: $title, date: $date, alreadyImported: $alreadyImported, description: $description)';
}


}

/// @nodoc
abstract mixin class _$ModuleMilestoneCopyWith<$Res> implements $ModuleMilestoneCopyWith<$Res> {
  factory _$ModuleMilestoneCopyWith(_ModuleMilestone value, $Res Function(_ModuleMilestone) _then) = __$ModuleMilestoneCopyWithImpl;
@override @useResult
$Res call({
 String id, String title, DateTime date, bool alreadyImported, String? description
});




}
/// @nodoc
class __$ModuleMilestoneCopyWithImpl<$Res>
    implements _$ModuleMilestoneCopyWith<$Res> {
  __$ModuleMilestoneCopyWithImpl(this._self, this._then);

  final _ModuleMilestone _self;
  final $Res Function(_ModuleMilestone) _then;

/// Create a copy of ModuleMilestone
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? id = null,Object? title = null,Object? date = null,Object? alreadyImported = null,Object? description = freezed,}) {
  return _then(_ModuleMilestone(
id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as String,title: null == title ? _self.title : title // ignore: cast_nullable_to_non_nullable
as String,date: null == date ? _self.date : date // ignore: cast_nullable_to_non_nullable
as DateTime,alreadyImported: null == alreadyImported ? _self.alreadyImported : alreadyImported // ignore: cast_nullable_to_non_nullable
as bool,description: freezed == description ? _self.description : description // ignore: cast_nullable_to_non_nullable
as String?,
  ));
}


}

// dart format on
