// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'journal_focus.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;
/// @nodoc
mixin _$JournalFocus {

 String get id; String get name; String get iconString; bool get hidden; String? get userId;
/// Create a copy of JournalFocus
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$JournalFocusCopyWith<JournalFocus> get copyWith => _$JournalFocusCopyWithImpl<JournalFocus>(this as JournalFocus, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is JournalFocus&&(identical(other.id, id) || other.id == id)&&(identical(other.name, name) || other.name == name)&&(identical(other.iconString, iconString) || other.iconString == iconString)&&(identical(other.hidden, hidden) || other.hidden == hidden)&&(identical(other.userId, userId) || other.userId == userId));
}


@override
int get hashCode => Object.hash(runtimeType,id,name,iconString,hidden,userId);

@override
String toString() {
  return 'JournalFocus(id: $id, name: $name, iconString: $iconString, hidden: $hidden, userId: $userId)';
}


}

/// @nodoc
abstract mixin class $JournalFocusCopyWith<$Res>  {
  factory $JournalFocusCopyWith(JournalFocus value, $Res Function(JournalFocus) _then) = _$JournalFocusCopyWithImpl;
@useResult
$Res call({
 String id, String name, String iconString, bool hidden, String? userId
});




}
/// @nodoc
class _$JournalFocusCopyWithImpl<$Res>
    implements $JournalFocusCopyWith<$Res> {
  _$JournalFocusCopyWithImpl(this._self, this._then);

  final JournalFocus _self;
  final $Res Function(JournalFocus) _then;

/// Create a copy of JournalFocus
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? id = null,Object? name = null,Object? iconString = null,Object? hidden = null,Object? userId = freezed,}) {
  return _then(_self.copyWith(
id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as String,name: null == name ? _self.name : name // ignore: cast_nullable_to_non_nullable
as String,iconString: null == iconString ? _self.iconString : iconString // ignore: cast_nullable_to_non_nullable
as String,hidden: null == hidden ? _self.hidden : hidden // ignore: cast_nullable_to_non_nullable
as bool,userId: freezed == userId ? _self.userId : userId // ignore: cast_nullable_to_non_nullable
as String?,
  ));
}

}


/// Adds pattern-matching-related methods to [JournalFocus].
extension JournalFocusPatterns on JournalFocus {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _JournalFocus value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _JournalFocus() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _JournalFocus value)  $default,){
final _that = this;
switch (_that) {
case _JournalFocus():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _JournalFocus value)?  $default,){
final _that = this;
switch (_that) {
case _JournalFocus() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( String id,  String name,  String iconString,  bool hidden,  String? userId)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _JournalFocus() when $default != null:
return $default(_that.id,_that.name,_that.iconString,_that.hidden,_that.userId);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( String id,  String name,  String iconString,  bool hidden,  String? userId)  $default,) {final _that = this;
switch (_that) {
case _JournalFocus():
return $default(_that.id,_that.name,_that.iconString,_that.hidden,_that.userId);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( String id,  String name,  String iconString,  bool hidden,  String? userId)?  $default,) {final _that = this;
switch (_that) {
case _JournalFocus() when $default != null:
return $default(_that.id,_that.name,_that.iconString,_that.hidden,_that.userId);case _:
  return null;

}
}

}

/// @nodoc


class _JournalFocus extends JournalFocus {
  const _JournalFocus({required this.id, required this.name, required this.iconString, this.hidden = false, this.userId}): super._();
  

@override final  String id;
@override final  String name;
@override final  String iconString;
@override@JsonKey() final  bool hidden;
@override final  String? userId;

/// Create a copy of JournalFocus
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$JournalFocusCopyWith<_JournalFocus> get copyWith => __$JournalFocusCopyWithImpl<_JournalFocus>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _JournalFocus&&(identical(other.id, id) || other.id == id)&&(identical(other.name, name) || other.name == name)&&(identical(other.iconString, iconString) || other.iconString == iconString)&&(identical(other.hidden, hidden) || other.hidden == hidden)&&(identical(other.userId, userId) || other.userId == userId));
}


@override
int get hashCode => Object.hash(runtimeType,id,name,iconString,hidden,userId);

@override
String toString() {
  return 'JournalFocus(id: $id, name: $name, iconString: $iconString, hidden: $hidden, userId: $userId)';
}


}

/// @nodoc
abstract mixin class _$JournalFocusCopyWith<$Res> implements $JournalFocusCopyWith<$Res> {
  factory _$JournalFocusCopyWith(_JournalFocus value, $Res Function(_JournalFocus) _then) = __$JournalFocusCopyWithImpl;
@override @useResult
$Res call({
 String id, String name, String iconString, bool hidden, String? userId
});




}
/// @nodoc
class __$JournalFocusCopyWithImpl<$Res>
    implements _$JournalFocusCopyWith<$Res> {
  __$JournalFocusCopyWithImpl(this._self, this._then);

  final _JournalFocus _self;
  final $Res Function(_JournalFocus) _then;

/// Create a copy of JournalFocus
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? id = null,Object? name = null,Object? iconString = null,Object? hidden = null,Object? userId = freezed,}) {
  return _then(_JournalFocus(
id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as String,name: null == name ? _self.name : name // ignore: cast_nullable_to_non_nullable
as String,iconString: null == iconString ? _self.iconString : iconString // ignore: cast_nullable_to_non_nullable
as String,hidden: null == hidden ? _self.hidden : hidden // ignore: cast_nullable_to_non_nullable
as bool,userId: freezed == userId ? _self.userId : userId // ignore: cast_nullable_to_non_nullable
as String?,
  ));
}


}

// dart format on
