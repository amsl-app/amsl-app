import 'package:amsl_app/features/planner/providers/goals.dart';
import 'package:amsl_app/models/tori/planner/planner_goal.dart';
import 'package:amsl_app/widgets/buttons/rounded_corner_button.dart';
import 'package:amsl_app/widgets/dialogs/amsl_dialog.dart';
import 'package:amsl_app/widgets/error/error_bar.dart';
import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:gap/gap.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

class NewGoalData {
  String? id;
  String? name;
  String? description;
  bool fullfilled;

  NewGoalData({
    this.id,
    this.name,
    this.description,
    this.fullfilled = false,
  });
}

class CreateGoalCard extends HookWidget {
  const CreateGoalCard({super.key, required this.data, this.isEdit = false});

  final NewGoalData data;
  final bool isEdit;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    final nameController = useTextEditingController(text: data.name ?? '');
    final nameError = useState(false);
    final descriptionController = useTextEditingController(
      text: data.description ?? '',
    );
    final fullfilled = useState(data.fullfilled);

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
            controller: nameController,
            textCapitalization: TextCapitalization.sentences,
            style: theme.textTheme.bodyLarge,
            onChanged: (v) {
              data.name = v;
              nameError.value = false;
            },
            decoration: InputDecoration(
              hintText: 'Titel',
              errorText: nameError.value ? 'Bitte einen Titel eingeben' : null,
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
          if (isEdit) ...[
            const Gap(12),
            CheckboxListTile(
              value: fullfilled.value,
              onChanged: (v) {
                fullfilled.value = v ?? false;
                data.fullfilled = v ?? false;
              },
              controlAffinity: ListTileControlAffinity.leading,
              contentPadding: EdgeInsets.zero,
              title: Text('Erreicht', style: theme.textTheme.bodyMedium),
              activeColor: theme.colorScheme.secondary,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(12),
                side: BorderSide(
                  color: theme.colorScheme.outline.withValues(alpha: 0.4),
                ),
              ),
            ),
          ],
        ],
      ),
    );
  }
}

class CreateGoalSheet extends StatelessWidget {
  const CreateGoalSheet({super.key, required this.data, this.goal});

  final NewGoalData data;
  final PlannerGoal? goal;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return SingleChildScrollView(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Text(
            goal != null ? 'Ziel bearbeiten' : 'Neues Ziel',
            style: theme.textTheme.titleSmall?.copyWith(
              color: theme.colorScheme.onSurface.withValues(alpha: 0.5),
              letterSpacing: 0.5,
            ),
          ),
          const Gap(16),
          CreateGoalCard(data: data, isEdit: goal != null),
        ],
      ),
    );
  }
}

void showCreateGoalSheet(
  BuildContext context,
  WidgetRef ref, {
  PlannerGoal? goal,
}) {
  final theme = Theme.of(context);

  final data = NewGoalData(
    id: goal?.id,
    name: goal?.name,
    description: goal?.description,
    fullfilled: goal?.fullfilled ?? false,
  );

  Future<void> save() async {
    if (data.name == null || data.name!.trim().isEmpty) {
      showMessage(context, label: 'Bitte einen Titel eingeben', error: true);
      return;
    }

    final notifier = ref.read(goalPodProvider.notifier);

    if (goal != null) {
      await notifier.updateGoal(
        goal.id,
        name: data.name,
        fullfilled: data.fullfilled,
        description: data.description,
        clearDescription: data.description == null,
      );
    } else {
      await notifier.createGoal(name: data.name!, description: data.description);
    }
    if (context.mounted) Navigator.of(context).pop();
  }

  showAmslBottomSheet(
    context: context,
    child: CreateGoalSheet(data: data, goal: goal),
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
