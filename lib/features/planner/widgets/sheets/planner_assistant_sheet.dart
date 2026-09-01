import 'package:amsl_app/constants.dart';
import 'package:amsl_app/features/planner/providers/planner.dart';
import 'package:amsl_app/features/planner/widgets/sheets/create_entry_sheet.dart';
import 'package:amsl_app/widgets/buttons/rounded_corner_button.dart';
import 'package:amsl_app/widgets/dialogs/amsl_dialog.dart';
import 'package:amsl_app/widgets/error/error_bar.dart';
import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:gap/gap.dart';
import 'package:go_router/go_router.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

void showPlannerAssistantSheet(BuildContext context, WidgetRef ref) {
  showAmslBottomSheet(
    context: context,
    child: PlannerAssistantSheet(
      onSuggestions: (entries) {
        context.pop();
        showCreateEntrySheet(context, ref, initialEntries: entries);
      },
    ),
    onClose: () => Navigator.of(context).pop(),
    bottomBar: true,
  );
}

class PlannerAssistantSheet extends HookConsumerWidget {
  const PlannerAssistantSheet({super.key, required this.onSuggestions});

  final void Function(List<NewEntryData> entries) onSuggestions;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final theme = Theme.of(context);
    final textController = useTextEditingController();

    Future<void> submit() async {
      final text = textController.text.trim();
      if (text.isEmpty) return;

      try {
        final result = await ref
            .read(plannerPodProvider.notifier)
            .askAssistant(
              text: text,
              today: kOldDateFormat.format(DateTime.now()),
            );
        if (result.isEmpty) {
          if (context.mounted) {
            showMessage(
              context,
              label: 'Keine Aktivitäten erkannt',
              error: true,
            );
          }
          return;
        }
        if (!context.mounted) return;
        onSuggestions(
          result
              .map(
                (e) => NewEntryData(
                  title: e.title,
                  date: DateTime.parse(e.date),
                  priority: e.priority,
                  milestoneId: e.milestoneId,
                ),
              )
              .toList(),
        );
      } catch (e) {
        if (context.mounted) showException(context, e);
      }
    }

    final inputBorder = OutlineInputBorder(
      borderRadius: BorderRadius.circular(12),
      borderSide: BorderSide(
        color: theme.colorScheme.outline.withValues(alpha: 0.4),
      ),
    );
    final focusedBorder = OutlineInputBorder(
      borderRadius: BorderRadius.circular(12),
      borderSide: BorderSide(color: theme.colorScheme.primary, width: 2),
    );

    return Column(
      mainAxisSize: MainAxisSize.min,
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        Text(
          'Planner Assistent',
          style: theme.textTheme.titleSmall?.copyWith(
            color: theme.colorScheme.onSurface.withValues(alpha: 0.5),
            letterSpacing: 0.5,
          ),
        ),
        const Gap(16),
        TextField(
          controller: textController,
          maxLines: 5,
          minLines: 3,
          textCapitalization: TextCapitalization.sentences,
          style: theme.textTheme.bodyLarge,
          decoration: InputDecoration(
            hintText: 'Beschreibe, was du planen möchtest…',
            border: inputBorder,
            enabledBorder: inputBorder,
            focusedBorder: focusedBorder,
            contentPadding: const EdgeInsets.symmetric(
              horizontal: 12,
              vertical: 10,
            ),
          ),
        ),
        const Gap(12),
        RoundedCornerButton(
          label: 'Analysieren',
          onTap: submit,
          buttonColor: theme.colorScheme.primary,
          labelColor: theme.colorScheme.onPrimary,
        ),
      ],
    );
  }
}
