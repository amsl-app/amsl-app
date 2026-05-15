// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'preferences.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;
/// @nodoc
mixin _$PreferencesState implements DiagnosticableTreeMixin {

 bool get trackingPermission; bool get crashReportingPermission; TimeOfDay get notificationTime; bool get notificationEnabled; bool get sessionLockNotificationEnabled; bool? get activateClickableSession; String? get templateCourse; bool? get showRestartInCourse; bool? get statusBarDisabled;
/// Create a copy of PreferencesState
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$PreferencesStateCopyWith<PreferencesState> get copyWith => _$PreferencesStateCopyWithImpl<PreferencesState>(this as PreferencesState, _$identity);


@override
void debugFillProperties(DiagnosticPropertiesBuilder properties) {
  properties
    ..add(DiagnosticsProperty('type', 'PreferencesState'))
    ..add(DiagnosticsProperty('trackingPermission', trackingPermission))..add(DiagnosticsProperty('crashReportingPermission', crashReportingPermission))..add(DiagnosticsProperty('notificationTime', notificationTime))..add(DiagnosticsProperty('notificationEnabled', notificationEnabled))..add(DiagnosticsProperty('sessionLockNotificationEnabled', sessionLockNotificationEnabled))..add(DiagnosticsProperty('activateClickableSession', activateClickableSession))..add(DiagnosticsProperty('templateCourse', templateCourse))..add(DiagnosticsProperty('showRestartInCourse', showRestartInCourse))..add(DiagnosticsProperty('statusBarDisabled', statusBarDisabled));
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is PreferencesState&&(identical(other.trackingPermission, trackingPermission) || other.trackingPermission == trackingPermission)&&(identical(other.crashReportingPermission, crashReportingPermission) || other.crashReportingPermission == crashReportingPermission)&&(identical(other.notificationTime, notificationTime) || other.notificationTime == notificationTime)&&(identical(other.notificationEnabled, notificationEnabled) || other.notificationEnabled == notificationEnabled)&&(identical(other.sessionLockNotificationEnabled, sessionLockNotificationEnabled) || other.sessionLockNotificationEnabled == sessionLockNotificationEnabled)&&(identical(other.activateClickableSession, activateClickableSession) || other.activateClickableSession == activateClickableSession)&&(identical(other.templateCourse, templateCourse) || other.templateCourse == templateCourse)&&(identical(other.showRestartInCourse, showRestartInCourse) || other.showRestartInCourse == showRestartInCourse)&&(identical(other.statusBarDisabled, statusBarDisabled) || other.statusBarDisabled == statusBarDisabled));
}


@override
int get hashCode => Object.hash(runtimeType,trackingPermission,crashReportingPermission,notificationTime,notificationEnabled,sessionLockNotificationEnabled,activateClickableSession,templateCourse,showRestartInCourse,statusBarDisabled);

@override
String toString({ DiagnosticLevel minLevel = DiagnosticLevel.info }) {
  return 'PreferencesState(trackingPermission: $trackingPermission, crashReportingPermission: $crashReportingPermission, notificationTime: $notificationTime, notificationEnabled: $notificationEnabled, sessionLockNotificationEnabled: $sessionLockNotificationEnabled, activateClickableSession: $activateClickableSession, templateCourse: $templateCourse, showRestartInCourse: $showRestartInCourse, statusBarDisabled: $statusBarDisabled)';
}


}

/// @nodoc
abstract mixin class $PreferencesStateCopyWith<$Res>  {
  factory $PreferencesStateCopyWith(PreferencesState value, $Res Function(PreferencesState) _then) = _$PreferencesStateCopyWithImpl;
@useResult
$Res call({
 bool trackingPermission, bool crashReportingPermission, TimeOfDay notificationTime, bool notificationEnabled, bool sessionLockNotificationEnabled, bool? activateClickableSession, String? templateCourse, bool? showRestartInCourse, bool? statusBarDisabled
});




}
/// @nodoc
class _$PreferencesStateCopyWithImpl<$Res>
    implements $PreferencesStateCopyWith<$Res> {
  _$PreferencesStateCopyWithImpl(this._self, this._then);

  final PreferencesState _self;
  final $Res Function(PreferencesState) _then;

/// Create a copy of PreferencesState
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? trackingPermission = null,Object? crashReportingPermission = null,Object? notificationTime = null,Object? notificationEnabled = null,Object? sessionLockNotificationEnabled = null,Object? activateClickableSession = freezed,Object? templateCourse = freezed,Object? showRestartInCourse = freezed,Object? statusBarDisabled = freezed,}) {
  return _then(_self.copyWith(
trackingPermission: null == trackingPermission ? _self.trackingPermission : trackingPermission // ignore: cast_nullable_to_non_nullable
as bool,crashReportingPermission: null == crashReportingPermission ? _self.crashReportingPermission : crashReportingPermission // ignore: cast_nullable_to_non_nullable
as bool,notificationTime: null == notificationTime ? _self.notificationTime : notificationTime // ignore: cast_nullable_to_non_nullable
as TimeOfDay,notificationEnabled: null == notificationEnabled ? _self.notificationEnabled : notificationEnabled // ignore: cast_nullable_to_non_nullable
as bool,sessionLockNotificationEnabled: null == sessionLockNotificationEnabled ? _self.sessionLockNotificationEnabled : sessionLockNotificationEnabled // ignore: cast_nullable_to_non_nullable
as bool,activateClickableSession: freezed == activateClickableSession ? _self.activateClickableSession : activateClickableSession // ignore: cast_nullable_to_non_nullable
as bool?,templateCourse: freezed == templateCourse ? _self.templateCourse : templateCourse // ignore: cast_nullable_to_non_nullable
as String?,showRestartInCourse: freezed == showRestartInCourse ? _self.showRestartInCourse : showRestartInCourse // ignore: cast_nullable_to_non_nullable
as bool?,statusBarDisabled: freezed == statusBarDisabled ? _self.statusBarDisabled : statusBarDisabled // ignore: cast_nullable_to_non_nullable
as bool?,
  ));
}

}


/// Adds pattern-matching-related methods to [PreferencesState].
extension PreferencesStatePatterns on PreferencesState {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _PreferencesState value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _PreferencesState() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _PreferencesState value)  $default,){
final _that = this;
switch (_that) {
case _PreferencesState():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _PreferencesState value)?  $default,){
final _that = this;
switch (_that) {
case _PreferencesState() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( bool trackingPermission,  bool crashReportingPermission,  TimeOfDay notificationTime,  bool notificationEnabled,  bool sessionLockNotificationEnabled,  bool? activateClickableSession,  String? templateCourse,  bool? showRestartInCourse,  bool? statusBarDisabled)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _PreferencesState() when $default != null:
return $default(_that.trackingPermission,_that.crashReportingPermission,_that.notificationTime,_that.notificationEnabled,_that.sessionLockNotificationEnabled,_that.activateClickableSession,_that.templateCourse,_that.showRestartInCourse,_that.statusBarDisabled);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( bool trackingPermission,  bool crashReportingPermission,  TimeOfDay notificationTime,  bool notificationEnabled,  bool sessionLockNotificationEnabled,  bool? activateClickableSession,  String? templateCourse,  bool? showRestartInCourse,  bool? statusBarDisabled)  $default,) {final _that = this;
switch (_that) {
case _PreferencesState():
return $default(_that.trackingPermission,_that.crashReportingPermission,_that.notificationTime,_that.notificationEnabled,_that.sessionLockNotificationEnabled,_that.activateClickableSession,_that.templateCourse,_that.showRestartInCourse,_that.statusBarDisabled);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( bool trackingPermission,  bool crashReportingPermission,  TimeOfDay notificationTime,  bool notificationEnabled,  bool sessionLockNotificationEnabled,  bool? activateClickableSession,  String? templateCourse,  bool? showRestartInCourse,  bool? statusBarDisabled)?  $default,) {final _that = this;
switch (_that) {
case _PreferencesState() when $default != null:
return $default(_that.trackingPermission,_that.crashReportingPermission,_that.notificationTime,_that.notificationEnabled,_that.sessionLockNotificationEnabled,_that.activateClickableSession,_that.templateCourse,_that.showRestartInCourse,_that.statusBarDisabled);case _:
  return null;

}
}

}

/// @nodoc


class _PreferencesState extends PreferencesState with DiagnosticableTreeMixin {
  const _PreferencesState({required this.trackingPermission, required this.crashReportingPermission, required this.notificationTime, required this.notificationEnabled, required this.sessionLockNotificationEnabled, required this.activateClickableSession, required this.templateCourse, required this.showRestartInCourse, required this.statusBarDisabled}): super._();
  

@override final  bool trackingPermission;
@override final  bool crashReportingPermission;
@override final  TimeOfDay notificationTime;
@override final  bool notificationEnabled;
@override final  bool sessionLockNotificationEnabled;
@override final  bool? activateClickableSession;
@override final  String? templateCourse;
@override final  bool? showRestartInCourse;
@override final  bool? statusBarDisabled;

/// Create a copy of PreferencesState
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$PreferencesStateCopyWith<_PreferencesState> get copyWith => __$PreferencesStateCopyWithImpl<_PreferencesState>(this, _$identity);


@override
void debugFillProperties(DiagnosticPropertiesBuilder properties) {
  properties
    ..add(DiagnosticsProperty('type', 'PreferencesState'))
    ..add(DiagnosticsProperty('trackingPermission', trackingPermission))..add(DiagnosticsProperty('crashReportingPermission', crashReportingPermission))..add(DiagnosticsProperty('notificationTime', notificationTime))..add(DiagnosticsProperty('notificationEnabled', notificationEnabled))..add(DiagnosticsProperty('sessionLockNotificationEnabled', sessionLockNotificationEnabled))..add(DiagnosticsProperty('activateClickableSession', activateClickableSession))..add(DiagnosticsProperty('templateCourse', templateCourse))..add(DiagnosticsProperty('showRestartInCourse', showRestartInCourse))..add(DiagnosticsProperty('statusBarDisabled', statusBarDisabled));
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _PreferencesState&&(identical(other.trackingPermission, trackingPermission) || other.trackingPermission == trackingPermission)&&(identical(other.crashReportingPermission, crashReportingPermission) || other.crashReportingPermission == crashReportingPermission)&&(identical(other.notificationTime, notificationTime) || other.notificationTime == notificationTime)&&(identical(other.notificationEnabled, notificationEnabled) || other.notificationEnabled == notificationEnabled)&&(identical(other.sessionLockNotificationEnabled, sessionLockNotificationEnabled) || other.sessionLockNotificationEnabled == sessionLockNotificationEnabled)&&(identical(other.activateClickableSession, activateClickableSession) || other.activateClickableSession == activateClickableSession)&&(identical(other.templateCourse, templateCourse) || other.templateCourse == templateCourse)&&(identical(other.showRestartInCourse, showRestartInCourse) || other.showRestartInCourse == showRestartInCourse)&&(identical(other.statusBarDisabled, statusBarDisabled) || other.statusBarDisabled == statusBarDisabled));
}


@override
int get hashCode => Object.hash(runtimeType,trackingPermission,crashReportingPermission,notificationTime,notificationEnabled,sessionLockNotificationEnabled,activateClickableSession,templateCourse,showRestartInCourse,statusBarDisabled);

@override
String toString({ DiagnosticLevel minLevel = DiagnosticLevel.info }) {
  return 'PreferencesState(trackingPermission: $trackingPermission, crashReportingPermission: $crashReportingPermission, notificationTime: $notificationTime, notificationEnabled: $notificationEnabled, sessionLockNotificationEnabled: $sessionLockNotificationEnabled, activateClickableSession: $activateClickableSession, templateCourse: $templateCourse, showRestartInCourse: $showRestartInCourse, statusBarDisabled: $statusBarDisabled)';
}


}

/// @nodoc
abstract mixin class _$PreferencesStateCopyWith<$Res> implements $PreferencesStateCopyWith<$Res> {
  factory _$PreferencesStateCopyWith(_PreferencesState value, $Res Function(_PreferencesState) _then) = __$PreferencesStateCopyWithImpl;
@override @useResult
$Res call({
 bool trackingPermission, bool crashReportingPermission, TimeOfDay notificationTime, bool notificationEnabled, bool sessionLockNotificationEnabled, bool? activateClickableSession, String? templateCourse, bool? showRestartInCourse, bool? statusBarDisabled
});




}
/// @nodoc
class __$PreferencesStateCopyWithImpl<$Res>
    implements _$PreferencesStateCopyWith<$Res> {
  __$PreferencesStateCopyWithImpl(this._self, this._then);

  final _PreferencesState _self;
  final $Res Function(_PreferencesState) _then;

/// Create a copy of PreferencesState
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? trackingPermission = null,Object? crashReportingPermission = null,Object? notificationTime = null,Object? notificationEnabled = null,Object? sessionLockNotificationEnabled = null,Object? activateClickableSession = freezed,Object? templateCourse = freezed,Object? showRestartInCourse = freezed,Object? statusBarDisabled = freezed,}) {
  return _then(_PreferencesState(
trackingPermission: null == trackingPermission ? _self.trackingPermission : trackingPermission // ignore: cast_nullable_to_non_nullable
as bool,crashReportingPermission: null == crashReportingPermission ? _self.crashReportingPermission : crashReportingPermission // ignore: cast_nullable_to_non_nullable
as bool,notificationTime: null == notificationTime ? _self.notificationTime : notificationTime // ignore: cast_nullable_to_non_nullable
as TimeOfDay,notificationEnabled: null == notificationEnabled ? _self.notificationEnabled : notificationEnabled // ignore: cast_nullable_to_non_nullable
as bool,sessionLockNotificationEnabled: null == sessionLockNotificationEnabled ? _self.sessionLockNotificationEnabled : sessionLockNotificationEnabled // ignore: cast_nullable_to_non_nullable
as bool,activateClickableSession: freezed == activateClickableSession ? _self.activateClickableSession : activateClickableSession // ignore: cast_nullable_to_non_nullable
as bool?,templateCourse: freezed == templateCourse ? _self.templateCourse : templateCourse // ignore: cast_nullable_to_non_nullable
as String?,showRestartInCourse: freezed == showRestartInCourse ? _self.showRestartInCourse : showRestartInCourse // ignore: cast_nullable_to_non_nullable
as bool?,statusBarDisabled: freezed == statusBarDisabled ? _self.statusBarDisabled : statusBarDisabled // ignore: cast_nullable_to_non_nullable
as bool?,
  ));
}


}

// dart format on
