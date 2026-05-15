import 'dart:async';

import 'package:amsl_app/features/chat/models/buttons.dart';
import 'package:amsl_app/features/chat/models/card.dart';
import 'package:amsl_app/features/chat/models/chat_step_entry.dart';
import 'package:amsl_app/features/chat/models/conversation_error.dart';
import 'package:amsl_app/features/chat/models/date_input.dart';
import 'package:amsl_app/features/chat/models/delay.dart';
import 'package:amsl_app/features/chat/models/duration_input.dart';
import 'package:amsl_app/features/chat/models/duration_message.dart';
import 'package:amsl_app/features/chat/models/focus_input.dart';
import 'package:amsl_app/features/chat/models/focus_message.dart';
import 'package:amsl_app/features/chat/models/image_message.dart';
import 'package:amsl_app/features/chat/models/journal_content_input.dart';
import 'package:amsl_app/features/chat/models/journal_title_input.dart';
import 'package:amsl_app/features/chat/models/message.dart';
import 'package:amsl_app/features/chat/models/mood_input.dart';
import 'package:amsl_app/features/chat/models/mood_message.dart';
import 'package:amsl_app/features/chat/models/number_input.dart';
import 'package:amsl_app/features/chat/models/text_chunk.dart';
import 'package:amsl_app/features/chat/models/text_message.dart';
import 'package:amsl_app/hikari/exception.dart';
import 'package:amsl_app/hikari/hikari.dart';
import 'package:amsl_app/models/hikari/chat/date_input/date_input_content.dart';
import 'package:amsl_app/models/hikari/chat/duration_input/duration_input_content.dart';
import 'package:amsl_app/models/hikari/chat/journal/focus_input_content.dart';
import 'package:amsl_app/models/hikari/chat/journal/journal_content_input_content.dart';
import 'package:amsl_app/models/hikari/chat/journal/journal_title_input_content.dart';
import 'package:amsl_app/models/hikari/chat/journal/mood_input_content.dart';
import 'package:amsl_app/models/hikari/chat/number_input/number_input_content.dart';
import 'package:amsl_app/models/hikari/chat/payload.dart';
import 'package:amsl_app/models/hikari/chat/payload_content.dart';
import 'package:amsl_app/models/hikari/chat/websocket/chunkpost.dart';
import 'package:amsl_app/models/hikari/chat/websocket/websocket_history.dart';
import 'package:amsl_app/models/hikari/chat/websocket/websocket_request.dart';
import 'package:amsl_app/models/hikari/chat/websocket/websocket_response.dart';
import 'package:collection/collection.dart';
import 'package:logging/logging.dart';
import 'package:web_socket_channel/status.dart' as status;
import 'package:web_socket_channel/web_socket_channel.dart';

import '../../../models/hikari/chat/direction.dart';
import '../../../models/hikari/chat/message.dart' as hikari_message;
import '../../../models/hikari/chat/post.dart';
import '../models/conversation_end.dart';
import '../models/hold.dart';

part 'channel_source.store.dart';
part 'channel_source.stream.dart';

sealed class ChatChannelSource {
  static final log = Logger("ChannelMessageSource");

  int sequence = 0;
  final String moduleId;
  final String sessionId;
  final Hikari hikari;

  ChatChannelSource({
    required this.moduleId,
    required this.sessionId,
    required this.hikari,
  });

  Stream get stream;

  Stream<bool> get connectionStateStream;

  Future<Post?> sendMessage(
    dynamic data, {
    required String contentType,
    required String payloadKey,
    String? journalType,
    String? displayType,
  });

  void close();

  Future<List<ChatStepEntry>?> reconnect();

  void reinitialize(List<ChatStepEntry>? steps);

  Future<void> abort();

  static List<Message> createStepFromPayload(
    Payload payload,
    Sender sender, {
    bool replay = false,
  }) {
    switch (payload) {
      case Payload(contentType: "text", content: PayloadContent(:final text)):
        return [
          // text might be null after an error
          if (text != null) TextMessage(text: text, sender: sender),
        ];

      case Payload(contentType: "payload", :final content):
        // TODO reconvert the payload data to the button title by loading the previous message
        switch (content) {
          case PayloadContent(type: "journal-focus", :final payload?):
            List<String> focusIDs = [];
            for (var focus in payload) {
              focusIDs.add(focus);
            }
            return [FocusMessage(sender: sender, focusIDs: focusIDs)];
          case PayloadContent(type: "journal-mood", :final payload?):
            return [MoodMessage(sender: sender, mood: payload)];
          case PayloadContent(:final displayType?, :final payload?):
            switch (displayType) {
              case "duration":
                return [DurationMessage(sender: sender, duration: payload)];
            }
        }
        return [TextMessage(text: content.toString(), sender: sender)];
      case Payload(
        contentType: "button",
        content: PayloadContent(:final title?, :final payload?),
      ):
        return [
          Buttons(
            buttons: [Button(text: title, payload: payload)],
            isQuickReply: false,
          ),
        ];
      case Payload(
        contentType: "question" || "quickreply",
        content: PayloadContent(
          :final buttons?,
          :final buttonType,
          :final title,
        ),
      ):
        final button_widgets = buttons.map((button) {
          final content = button.content;
          final confirm = Confirm.values.asNameMap()[content.confirm];

          return Button(
            text: content.title,
            payload: content.payload,
            confirm: confirm,
          );
        });
        return [
          if (title != null) TextMessage(text: title, sender: sender),
          Buttons(
            buttons: button_widgets.toList(),
            isQuickReply: buttonType == "quick_reply",
          ),
        ];
      case Payload(
        contentType: "numberinput",
        content: NumberInputContent(:final title, :final max, :final min),
      ):
        return [
          TextMessage(text: title, sender: sender),
          //TODO placeholder
          NumberInput(sender: sender, max: max as int?, min: min as int?),
        ];
      case Payload(
        contentType: "dateinput",
        content: DateInputContent(:final title, :final max, :final min),
      ):
        return [
          TextMessage(text: title, sender: sender),
          DateInput(sender: sender, max: max, min: min),
        ];
      case Payload(
        contentType: "journaltitleinput",
        content: JournalTitleInputContent(:final prompt),
      ):
        return [
          if (prompt != null) TextMessage(text: prompt, sender: sender),
          const JournalTitleInput(),
        ];
      case Payload(
        contentType: "journalcontentinput",
        content: JournalContentInputContent(
          :final prompt,
          :final requireAssistant,
        ),
      ):
        return [
          TextMessage(text: prompt, sender: sender),
          JournalContentInput(
            prompt: prompt,
            requireAssistant: requireAssistant,
          ),
        ];
      case Payload(
        contentType: "journalfocusinput",
        content: FocusInputContent(:final prompt),
      ):
        return [TextMessage(text: prompt, sender: sender), const FocusInput()];
      case Payload(
        contentType: "journalmoodinput",
        content: MoodInputContent(:final prompt),
      ):
        return [TextMessage(text: prompt, sender: sender), const MoodInput()];
      case Payload(
        contentType: "durationinput",
        content: DurationInputContent(
          :final title,
          :final step,
          :final defaultValue,
          :final max,
          :final min,
          :final placeholder,
        ),
      ):
        return [
          if (title != null) TextMessage(text: title, sender: sender),
          DurationInput(
            sender: sender,
            step: step as int?,
            defaultValue: defaultValue as int?,
            max: max as int?,
            min: min as int?,
            placeholder: placeholder,
          ),
        ];
      case Payload(
        contentType: "typing",
        content: PayloadContent(:final duration),
      ):
        return [if (!replay) Delay(delay: duration, show: true)];
      case Payload(
        contentType: "wait",
        content: PayloadContent(:final duration),
      ):
        return [if (!replay) Delay(delay: duration, show: false)];
      case Payload(contentType: "image", content: PayloadContent(:final url?)):
        try {
          return [ImageMessage(uri: Uri.parse(url), sender: sender)];
        } catch (e) {
          log.severe("Can't parse url: $e");
          return [];
        }
      case Payload(
        contentType: "card",
        content: PayloadContent(
          :final title?,
          :final imageUrl?,
          :final buttons?,
        ),
      ):
        try {
          // TODO Support url links
          final button_widgets = buttons.map((button) {
            final content = button.content;
            return Button(text: content.title, payload: content.payload);
          });
          return [
            Card(
              imageUri: Uri.parse(imageUrl),
              title: title,
              buttons: button_widgets.toList(),
              sender: sender,
            ),
          ];
        } catch (e) {
          log.severe("Can't parse url: $e");
          return [];
        }
      case Payload(contentType: "url", content: PayloadContent(:final url?)):
        return [TextMessage(text: url, sender: sender)];
      case Payload(contentType: "error"):
        log.info("Error message $payload");
        return [
          // TODO Show errors?
          // if (!replay)
          //   TextMessage(
          //     text: "Error! ${payloadContent.error!}",
          //     sender: sender,
          //   )
        ];
      case Payload(contentType: "flow_trigger"):
        // Ignore flow triggers
        return [];
      case Payload(contentType: "hold"):
        return [const Hold()];
    }
    return [
      TextMessage(
        text:
            'Unknown content type: ${payload.contentType}. Write an arbitrary message to continue the conversation.',
        sender: Sender.other,
      ),
    ];
  }
}
