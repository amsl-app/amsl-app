import 'package:amsl_app/constants.dart';
import 'package:amsl_app/features/planner/providers/planner.dart';
import 'package:amsl_app/features/planner/providers/planner_configuration.dart';
import 'package:amsl_app/features/planner/widgets/planner_page_dots.dart';
import 'package:amsl_app/features/planner/models/new_planner_entry.dart';
import 'package:amsl_app/models/tori/planner/planner_entry.dart';
import 'package:amsl_app/models/tori/planner/planner_milestone.dart';
import 'package:amsl_app/widgets/buttons/rounded_corner_button.dart';
import 'package:amsl_app/widgets/dialogs/amsl_dialog.dart';
import 'package:amsl_app/widgets/error/error_bar.dart';
import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:gap/gap.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

class NewEntryData {
  String? id;
  String? title;
  DateTime date;
  int priority;
  String? milestoneId;

  NewEntryData({
    this.id,
    this.title,
    required this.date,
    this.priority = 2,
    this.milestoneId,
  });
}

class CreateEntryCard extends HookWidget {
  const CreateEntryCard({
    super.key,
    required this.entry,
    required this.milestones,
  });
  final List<PlannerMilestone> milestones;
  final NewEntryData entry;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    // Pre-resolve milestone for edit mode so useState gets the right initial value.
    final initMilestone = entry.milestoneId == null
        ? null
        : milestones.where((m) => m.id == entry.milestoneId).firstOrNull;

    final titleController = useTextEditingController(text: entry.title ?? '');
    final titleError = useState(false);
    final selectedDate = useState(entry.date);
    final priority = useState(entry.priority);

    final selectedMilestone = useState<PlannerMilestone?>(initMilestone);

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
              entry.title = v;
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
                entry.date = picked;
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
          SegmentedButton<int>(
            style: SegmentedButton.styleFrom(
              selectedBackgroundColor: theme.colorScheme.primary,
              selectedForegroundColor: theme.colorScheme.onPrimary,
              foregroundColor: theme.colorScheme.onSurface.withValues(
                alpha: 0.7,
              ),
              side: BorderSide(
                color: theme.colorScheme.outline.withValues(alpha: 0.4),
              ),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(12),
              ),
            ),
            segments: const [
              ButtonSegment(value: 1, label: Text('Niedrig')),
              ButtonSegment(value: 2, label: Text('Mittel')),
              ButtonSegment(value: 3, label: Text('Hoch')),
            ],
            selected: {priority.value},
            onSelectionChanged: (s) {
              priority.value = s.first;
              entry.priority = s.first;
            },
            showSelectedIcon: false,
          ),
          if (milestones.isNotEmpty) ...[
            const Gap(12),
            DropdownButtonFormField<PlannerMilestone?>(
              isExpanded: true,
              initialValue: selectedMilestone.value,
              decoration: InputDecoration(
                labelText: 'Meilenstein (optional)',
                border: inputBorder,
                enabledBorder: inputBorder,
                focusedBorder: focusedBorder,
                contentPadding: const EdgeInsets.symmetric(
                  horizontal: 12,
                  vertical: 10,
                ),
              ),
              items: [
                DropdownMenuItem(
                  value: null,
                  child: Text('Keiner', style: theme.textTheme.bodySmall),
                ),
                ...milestones.map(
                  (m) => DropdownMenuItem(
                    value: m,
                    child: Text(
                      m.title,
                      style: theme.textTheme.bodySmall,
                      overflow: TextOverflow.ellipsis,
                    ),
                  ),
                ),
              ],
              onChanged: (m) {
                selectedMilestone.value = m;
                entry.milestoneId = m?.id;
              },
            ),
          ],
        ],
      ),
    );
  }
}

class CreateEntrySheet extends HookConsumerWidget {
  const CreateEntrySheet({
    super.key,
    required this.newEntries,
    required this.initialDate,
    this.entry,
  });

  final DateTime? initialDate;
  final PlannerEntry? entry;
  final List<NewEntryData> newEntries;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final theme = Theme.of(context);

    useMemoized(() {
      if (entry != null) {
        newEntries.add(
          NewEntryData(
            id: entry!.id,
            title: entry!.title,
            date: entry!.scheduledDate,
            priority: entry!.priority,
            milestoneId: entry!.milestone?.id,
          ),
        );
      } else {
        newEntries.add(NewEntryData(date: initialDate ?? DateTime.now()));
      }
    });

    final plannerConfig = ref.watch(plannerConfigPodProvider);
    final milestones = plannerConfig.value?.sortedMilestones ?? [];

    // Edit mode: single card, no carousel.
    if (entry != null) {
      return SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Text(
              'Eintrag bearbeiten',
              style: theme.textTheme.titleSmall?.copyWith(
                color: theme.colorScheme.onSurface.withValues(alpha: 0.5),
                letterSpacing: 0.5,
              ),
            ),
            const Gap(16),
            CreateEntryCard(entry: newEntries.first, milestones: milestones),
          ],
        ),
      );
    }

    // Create mode: carousel with the ability to add new cards.
    // PageView requires a bounded height; we use a screen fraction so it
    // adapts across device sizes. The column uses spaceBetween so the dots
    // and add-button are evenly distributed in the remaining space below.
    final pageController = usePageController();
    final currentPage = useState(0);
    final entryCount = useState(1);
    final pageViewHeight = MediaQuery.sizeOf(context).height * 0.34;

    return Column(
      mainAxisSize: MainAxisSize.min,
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        SizedBox(
          height: pageViewHeight,
          child: PageView.builder(
            controller: pageController,
            onPageChanged: (i) => currentPage.value = i,
            itemCount: entryCount.value,
            itemBuilder: (_, i) => SingleChildScrollView(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  Text(
                    'Neuer Eintrag #${i + 1}',
                    style: theme.textTheme.titleSmall?.copyWith(
                      color: theme.colorScheme.onSurface.withValues(alpha: 0.5),
                      letterSpacing: 0.5,
                    ),
                  ),
                  const Gap(8),
                  CreateEntryCard(entry: newEntries[i], milestones: milestones),
                ],
              ),
            ),
          ),
        ),
        if (entryCount.value > 1) ...[
          const Gap(8),
          PlannerPageDots(
            count: entryCount.value,
            currentPage: currentPage.value,
            controller: pageController,
          ),
        ],
        const Gap(8),
        TextButton.icon(
          icon: const Icon(Icons.add, size: 18),
          label: const Text('Weiteren Eintrag hinzufügen'),
          onPressed: () {
            newEntries.add(NewEntryData(date: initialDate ?? DateTime.now()));
            entryCount.value = newEntries.length;
            WidgetsBinding.instance.addPostFrameCallback((_) {
              pageController.animateToPage(
                newEntries.length - 1,
                duration: const Duration(milliseconds: 300),
                curve: Curves.easeInOut,
              );
            });
          },
        ),
      ],
    );
  }
}

void showCreateEntrySheet(
  BuildContext context,
  WidgetRef ref, {
  DateTime? initialDate,
  PlannerEntry? entry,
}) {
  final theme = Theme.of(context);

  Future<void> save(List<NewEntryData> newEntries) async {
    final invalid = newEntries.where(
      (e) => e.title == null || e.title!.trim().isEmpty,
    );
    if (invalid.isNotEmpty) {
      showMessage(context, label: 'Bitte einen Titel eingeben', error: true);
      return;
    }

    final notifier = ref.read(plannerPodProvider.notifier);

    if (newEntries.length == 1 && entry != null) {
      // Single entry in edit mode, just update it.
      final e = newEntries.first;
      await notifier.updateEntry(
        e.id!,
        date: kOldDateFormat.format(e.date),
        title: e.title,
        priority: e.priority,
        milestoneId: e.milestoneId,
        clearMilestone: e.milestoneId == null,
      );
      if (context.mounted) Navigator.of(context).pop();
      return;
    }

    await notifier.createEntries(
      newEntries
          .where((e) => e.id == null)
          .map(
            (e) => NewPlannerEntry(
              date: kOldDateFormat.format(e.date),
              title: e.title!,
              priority: e.priority,
              milestoneId: e.milestoneId,
            ),
          )
          .toList(),
    );
    if (context.mounted) Navigator.of(context).pop();
  }

  List<NewEntryData> newEntries = [];
  showAmslBottomSheet(
    context: context,
    child: CreateEntrySheet(
      entry: entry,
      initialDate: initialDate,
      newEntries: newEntries,
    ),
    onClose: () => Navigator.of(context).pop(),
    bottomBar: true,
    buttonBar: [
      RoundedCornerButton(
        label: 'Speichern',
        onTap: () => save(newEntries),
        buttonColor: theme.colorScheme.primary,
        labelColor: theme.colorScheme.onPrimary,
      ),
    ],
  );
}
