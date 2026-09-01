import 'package:amsl_app/constants.dart';
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
  DateTime date;
  bool fulfilled;

  NewGoalData({
    this.id,
    this.name,
    this.description,
    required this.date,
    this.fulfilled = false,
  });
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
    date: goal?.date ?? DateTime.now(),
    fulfilled: goal?.fulfilled ?? false,
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
        date: kOldDateFormat.format(data.date),
        fulfilled: data.fulfilled,
        description: data.description,
        clearDescription: data.description == null,
      );
    } else {
      await notifier.createGoal(
        name: data.name!,
        date: kOldDateFormat.format(data.date),
        description: data.description,
      );
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
          if (goal == null) ...[const Gap(12), const _SmartGoalsInfoBox()],
          const Gap(16),
          CreateGoalCard(data: data, isEdit: goal != null),
        ],
      ),
    );
  }
}

class CreateGoalCard extends StatefulWidget {
  const CreateGoalCard({super.key, required this.data, this.isEdit = false});

  final NewGoalData data;
  final bool isEdit;

  @override
  State<CreateGoalCard> createState() => _CreateGoalCardState();
}

class _CreateGoalCardState extends State<CreateGoalCard> {
  late final _nameController = TextEditingController(
    text: widget.data.name ?? '',
  );

  late final _descriptionController = TextEditingController(
    text: widget.data.description ?? '',
  );

  @override
  void dispose() {
    _nameController.dispose();
    _descriptionController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final data = widget.data;

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
            controller: _nameController,
            textCapitalization: TextCapitalization.sentences,
            style: theme.textTheme.bodyLarge,
            onChanged: (v) {
              data.name = v;
            },
            decoration: InputDecoration(
              hintText: 'Titel',
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
            controller: _descriptionController,
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
                initialDate: data.date,
                firstDate: DateTime(2020),
                lastDate: DateTime(2100),
              );
              if (picked != null) {
                setState(() => data.date = picked);
              }
            },
            icon: Icon(
              Icons.calendar_today,
              size: 16,
              color: theme.colorScheme.onSurface.withValues(alpha: 0.5),
            ),
            label: Text(
              kNewDateFormat.format(data.date),
              style: theme.textTheme.bodyLarge,
            ),
          ),
          if (widget.isEdit) ...[
            const Gap(12),
            CheckboxListTile(
              value: data.fulfilled,
              onChanged: (v) {
                setState(() => data.fulfilled = v ?? false);
              },
              controlAffinity: ListTileControlAffinity.leading,
              contentPadding: EdgeInsets.zero,
              title: Text('Erreicht', style: theme.textTheme.bodyMedium),
              activeColor: theme.colorScheme.primary,
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

class _SmartGoalsInfoBox extends HookWidget {
  const _SmartGoalsInfoBox();

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final expanded = useState(false);

    return InkWell(
      borderRadius: BorderRadius.circular(12),
      onTap: () => expanded.value = !expanded.value,
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 10),
        decoration: BoxDecoration(
          color: theme.colorScheme.tertiaryContainer.withValues(alpha: 0.4),
          borderRadius: BorderRadius.circular(12),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                Icon(
                  Icons.info_outline,
                  size: 18,
                  color: theme.colorScheme.onTertiaryContainer,
                ),
                const Gap(8),
                Expanded(
                  child: Text(
                    'Was macht ein SMARTes Ziel aus?',
                    style: theme.textTheme.bodySmall?.copyWith(
                      color: theme.colorScheme.onTertiaryContainer,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ),
                Icon(
                  expanded.value ? Icons.expand_less : Icons.expand_more,
                  size: 20,
                  color: theme.colorScheme.onTertiaryContainer,
                ),
              ],
            ),
            AnimatedCrossFade(
              firstChild: const SizedBox(width: double.infinity),
              secondChild: Padding(
                padding: const EdgeInsets.only(top: 8),
                child: Text(
                  'SMART Ziele sind eine Methode zur Zielsetzung, die '
                  'sicherstellt, dass Ziele klar und erreichbar formuliert '
                  'sind. SMART steht für:\n'
                  '1. Spezifisch: Das Ziel sollte klar und eindeutig sein.\n'
                  '2. Messbar: Es sollte möglich sein, den Fortschritt zu '
                  'messen.\n'
                  '3. Attraktiv: Das Ziel sollte motivierend und '
                  'realistisch sein.\n'
                  '4. Relevant: Das Ziel sollte für dich von Bedeutung '
                  'sein.\n'
                  '5. Terminiert: Es sollte ein klarer Zeitrahmen für die '
                  'Erreichung des Ziels festgelegt werden',
                  style: theme.textTheme.bodySmall?.copyWith(
                    color: theme.colorScheme.onTertiaryContainer,
                  ),
                ),
              ),
              crossFadeState: expanded.value
                  ? CrossFadeState.showSecond
                  : CrossFadeState.showFirst,
              duration: const Duration(milliseconds: 200),
            ),
          ],
        ),
      ),
    );
  }
}
