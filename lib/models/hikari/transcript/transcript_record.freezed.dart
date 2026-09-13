// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'transcript_record.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;

/// @nodoc
mixin _$TranscriptRecord {

 String get id; String get title; String get description; bool get unlocked; List<TranscriptRequirement> get requirements;
/// Create a copy of TranscriptRecord
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$TranscriptRecordCopyWith<TranscriptRecord> get copyWith => _$TranscriptRecordCopyWithImpl<TranscriptRecord>(this as TranscriptRecord, _$identity);

  /// Serializes this TranscriptRecord to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is TranscriptRecord&&(identical(other.id, id) || other.id == id)&&(identical(other.title, title) || other.title == title)&&(identical(other.description, description) || other.description == description)&&(identical(other.unlocked, unlocked) || other.unlocked == unlocked)&&const DeepCollectionEquality().equals(other.requirements, requirements));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,id,title,description,unlocked,const DeepCollectionEquality().hash(requirements));

@override
String toString() {
  return 'TranscriptRecord(id: $id, title: $title, description: $description, unlocked: $unlocked, requirements: $requirements)';
}


}

/// @nodoc
abstract mixin class $TranscriptRecordCopyWith<$Res>  {
  factory $TranscriptRecordCopyWith(TranscriptRecord value, $Res Function(TranscriptRecord) _then) = _$TranscriptRecordCopyWithImpl;
@useResult
$Res call({
 String id, String title, String description, bool unlocked, List<TranscriptRequirement> requirements
});




}
/// @nodoc
class _$TranscriptRecordCopyWithImpl<$Res>
    implements $TranscriptRecordCopyWith<$Res> {
  _$TranscriptRecordCopyWithImpl(this._self, this._then);

  final TranscriptRecord _self;
  final $Res Function(TranscriptRecord) _then;

/// Create a copy of TranscriptRecord
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? id = null,Object? title = null,Object? description = null,Object? unlocked = null,Object? requirements = null,}) {
  return _then(_self.copyWith(
id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as String,title: null == title ? _self.title : title // ignore: cast_nullable_to_non_nullable
as String,description: null == description ? _self.description : description // ignore: cast_nullable_to_non_nullable
as String,unlocked: null == unlocked ? _self.unlocked : unlocked // ignore: cast_nullable_to_non_nullable
as bool,requirements: null == requirements ? _self.requirements : requirements // ignore: cast_nullable_to_non_nullable
as List<TranscriptRequirement>,
  ));
}

}


/// Adds pattern-matching-related methods to [TranscriptRecord].
extension TranscriptRecordPatterns on TranscriptRecord {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _TranscriptRecord value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _TranscriptRecord() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _TranscriptRecord value)  $default,){
final _that = this;
switch (_that) {
case _TranscriptRecord():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _TranscriptRecord value)?  $default,){
final _that = this;
switch (_that) {
case _TranscriptRecord() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( String id,  String title,  String description,  bool unlocked,  List<TranscriptRequirement> requirements)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _TranscriptRecord() when $default != null:
return $default(_that.id,_that.title,_that.description,_that.unlocked,_that.requirements);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( String id,  String title,  String description,  bool unlocked,  List<TranscriptRequirement> requirements)  $default,) {final _that = this;
switch (_that) {
case _TranscriptRecord():
return $default(_that.id,_that.title,_that.description,_that.unlocked,_that.requirements);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( String id,  String title,  String description,  bool unlocked,  List<TranscriptRequirement> requirements)?  $default,) {final _that = this;
switch (_that) {
case _TranscriptRecord() when $default != null:
return $default(_that.id,_that.title,_that.description,_that.unlocked,_that.requirements);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _TranscriptRecord implements TranscriptRecord {
   _TranscriptRecord({required this.id, required this.title, required this.description, required this.unlocked, required final  List<TranscriptRequirement> requirements}): _requirements = requirements;
  factory _TranscriptRecord.fromJson(Map<String, dynamic> json) => _$TranscriptRecordFromJson(json);

@override final  String id;
@override final  String title;
@override final  String description;
@override final  bool unlocked;
 final  List<TranscriptRequirement> _requirements;
@override List<TranscriptRequirement> get requirements {
  if (_requirements is EqualUnmodifiableListView) return _requirements;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(_requirements);
}


/// Create a copy of TranscriptRecord
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$TranscriptRecordCopyWith<_TranscriptRecord> get copyWith => __$TranscriptRecordCopyWithImpl<_TranscriptRecord>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$TranscriptRecordToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _TranscriptRecord&&(identical(other.id, id) || other.id == id)&&(identical(other.title, title) || other.title == title)&&(identical(other.description, description) || other.description == description)&&(identical(other.unlocked, unlocked) || other.unlocked == unlocked)&&const DeepCollectionEquality().equals(other._requirements, _requirements));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,id,title,description,unlocked,const DeepCollectionEquality().hash(_requirements));

@override
String toString() {
  return 'TranscriptRecord(id: $id, title: $title, description: $description, unlocked: $unlocked, requirements: $requirements)';
}


}

/// @nodoc
abstract mixin class _$TranscriptRecordCopyWith<$Res> implements $TranscriptRecordCopyWith<$Res> {
  factory _$TranscriptRecordCopyWith(_TranscriptRecord value, $Res Function(_TranscriptRecord) _then) = __$TranscriptRecordCopyWithImpl;
@override @useResult
$Res call({
 String id, String title, String description, bool unlocked, List<TranscriptRequirement> requirements
});




}
/// @nodoc
class __$TranscriptRecordCopyWithImpl<$Res>
    implements _$TranscriptRecordCopyWith<$Res> {
  __$TranscriptRecordCopyWithImpl(this._self, this._then);

  final _TranscriptRecord _self;
  final $Res Function(_TranscriptRecord) _then;

/// Create a copy of TranscriptRecord
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? id = null,Object? title = null,Object? description = null,Object? unlocked = null,Object? requirements = null,}) {
  return _then(_TranscriptRecord(
id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as String,title: null == title ? _self.title : title // ignore: cast_nullable_to_non_nullable
as String,description: null == description ? _self.description : description // ignore: cast_nullable_to_non_nullable
as String,unlocked: null == unlocked ? _self.unlocked : unlocked // ignore: cast_nullable_to_non_nullable
as bool,requirements: null == requirements ? _self._requirements : requirements // ignore: cast_nullable_to_non_nullable
as List<TranscriptRequirement>,
  ));
}


}


/// @nodoc
mixin _$TranscriptRequirement {

 String get label; bool get met;
/// Create a copy of TranscriptRequirement
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$TranscriptRequirementCopyWith<TranscriptRequirement> get copyWith => _$TranscriptRequirementCopyWithImpl<TranscriptRequirement>(this as TranscriptRequirement, _$identity);

  /// Serializes this TranscriptRequirement to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is TranscriptRequirement&&(identical(other.label, label) || other.label == label)&&(identical(other.met, met) || other.met == met));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,label,met);

@override
String toString() {
  return 'TranscriptRequirement(label: $label, met: $met)';
}


}

/// @nodoc
abstract mixin class $TranscriptRequirementCopyWith<$Res>  {
  factory $TranscriptRequirementCopyWith(TranscriptRequirement value, $Res Function(TranscriptRequirement) _then) = _$TranscriptRequirementCopyWithImpl;
@useResult
$Res call({
 String label, bool met
});




}
/// @nodoc
class _$TranscriptRequirementCopyWithImpl<$Res>
    implements $TranscriptRequirementCopyWith<$Res> {
  _$TranscriptRequirementCopyWithImpl(this._self, this._then);

  final TranscriptRequirement _self;
  final $Res Function(TranscriptRequirement) _then;

/// Create a copy of TranscriptRequirement
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? label = null,Object? met = null,}) {
  return _then(_self.copyWith(
label: null == label ? _self.label : label // ignore: cast_nullable_to_non_nullable
as String,met: null == met ? _self.met : met // ignore: cast_nullable_to_non_nullable
as bool,
  ));
}

}


/// Adds pattern-matching-related methods to [TranscriptRequirement].
extension TranscriptRequirementPatterns on TranscriptRequirement {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _TranscriptRequirement value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _TranscriptRequirement() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _TranscriptRequirement value)  $default,){
final _that = this;
switch (_that) {
case _TranscriptRequirement():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _TranscriptRequirement value)?  $default,){
final _that = this;
switch (_that) {
case _TranscriptRequirement() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( String label,  bool met)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _TranscriptRequirement() when $default != null:
return $default(_that.label,_that.met);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( String label,  bool met)  $default,) {final _that = this;
switch (_that) {
case _TranscriptRequirement():
return $default(_that.label,_that.met);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( String label,  bool met)?  $default,) {final _that = this;
switch (_that) {
case _TranscriptRequirement() when $default != null:
return $default(_that.label,_that.met);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _TranscriptRequirement implements TranscriptRequirement {
   _TranscriptRequirement({required this.label, required this.met});
  factory _TranscriptRequirement.fromJson(Map<String, dynamic> json) => _$TranscriptRequirementFromJson(json);

@override final  String label;
@override final  bool met;

/// Create a copy of TranscriptRequirement
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$TranscriptRequirementCopyWith<_TranscriptRequirement> get copyWith => __$TranscriptRequirementCopyWithImpl<_TranscriptRequirement>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$TranscriptRequirementToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _TranscriptRequirement&&(identical(other.label, label) || other.label == label)&&(identical(other.met, met) || other.met == met));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,label,met);

@override
String toString() {
  return 'TranscriptRequirement(label: $label, met: $met)';
}


}

/// @nodoc
abstract mixin class _$TranscriptRequirementCopyWith<$Res> implements $TranscriptRequirementCopyWith<$Res> {
  factory _$TranscriptRequirementCopyWith(_TranscriptRequirement value, $Res Function(_TranscriptRequirement) _then) = __$TranscriptRequirementCopyWithImpl;
@override @useResult
$Res call({
 String label, bool met
});




}
/// @nodoc
class __$TranscriptRequirementCopyWithImpl<$Res>
    implements _$TranscriptRequirementCopyWith<$Res> {
  __$TranscriptRequirementCopyWithImpl(this._self, this._then);

  final _TranscriptRequirement _self;
  final $Res Function(_TranscriptRequirement) _then;

/// Create a copy of TranscriptRequirement
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? label = null,Object? met = null,}) {
  return _then(_TranscriptRequirement(
label: null == label ? _self.label : label // ignore: cast_nullable_to_non_nullable
as String,met: null == met ? _self.met : met // ignore: cast_nullable_to_non_nullable
as bool,
  ));
}


}

// dart format on
