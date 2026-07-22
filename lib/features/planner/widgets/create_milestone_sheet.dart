import 'package:amsl_app/constants.dart';
import 'package:amsl_app/features/planner/providers/milestone.dart';
import 'package:amsl_app/features/planner/models/new_planner_milestone.dart';
import 'package:amsl_app/models/tori/planner/planner_milestone.dart';
import 'package:amsl_app/widgets/buttons/rounded_corner_button.dart';
import 'package:amsl_app/widgets/dialogs/amsl_dialog.dart';
import 'package:amsl_app/widgets/error/error_bar.dart';
import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:gap/gap.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

class NewMilestoneData {
  String? id;
  String? title;
  DateTime date;
  String? description;

  NewMilestoneData({this.id, this.title, required this.date, this.description});
}

class CreateMilestoneCard extends HookWidget {
  const CreateMilestoneCard({super.key, required this.data});

  final NewMilestoneData data;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    final titleController = useTextEditingController(text: data.title ?? '');
    final titleError = useState(false);
    final selectedDate = useState(data.date);
    final descriptionController = useTextEditingController(
      text: data.description ?? '',
    );

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

    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 4),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          TextField(
            controller: titleController,
            textCapitalization: TextCapitalization.sentences,
            style: theme.textTheme.bodyLarge,
            onChanged: (v) {
              data.title = v;
              titleError.value = false;
            },
            decoration: InputDecoration(
              hintText: 'Titel',
              errorText: titleError.value ? 'Bitte einen Titel eingeben' : null,
              border: inputBorder,
              enabledBorder: inputBorder,
              focusedBorder: focusedBorder,
              errorBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(12),
                borderSide: BorderSide(color: theme.colorScheme.onError),
              ),
              focusedErrorBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(12),
                borderSide: BorderSide(
                  color: theme.colorScheme.onError,
                  width: 2,
                ),
              ),
              contentPadding: const EdgeInsets.symmetric(
                horizontal: 12,
                vertical: 10,
              ),
            ),
          ),
          const Gap(12),
          OutlinedButton.icon(
            style: OutlinedButton.styleFrom(
              foregroundColor: theme.colorScheme.onSurface,
              alignment: Alignment.centerLeft,
              padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 10),
              side: BorderSide(
                color: theme.colorScheme.outline.withValues(alpha: 0.4),
              ),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(12),
              ),
            ),
            onPressed: () async {
              final picked = await showDatePicker(
                context: context,
                initialDate: selectedDate.value,
                firstDate: DateTime(2020),
                lastDate: DateTime(2100),
              );
              if (picked != null) {
                selectedDate.value = picked;
                data.date = picked;
              }
            },
            icon: Icon(
              Icons.calendar_today,
              size: 16,
              color: theme.colorScheme.onSurface.withValues(alpha: 0.5),
            ),
            label: Text(
              kNewDateFormat.format(selectedDate.value),
              style: theme.textTheme.bodyLarge,
            ),
          ),
          const Gap(12),
          TextField(
            controller: descriptionController,
            textCapitalization: TextCapitalization.sentences,
            maxLines: 3,
            style: theme.textTheme.bodyMedium,
            onChanged: (v) => data.description = v.trim().isEmpty ? null : v,
            decoration: InputDecoration(
              hintText: 'Beschreibung (optional)',
              border: inputBorder,
              enabledBorder: inputBorder,
              focusedBorder: focusedBorder,
              contentPadding: const EdgeInsets.symmetric(
                horizontal: 12,
                vertical: 10,
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class CreateMilestoneSheet extends StatelessWidget {
  const CreateMilestoneSheet({super.key, required this.data, this.milestone});

  final NewMilestoneData data;
  final PlannerMilestone? milestone;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return SingleChildScrollView(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Text(
            milestone != null ? 'Meilenstein bearbeiten' : 'Neuer Meilenstein',
            style: theme.textTheme.titleSmall?.copyWith(
              color: theme.colorScheme.onSurface.withValues(alpha: 0.5),
              letterSpacing: 0.5,
            ),
          ),
          const Gap(16),
          CreateMilestoneCard(data: data),
        ],
      ),
    );
  }
}

void showCreateMilestoneSheet(
  BuildContext context,
  WidgetRef ref, {
  DateTime? initialDate,
  PlannerMilestone? milestone,
}) {
  final theme = Theme.of(context);

  final data = NewMilestoneData(
    id: milestone?.id,
    title: milestone?.title,
    date: milestone?.date ?? initialDate ?? DateTime.now(),
    description: milestone?.description,
  );

  Future<void> save() async {
    if (data.title == null || data.title!.trim().isEmpty) {
      showMessage(context, label: 'Bitte einen Titel eingeben', error: true);
      return;
    }

    final notifier = ref.read(milestonePodProvider.notifier);

    if (milestone != null) {
      await notifier.updateMilestone(
        milestone.id,
        title: data.title,
        date: kOldDateFormat.format(data.date),
        description: data.description,
        clearDescription: data.description == null,
      );
    } else {
      await notifier.createMilestone(
        NewPlannerMilestone(
          title: data.title!,
          date: kOldDateFormat.format(data.date),
          description: data.description,
        ),
      );
    }
    if (context.mounted) Navigator.of(context).pop();
  }

  showAmslBottomSheet(
    context: context,
    child: CreateMilestoneSheet(data: data, milestone: milestone),
    onClose: () => Navigator.of(context).pop(),
    bottomBar: true,
    buttonBar: [
      RoundedCornerButton(
        label: 'Speichern',
        onTap: save,
        buttonColor: theme.colorScheme.primary,
        labelColor: theme.colorScheme.onPrimary,
      ),
    ],
  );
}
