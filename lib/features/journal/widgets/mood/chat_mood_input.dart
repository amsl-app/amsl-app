import 'package:amsl_app/features/journal/models/moods.dart';
import 'package:amsl_app/features/journal/widgets/mood/mood_icon.dart';
import 'package:amsl_app/features/tracking/tracking.dart';
import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

import '../../../../widgets/buttons/rounded_button.dart';

class ChatMoodInput extends StatefulHookConsumerWidget {
  final Function onSubmit;

  const ChatMoodInput({super.key, required this.onSubmit});

  @override
  ConsumerState<ChatMoodInput> createState() => _ChatMoodInputState();
}

class _ChatMoodInputState extends ConsumerState<ChatMoodInput> {
  Mood? selectedMood;
  void onSelect(double mood) {
    setState(() {
      trackEvent(
        category: TrackingCategory.journalMood,
        action: TrackingAction.select,
        name: Moods.get(mood).data.name,
        value: mood,
      );
      setState(() {
        selectedMood = Moods.get(mood);
      });
    });
  }

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
          // MoodSelectionList(
          //   labelColor: Colors.black,
          //   iconColor: theme.colorScheme.onSecondary,
          //   backgroundColor: theme.colorScheme.secondary,
          //   activeIconColor: theme.colorScheme.onPrimary,
          //   activeBackgroundColor: theme.colorScheme.primary,
          //   onMoodSelected: (selectedMood) => setState(() {
          //     mood = selectedMood;
          //   }),
          // ),
          Row(
            mainAxisSize: MainAxisSize.max,
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: List.generate(
              Moods.list.length,
              (index) => GestureDetector(
                onTap: () => onSelect(Moods.list[index].value),
                child: MoodIcon(
                  size: 38,
                  iconColor: theme.colorScheme.onSecondary,
                  activeIconColor: theme.colorScheme.onPrimary,
                  backgroundColor: theme.colorScheme.secondary,
                  activeBackgroundColor: theme.colorScheme.primary,
                  mood: Moods.list[index].data.icon,
                  selected: selectedMood == Moods.list[index],
                ),
              ),
            ),
          ),
          const Gap(40),
          Row(
            mainAxisSize: MainAxisSize.max,
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                Moods.list.first.data.description,
                style: theme.textTheme.titleSmall!.copyWith(
                  color: Colors.black,
                ),
              ),
              Text(
                Moods.list.last.data.description,
                style: theme.textTheme.titleSmall!.copyWith(
                  color: Colors.black,
                ),
              ),
            ],
          ),
          const Gap(10.0),
          RoundedButton(
            buttonColor: selectedMood != null
                ? theme.colorScheme.primary
                : theme.colorScheme.primary.withValues(alpha: 0.5),
            label: "Abschicken",
            onTap: () {
              if (selectedMood != null) {
                widget.onSubmit(selectedMood!.value);
              }
            },
          ),
        ],
      ),
    );
  }
}
