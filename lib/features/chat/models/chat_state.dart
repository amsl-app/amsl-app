import 'package:amsl_app/features/chat/models/date_input.dart';
import 'package:amsl_app/features/chat/models/duration_input.dart';
import 'package:amsl_app/features/chat/models/focus_input.dart';
import 'package:amsl_app/features/chat/models/journal_content_input.dart';
import 'package:amsl_app/features/chat/models/journal_title_input.dart';
import 'package:amsl_app/features/chat/models/mood_input.dart';
import 'package:amsl_app/features/chat/models/number_input.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

import 'buttons.dart';

part 'chat_state.freezed.dart';

class ChatError {
  final String message;
  final int? statusCode; // only set if it's a HikariException

  ChatError({required this.message, this.statusCode});

  // We allow only one session per moduls => we have to abort every other session to resolve
  bool get abortModuleToResolve {
    return statusCode == 409;
  }

  // server got invalid data from database => we have to restart the session to resolve
  bool get abortSessionToResolve {
    return statusCode == 502;
  }

  @override
  String toString() {
    return "ChatError: $message, statusCode: $statusCode";
  }
}

@freezed
abstract class CurrentChatState with _$CurrentChatState {
  const CurrentChatState._();

  factory CurrentChatState({
    Buttons? replyButtons,
    NumberInput? numberInput,
    DateInput? dateInput,
    DurationInput? durationInput,
    ChatError? error,
    // TODO Refactor? They should be mutually exclusive
    MoodInput? moodInput,
    FocusInput? focusInput,
    JournalContentInput? journalContentInput,
    JournalTitleInput? journalTitleInput,
    @Default(true) bool isConnected,
    @Default(true) bool hideInput,
    @Default(false) bool resolvingError,
    @Default(false) bool typing,
    @Default(false) bool isConversationEnd,
    @Default(false) bool allowTextInput,
  }) = _CurrentChatState;

  bool get hasError {
    return error != null;
  }

  bool get hasJournalInput {
    return moodInput != null ||
        focusInput != null ||
        journalContentInput != null ||
        journalTitleInput != null;
  }
}
