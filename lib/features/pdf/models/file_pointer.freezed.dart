// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'file_pointer.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;
/// @nodoc
mixin _$FilePointer {

 String get file_id; String get path;
/// Create a copy of FilePointer
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$FilePointerCopyWith<FilePointer> get copyWith => _$FilePointerCopyWithImpl<FilePointer>(this as FilePointer, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is FilePointer&&(identical(other.file_id, file_id) || other.file_id == file_id)&&(identical(other.path, path) || other.path == path));
}


@override
int get hashCode => Object.hash(runtimeType,file_id,path);

@override
String toString() {
  return 'FilePointer(file_id: $file_id, path: $path)';
}


}

/// @nodoc
abstract mixin class $FilePointerCopyWith<$Res>  {
  factory $FilePointerCopyWith(FilePointer value, $Res Function(FilePointer) _then) = _$FilePointerCopyWithImpl;
@useResult
$Res call({
 String file_id, String path
});




}
/// @nodoc
class _$FilePointerCopyWithImpl<$Res>
    implements $FilePointerCopyWith<$Res> {
  _$FilePointerCopyWithImpl(this._self, this._then);

  final FilePointer _self;
  final $Res Function(FilePointer) _then;

/// Create a copy of FilePointer
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? file_id = null,Object? path = null,}) {
  return _then(_self.copyWith(
file_id: null == file_id ? _self.file_id : file_id // ignore: cast_nullable_to_non_nullable
as String,path: null == path ? _self.path : path // ignore: cast_nullable_to_non_nullable
as String,
  ));
}

}


/// Adds pattern-matching-related methods to [FilePointer].
extension FilePointerPatterns on FilePointer {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _FilePointer value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _FilePointer() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _FilePointer value)  $default,){
final _that = this;
switch (_that) {
case _FilePointer():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _FilePointer value)?  $default,){
final _that = this;
switch (_that) {
case _FilePointer() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( String file_id,  String path)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _FilePointer() when $default != null:
return $default(_that.file_id,_that.path);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( String file_id,  String path)  $default,) {final _that = this;
switch (_that) {
case _FilePointer():
return $default(_that.file_id,_that.path);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( String file_id,  String path)?  $default,) {final _that = this;
switch (_that) {
case _FilePointer() when $default != null:
return $default(_that.file_id,_that.path);case _:
  return null;

}
}

}

/// @nodoc


class _FilePointer implements FilePointer {
  const _FilePointer({required this.file_id, required this.path});
  

@override final  String file_id;
@override final  String path;

/// Create a copy of FilePointer
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$FilePointerCopyWith<_FilePointer> get copyWith => __$FilePointerCopyWithImpl<_FilePointer>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _FilePointer&&(identical(other.file_id, file_id) || other.file_id == file_id)&&(identical(other.path, path) || other.path == path));
}


@override
int get hashCode => Object.hash(runtimeType,file_id,path);

@override
String toString() {
  return 'FilePointer(file_id: $file_id, path: $path)';
}


}

/// @nodoc
abstract mixin class _$FilePointerCopyWith<$Res> implements $FilePointerCopyWith<$Res> {
  factory _$FilePointerCopyWith(_FilePointer value, $Res Function(_FilePointer) _then) = __$FilePointerCopyWithImpl;
@override @useResult
$Res call({
 String file_id, String path
});




}
/// @nodoc
class __$FilePointerCopyWithImpl<$Res>
    implements _$FilePointerCopyWith<$Res> {
  __$FilePointerCopyWithImpl(this._self, this._then);

  final _FilePointer _self;
  final $Res Function(_FilePointer) _then;

/// Create a copy of FilePointer
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? file_id = null,Object? path = null,}) {
  return _then(_FilePointer(
file_id: null == file_id ? _self.file_id : file_id // ignore: cast_nullable_to_non_nullable
as String,path: null == path ? _self.path : path // ignore: cast_nullable_to_non_nullable
as String,
  ));
}


}

// dart format on
