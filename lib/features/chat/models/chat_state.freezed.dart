// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'chat_state.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;
/// @nodoc
mixin _$CurrentChatState {

 Buttons? get replyButtons; NumberInput? get numberInput; DateInput? get dateInput; DurationInput? get durationInput; ChatError? get error;// TODO Refactor? They should be mutually exclusive
 MoodInput? get moodInput; FocusInput? get focusInput; JournalContentInput? get journalContentInput; JournalTitleInput? get journalTitleInput; bool get isConnected; bool get hideInput; bool get resolvingError; bool get typing; bool get isConversationEnd; bool get allowTextInput;
/// Create a copy of CurrentChatState
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$CurrentChatStateCopyWith<CurrentChatState> get copyWith => _$CurrentChatStateCopyWithImpl<CurrentChatState>(this as CurrentChatState, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is CurrentChatState&&(identical(other.replyButtons, replyButtons) || other.replyButtons == replyButtons)&&(identical(other.numberInput, numberInput) || other.numberInput == numberInput)&&(identical(other.dateInput, dateInput) || other.dateInput == dateInput)&&(identical(other.durationInput, durationInput) || other.durationInput == durationInput)&&(identical(other.error, error) || other.error == error)&&(identical(other.moodInput, moodInput) || other.moodInput == moodInput)&&(identical(other.focusInput, focusInput) || other.focusInput == focusInput)&&(identical(other.journalContentInput, journalContentInput) || other.journalContentInput == journalContentInput)&&(identical(other.journalTitleInput, journalTitleInput) || other.journalTitleInput == journalTitleInput)&&(identical(other.isConnected, isConnected) || other.isConnected == isConnected)&&(identical(other.hideInput, hideInput) || other.hideInput == hideInput)&&(identical(other.resolvingError, resolvingError) || other.resolvingError == resolvingError)&&(identical(other.typing, typing) || other.typing == typing)&&(identical(other.isConversationEnd, isConversationEnd) || other.isConversationEnd == isConversationEnd)&&(identical(other.allowTextInput, allowTextInput) || other.allowTextInput == allowTextInput));
}


@override
int get hashCode => Object.hash(runtimeType,replyButtons,numberInput,dateInput,durationInput,error,moodInput,focusInput,journalContentInput,journalTitleInput,isConnected,hideInput,resolvingError,typing,isConversationEnd,allowTextInput);

@override
String toString() {
  return 'CurrentChatState(replyButtons: $replyButtons, numberInput: $numberInput, dateInput: $dateInput, durationInput: $durationInput, error: $error, moodInput: $moodInput, focusInput: $focusInput, journalContentInput: $journalContentInput, journalTitleInput: $journalTitleInput, isConnected: $isConnected, hideInput: $hideInput, resolvingError: $resolvingError, typing: $typing, isConversationEnd: $isConversationEnd, allowTextInput: $allowTextInput)';
}


}

/// @nodoc
abstract mixin class $CurrentChatStateCopyWith<$Res>  {
  factory $CurrentChatStateCopyWith(CurrentChatState value, $Res Function(CurrentChatState) _then) = _$CurrentChatStateCopyWithImpl;
@useResult
$Res call({
 Buttons? replyButtons, NumberInput? numberInput, DateInput? dateInput, DurationInput? durationInput, ChatError? error, MoodInput? moodInput, FocusInput? focusInput, JournalContentInput? journalContentInput, JournalTitleInput? journalTitleInput, bool isConnected, bool hideInput, bool resolvingError, bool typing, bool isConversationEnd, bool allowTextInput
});




}
/// @nodoc
class _$CurrentChatStateCopyWithImpl<$Res>
    implements $CurrentChatStateCopyWith<$Res> {
  _$CurrentChatStateCopyWithImpl(this._self, this._then);

  final CurrentChatState _self;
  final $Res Function(CurrentChatState) _then;

/// Create a copy of CurrentChatState
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? replyButtons = freezed,Object? numberInput = freezed,Object? dateInput = freezed,Object? durationInput = freezed,Object? error = freezed,Object? moodInput = freezed,Object? focusInput = freezed,Object? journalContentInput = freezed,Object? journalTitleInput = freezed,Object? isConnected = null,Object? hideInput = null,Object? resolvingError = null,Object? typing = null,Object? isConversationEnd = null,Object? allowTextInput = null,}) {
  return _then(_self.copyWith(
replyButtons: freezed == replyButtons ? _self.replyButtons : replyButtons // ignore: cast_nullable_to_non_nullable
as Buttons?,numberInput: freezed == numberInput ? _self.numberInput : numberInput // ignore: cast_nullable_to_non_nullable
as NumberInput?,dateInput: freezed == dateInput ? _self.dateInput : dateInput // ignore: cast_nullable_to_non_nullable
as DateInput?,durationInput: freezed == durationInput ? _self.durationInput : durationInput // ignore: cast_nullable_to_non_nullable
as DurationInput?,error: freezed == error ? _self.error : error // ignore: cast_nullable_to_non_nullable
as ChatError?,moodInput: freezed == moodInput ? _self.moodInput : moodInput // ignore: cast_nullable_to_non_nullable
as MoodInput?,focusInput: freezed == focusInput ? _self.focusInput : focusInput // ignore: cast_nullable_to_non_nullable
as FocusInput?,journalContentInput: freezed == journalContentInput ? _self.journalContentInput : journalContentInput // ignore: cast_nullable_to_non_nullable
as JournalContentInput?,journalTitleInput: freezed == journalTitleInput ? _self.journalTitleInput : journalTitleInput // ignore: cast_nullable_to_non_nullable
as JournalTitleInput?,isConnected: null == isConnected ? _self.isConnected : isConnected // ignore: cast_nullable_to_non_nullable
as bool,hideInput: null == hideInput ? _self.hideInput : hideInput // ignore: cast_nullable_to_non_nullable
as bool,resolvingError: null == resolvingError ? _self.resolvingError : resolvingError // ignore: cast_nullable_to_non_nullable
as bool,typing: null == typing ? _self.typing : typing // ignore: cast_nullable_to_non_nullable
as bool,isConversationEnd: null == isConversationEnd ? _self.isConversationEnd : isConversationEnd // ignore: cast_nullable_to_non_nullable
as bool,allowTextInput: null == allowTextInput ? _self.allowTextInput : allowTextInput // ignore: cast_nullable_to_non_nullable
as bool,
  ));
}

}


/// Adds pattern-matching-related methods to [CurrentChatState].
extension CurrentChatStatePatterns on CurrentChatState {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _CurrentChatState value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _CurrentChatState() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _CurrentChatState value)  $default,){
final _that = this;
switch (_that) {
case _CurrentChatState():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _CurrentChatState value)?  $default,){
final _that = this;
switch (_that) {
case _CurrentChatState() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( Buttons? replyButtons,  NumberInput? numberInput,  DateInput? dateInput,  DurationInput? durationInput,  ChatError? error,  MoodInput? moodInput,  FocusInput? focusInput,  JournalContentInput? journalContentInput,  JournalTitleInput? journalTitleInput,  bool isConnected,  bool hideInput,  bool resolvingError,  bool typing,  bool isConversationEnd,  bool allowTextInput)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _CurrentChatState() when $default != null:
return $default(_that.replyButtons,_that.numberInput,_that.dateInput,_that.durationInput,_that.error,_that.moodInput,_that.focusInput,_that.journalContentInput,_that.journalTitleInput,_that.isConnected,_that.hideInput,_that.resolvingError,_that.typing,_that.isConversationEnd,_that.allowTextInput);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( Buttons? replyButtons,  NumberInput? numberInput,  DateInput? dateInput,  DurationInput? durationInput,  ChatError? error,  MoodInput? moodInput,  FocusInput? focusInput,  JournalContentInput? journalContentInput,  JournalTitleInput? journalTitleInput,  bool isConnected,  bool hideInput,  bool resolvingError,  bool typing,  bool isConversationEnd,  bool allowTextInput)  $default,) {final _that = this;
switch (_that) {
case _CurrentChatState():
return $default(_that.replyButtons,_that.numberInput,_that.dateInput,_that.durationInput,_that.error,_that.moodInput,_that.focusInput,_that.journalContentInput,_that.journalTitleInput,_that.isConnected,_that.hideInput,_that.resolvingError,_that.typing,_that.isConversationEnd,_that.allowTextInput);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( Buttons? replyButtons,  NumberInput? numberInput,  DateInput? dateInput,  DurationInput? durationInput,  ChatError? error,  MoodInput? moodInput,  FocusInput? focusInput,  JournalContentInput? journalContentInput,  JournalTitleInput? journalTitleInput,  bool isConnected,  bool hideInput,  bool resolvingError,  bool typing,  bool isConversationEnd,  bool allowTextInput)?  $default,) {final _that = this;
switch (_that) {
case _CurrentChatState() when $default != null:
return $default(_that.replyButtons,_that.numberInput,_that.dateInput,_that.durationInput,_that.error,_that.moodInput,_that.focusInput,_that.journalContentInput,_that.journalTitleInput,_that.isConnected,_that.hideInput,_that.resolvingError,_that.typing,_that.isConversationEnd,_that.allowTextInput);case _:
  return null;

}
}

}

/// @nodoc


class _CurrentChatState extends CurrentChatState {
   _CurrentChatState({this.replyButtons, this.numberInput, this.dateInput, this.durationInput, this.error, this.moodInput, this.focusInput, this.journalContentInput, this.journalTitleInput, this.isConnected = true, this.hideInput = true, this.resolvingError = false, this.typing = false, this.isConversationEnd = false, this.allowTextInput = false}): super._();
  

@override final  Buttons? replyButtons;
@override final  NumberInput? numberInput;
@override final  DateInput? dateInput;
@override final  DurationInput? durationInput;
@override final  ChatError? error;
// TODO Refactor? They should be mutually exclusive
@override final  MoodInput? moodInput;
@override final  FocusInput? focusInput;
@override final  JournalContentInput? journalContentInput;
@override final  JournalTitleInput? journalTitleInput;
@override@JsonKey() final  bool isConnected;
@override@JsonKey() final  bool hideInput;
@override@JsonKey() final  bool resolvingError;
@override@JsonKey() final  bool typing;
@override@JsonKey() final  bool isConversationEnd;
@override@JsonKey() final  bool allowTextInput;

/// Create a copy of CurrentChatState
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$CurrentChatStateCopyWith<_CurrentChatState> get copyWith => __$CurrentChatStateCopyWithImpl<_CurrentChatState>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _CurrentChatState&&(identical(other.replyButtons, replyButtons) || other.replyButtons == replyButtons)&&(identical(other.numberInput, numberInput) || other.numberInput == numberInput)&&(identical(other.dateInput, dateInput) || other.dateInput == dateInput)&&(identical(other.durationInput, durationInput) || other.durationInput == durationInput)&&(identical(other.error, error) || other.error == error)&&(identical(other.moodInput, moodInput) || other.moodInput == moodInput)&&(identical(other.focusInput, focusInput) || other.focusInput == focusInput)&&(identical(other.journalContentInput, journalContentInput) || other.journalContentInput == journalContentInput)&&(identical(other.journalTitleInput, journalTitleInput) || other.journalTitleInput == journalTitleInput)&&(identical(other.isConnected, isConnected) || other.isConnected == isConnected)&&(identical(other.hideInput, hideInput) || other.hideInput == hideInput)&&(identical(other.resolvingError, resolvingError) || other.resolvingError == resolvingError)&&(identical(other.typing, typing) || other.typing == typing)&&(identical(other.isConversationEnd, isConversationEnd) || other.isConversationEnd == isConversationEnd)&&(identical(other.allowTextInput, allowTextInput) || other.allowTextInput == allowTextInput));
}


@override
int get hashCode => Object.hash(runtimeType,replyButtons,numberInput,dateInput,durationInput,error,moodInput,focusInput,journalContentInput,journalTitleInput,isConnected,hideInput,resolvingError,typing,isConversationEnd,allowTextInput);

@override
String toString() {
  return 'CurrentChatState(replyButtons: $replyButtons, numberInput: $numberInput, dateInput: $dateInput, durationInput: $durationInput, error: $error, moodInput: $moodInput, focusInput: $focusInput, journalContentInput: $journalContentInput, journalTitleInput: $journalTitleInput, isConnected: $isConnected, hideInput: $hideInput, resolvingError: $resolvingError, typing: $typing, isConversationEnd: $isConversationEnd, allowTextInput: $allowTextInput)';
}


}

/// @nodoc
abstract mixin class _$CurrentChatStateCopyWith<$Res> implements $CurrentChatStateCopyWith<$Res> {
  factory _$CurrentChatStateCopyWith(_CurrentChatState value, $Res Function(_CurrentChatState) _then) = __$CurrentChatStateCopyWithImpl;
@override @useResult
$Res call({
 Buttons? replyButtons, NumberInput? numberInput, DateInput? dateInput, DurationInput? durationInput, ChatError? error, MoodInput? moodInput, FocusInput? focusInput, JournalContentInput? journalContentInput, JournalTitleInput? journalTitleInput, bool isConnected, bool hideInput, bool resolvingError, bool typing, bool isConversationEnd, bool allowTextInput
});




}
/// @nodoc
class __$CurrentChatStateCopyWithImpl<$Res>
    implements _$CurrentChatStateCopyWith<$Res> {
  __$CurrentChatStateCopyWithImpl(this._self, this._then);

  final _CurrentChatState _self;
  final $Res Function(_CurrentChatState) _then;

/// Create a copy of CurrentChatState
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? replyButtons = freezed,Object? numberInput = freezed,Object? dateInput = freezed,Object? durationInput = freezed,Object? error = freezed,Object? moodInput = freezed,Object? focusInput = freezed,Object? journalContentInput = freezed,Object? journalTitleInput = freezed,Object? isConnected = null,Object? hideInput = null,Object? resolvingError = null,Object? typing = null,Object? isConversationEnd = null,Object? allowTextInput = null,}) {
  return _then(_CurrentChatState(
replyButtons: freezed == replyButtons ? _self.replyButtons : replyButtons // ignore: cast_nullable_to_non_nullable
as Buttons?,numberInput: freezed == numberInput ? _self.numberInput : numberInput // ignore: cast_nullable_to_non_nullable
as NumberInput?,dateInput: freezed == dateInput ? _self.dateInput : dateInput // ignore: cast_nullable_to_non_nullable
as DateInput?,durationInput: freezed == durationInput ? _self.durationInput : durationInput // ignore: cast_nullable_to_non_nullable
as DurationInput?,error: freezed == error ? _self.error : error // ignore: cast_nullable_to_non_nullable
as ChatError?,moodInput: freezed == moodInput ? _self.moodInput : moodInput // ignore: cast_nullable_to_non_nullable
as MoodInput?,focusInput: freezed == focusInput ? _self.focusInput : focusInput // ignore: cast_nullable_to_non_nullable
as FocusInput?,journalContentInput: freezed == journalContentInput ? _self.journalContentInput : journalContentInput // ignore: cast_nullable_to_non_nullable
as JournalContentInput?,journalTitleInput: freezed == journalTitleInput ? _self.journalTitleInput : journalTitleInput // ignore: cast_nullable_to_non_nullable
as JournalTitleInput?,isConnected: null == isConnected ? _self.isConnected : isConnected // ignore: cast_nullable_to_non_nullable
as bool,hideInput: null == hideInput ? _self.hideInput : hideInput // ignore: cast_nullable_to_non_nullable
as bool,resolvingError: null == resolvingError ? _self.resolvingError : resolvingError // ignore: cast_nullable_to_non_nullable
as bool,typing: null == typing ? _self.typing : typing // ignore: cast_nullable_to_non_nullable
as bool,isConversationEnd: null == isConversationEnd ? _self.isConversationEnd : isConversationEnd // ignore: cast_nullable_to_non_nullable
as bool,allowTextInput: null == allowTextInput ? _self.allowTextInput : allowTextInput // ignore: cast_nullable_to_non_nullable
as bool,
  ));
}


}

// dart format on
