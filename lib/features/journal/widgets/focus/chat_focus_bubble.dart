import 'package:amsl_app/features/journal/widgets/history/focus_tag.dart';
import 'package:amsl_app/models/tori/journal/journal_focus.dart';
import 'package:amsl_app/themes/chat_theme.dart';

import 'package:amsl_app/widgets/loading/loading_text.dart';
import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

import '../../providers/focus/focus.dart';

class FocusBubble extends HookConsumerWidget {
  const FocusBubble(this.focusIDs, this.sentByMe, {super.key});

  final List<String> focusIDs;
  final bool sentByMe;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final chatTheme = Theme.of(context).chatTheme;
    final theme = sentByMe ? chatTheme.ownBubbles : chatTheme.otherBubbles;

    return Align(
      alignment: sentByMe ? Alignment.centerRight : Alignment.centerLeft,
      child: UnconstrainedBox(
        child: Container(
          padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 13),
          constraints: BoxConstraints(
            maxWidth: MediaQuery.of(context).size.width * 0.7,
          ),
          decoration: BoxDecoration(
            borderRadius: const BorderRadius.all(Radius.circular(12)),
            color: theme.backgroundColor,
          ),
          child: _build(context, ref),
        ),
      ),
    );
  }

  Widget _build(BuildContext context, WidgetRef ref) {
    final theme = Theme.of(context);

    final asyncFocus = ref.watch(focusProvider);

    if (asyncFocus.isLoading) {
      return LoadingText(color: theme.colorScheme.primary, width: 100);
    }

    if (asyncFocus.hasError || asyncFocus.value == null) {
      return Text(
        "Es ist ein Fehler aufgetreten.",
        style: theme.textTheme.bodyMedium,
      );
    }

    Map<String, JournalFocus> foci = asyncFocus.requireValue;

    List<JournalFocus> selectedFoci = [for (var id in focusIDs) foci[id]!];

    return Column(
      mainAxisSize: MainAxisSize.min,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: List.generate(
        selectedFoci.length,
        (index) => FocusTag(
          iconSize: 30.0,
          fontSize: 16.0,
          borderRadius: 10.0,
          focus: selectedFoci[index],
          background: theme.colorScheme.onPrimary,
          color: theme.colorScheme.primary,
        ),
      ),
    );
  }
}
