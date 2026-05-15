import 'package:amsl_app/features/journal/widgets/focus/focus_selection_list.dart';
import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

import '../../../../widgets/buttons/rounded_button.dart';

class ChatFocusInput extends StatefulHookConsumerWidget {
  final Function onSubmit;
  final double maxHeight;

  const ChatFocusInput({
    super.key,
    required this.onSubmit,
    required this.maxHeight,
  });

  @override
  ConsumerState<ChatFocusInput> createState() => _ChatFocusInputState();
}

class _ChatFocusInputState extends ConsumerState<ChatFocusInput> {
  List<String> focusIDs = [];

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Padding(
      padding: const EdgeInsets.only(
        left: 24.0,
        right: 24.0,
        //bottom: 16.0,
        top: 4.0,
      ),
      child: Column(
        children: [
          Container(
            constraints: BoxConstraints(maxHeight: widget.maxHeight * 0.5),
            child: FocusSelectionList(
              bottomPadding: false,
              columns: 3,
              gap: 20,
              labelColor: Colors.black,
              iconColor: theme.colorScheme.onSecondary,
              backgroundColor: theme.colorScheme.secondary,
              activeIconColor: theme.colorScheme.onPrimary,
              activeBackgroundColor: theme.colorScheme.primary,
              onSelectionChanged: (selectedIDs) => setState(() {
                focusIDs = selectedIDs;
              }),
            ),
          ),
          const Gap(10),
          RoundedButton(
            buttonColor: focusIDs.isNotEmpty
                ? theme.colorScheme.primary
                : theme.colorScheme.primary.withValues(alpha: 0.5),
            label: "Abschicken",
            onTap: () {
              if (focusIDs.isNotEmpty) {
                widget.onSubmit(focusIDs);
              }
            },
          ),
        ],
      ),
    );
  }
}
