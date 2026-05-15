// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'journal_content.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;

/// @nodoc
mixin _$JournalContent {

 String? get content; String? get title;@JsonKey(name: 'created_at') DateTime get created;@JsonKey(name: 'updated_at') DateTime get updated; String get id;@JsonKey(name: 'journal_entry_id') String get journalEntryId;
/// Create a copy of JournalContent
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$JournalContentCopyWith<JournalContent> get copyWith => _$JournalContentCopyWithImpl<JournalContent>(this as JournalContent, _$identity);

  /// Serializes this JournalContent to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is JournalContent&&(identical(other.content, content) || other.content == content)&&(identical(other.title, title) || other.title == title)&&(identical(other.created, created) || other.created == created)&&(identical(other.updated, updated) || other.updated == updated)&&(identical(other.id, id) || other.id == id)&&(identical(other.journalEntryId, journalEntryId) || other.journalEntryId == journalEntryId));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,content,title,created,updated,id,journalEntryId);

@override
String toString() {
  return 'JournalContent(content: $content, title: $title, created: $created, updated: $updated, id: $id, journalEntryId: $journalEntryId)';
}


}

/// @nodoc
abstract mixin class $JournalContentCopyWith<$Res>  {
  factory $JournalContentCopyWith(JournalContent value, $Res Function(JournalContent) _then) = _$JournalContentCopyWithImpl;
@useResult
$Res call({
 String? content, String? title,@JsonKey(name: 'created_at') DateTime created,@JsonKey(name: 'updated_at') DateTime updated, String id,@JsonKey(name: 'journal_entry_id') String journalEntryId
});




}
/// @nodoc
class _$JournalContentCopyWithImpl<$Res>
    implements $JournalContentCopyWith<$Res> {
  _$JournalContentCopyWithImpl(this._self, this._then);

  final JournalContent _self;
  final $Res Function(JournalContent) _then;

/// Create a copy of JournalContent
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? content = freezed,Object? title = freezed,Object? created = null,Object? updated = null,Object? id = null,Object? journalEntryId = null,}) {
  return _then(_self.copyWith(
content: freezed == content ? _self.content : content // ignore: cast_nullable_to_non_nullable
as String?,title: freezed == title ? _self.title : title // ignore: cast_nullable_to_non_nullable
as String?,created: null == created ? _self.created : created // ignore: cast_nullable_to_non_nullable
as DateTime,updated: null == updated ? _self.updated : updated // ignore: cast_nullable_to_non_nullable
as DateTime,id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as String,journalEntryId: null == journalEntryId ? _self.journalEntryId : journalEntryId // ignore: cast_nullable_to_non_nullable
as String,
  ));
}

}


/// Adds pattern-matching-related methods to [JournalContent].
extension JournalContentPatterns on JournalContent {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _JournalContent value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _JournalContent() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _JournalContent value)  $default,){
final _that = this;
switch (_that) {
case _JournalContent():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _JournalContent value)?  $default,){
final _that = this;
switch (_that) {
case _JournalContent() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( String? content,  String? title, @JsonKey(name: 'created_at')  DateTime created, @JsonKey(name: 'updated_at')  DateTime updated,  String id, @JsonKey(name: 'journal_entry_id')  String journalEntryId)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _JournalContent() when $default != null:
return $default(_that.content,_that.title,_that.created,_that.updated,_that.id,_that.journalEntryId);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( String? content,  String? title, @JsonKey(name: 'created_at')  DateTime created, @JsonKey(name: 'updated_at')  DateTime updated,  String id, @JsonKey(name: 'journal_entry_id')  String journalEntryId)  $default,) {final _that = this;
switch (_that) {
case _JournalContent():
return $default(_that.content,_that.title,_that.created,_that.updated,_that.id,_that.journalEntryId);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( String? content,  String? title, @JsonKey(name: 'created_at')  DateTime created, @JsonKey(name: 'updated_at')  DateTime updated,  String id, @JsonKey(name: 'journal_entry_id')  String journalEntryId)?  $default,) {final _that = this;
switch (_that) {
case _JournalContent() when $default != null:
return $default(_that.content,_that.title,_that.created,_that.updated,_that.id,_that.journalEntryId);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _JournalContent implements JournalContent {
   _JournalContent({this.content, this.title, @JsonKey(name: 'created_at') required this.created, @JsonKey(name: 'updated_at') required this.updated, required this.id, @JsonKey(name: 'journal_entry_id') required this.journalEntryId});
  factory _JournalContent.fromJson(Map<String, dynamic> json) => _$JournalContentFromJson(json);

@override final  String? content;
@override final  String? title;
@override@JsonKey(name: 'created_at') final  DateTime created;
@override@JsonKey(name: 'updated_at') final  DateTime updated;
@override final  String id;
@override@JsonKey(name: 'journal_entry_id') final  String journalEntryId;

/// Create a copy of JournalContent
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$JournalContentCopyWith<_JournalContent> get copyWith => __$JournalContentCopyWithImpl<_JournalContent>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$JournalContentToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _JournalContent&&(identical(other.content, content) || other.content == content)&&(identical(other.title, title) || other.title == title)&&(identical(other.created, created) || other.created == created)&&(identical(other.updated, updated) || other.updated == updated)&&(identical(other.id, id) || other.id == id)&&(identical(other.journalEntryId, journalEntryId) || other.journalEntryId == journalEntryId));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,content,title,created,updated,id,journalEntryId);

@override
String toString() {
  return 'JournalContent(content: $content, title: $title, created: $created, updated: $updated, id: $id, journalEntryId: $journalEntryId)';
}


}

/// @nodoc
abstract mixin class _$JournalContentCopyWith<$Res> implements $JournalContentCopyWith<$Res> {
  factory _$JournalContentCopyWith(_JournalContent value, $Res Function(_JournalContent) _then) = __$JournalContentCopyWithImpl;
@override @useResult
$Res call({
 String? content, String? title,@JsonKey(name: 'created_at') DateTime created,@JsonKey(name: 'updated_at') DateTime updated, String id,@JsonKey(name: 'journal_entry_id') String journalEntryId
});




}
/// @nodoc
class __$JournalContentCopyWithImpl<$Res>
    implements _$JournalContentCopyWith<$Res> {
  __$JournalContentCopyWithImpl(this._self, this._then);

  final _JournalContent _self;
  final $Res Function(_JournalContent) _then;

/// Create a copy of JournalContent
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? content = freezed,Object? title = freezed,Object? created = null,Object? updated = null,Object? id = null,Object? journalEntryId = null,}) {
  return _then(_JournalContent(
content: freezed == content ? _self.content : content // ignore: cast_nullable_to_non_nullable
as String?,title: freezed == title ? _self.title : title // ignore: cast_nullable_to_non_nullable
as String?,created: null == created ? _self.created : created // ignore: cast_nullable_to_non_nullable
as DateTime,updated: null == updated ? _self.updated : updated // ignore: cast_nullable_to_non_nullable
as DateTime,id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as String,journalEntryId: null == journalEntryId ? _self.journalEntryId : journalEntryId // ignore: cast_nullable_to_non_nullable
as String,
  ));
}


}

// dart format on
