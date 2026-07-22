import 'package:amsl_app/constants.dart';
import 'package:amsl_app/features/planner/providers/milestone.dart';
import 'package:amsl_app/features/planner/providers/planner.dart';
import 'package:amsl_app/features/planner/providers/planner_configuration.dart';
import 'package:amsl_app/features/planner/widgets/planner_entry_tile.dart';
import 'package:amsl_app/features/planner/widgets/planner_milestone_tile.dart';
import 'package:amsl_app/models/tori/planner/planner_entry.dart';
import 'package:amsl_app/models/tori/planner/planner_milestone.dart';
import 'package:amsl_app/themes/planner_theme.dart';
import 'package:amsl_app/widgets/async_value_extension.dart';
import 'package:amsl_app/widgets/loading/skeleton_loading_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:table_calendar/table_calendar.dart';

class PlannerCalendarView extends HookConsumerWidget {
  const PlannerCalendarView({super.key, this.onDaySelected});

  final ValueChanged<DateTime>? onDaySelected;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final theme = Theme.of(context);
    final focusedDay = useState(DateTime.now());
    final selectedDay = useState(DateTime.now());
    final configAsync = ref.watch(plannerConfigPodProvider);

    final skeleton = Padding(
      padding: const EdgeInsets.fromLTRB(20, 8, 20, 0),
      child: SkeletonLoadingWidget(
        rows: 3,
        color: theme.colorScheme.tertiaryContainer,
      ),
    );

    return configAsync.build(
      context,
      loadingBuilder: (_) => skeleton,
      errorBuilder: (_, e, st) => skeleton,
      builder: (context, data) {
        final entriesByDay = groupEntriesByDay(data?.entries ?? []);
        final milestonesByDay = groupMilestonesByDay(
          data?.sortedMilestones ?? [],
        );
        List<PlannerEntry> entriesForDay(DateTime day) =>
            entriesByDay[DateTime(day.year, day.month, day.day)] ?? [];
        List<PlannerMilestone> milestonesForDay(DateTime day) =>
            milestonesByDay[DateTime(day.year, day.month, day.day)] ?? [];
        final selectedEntries = entriesForDay(selectedDay.value);
        final selectedMilestones = milestonesForDay(selectedDay.value);

        return Column(
          children: [
            TableCalendar<PlannerEntry>(
              firstDay: DateTime(2020),
              lastDay: DateTime(2100),
              focusedDay: focusedDay.value,
              selectedDayPredicate: (day) => isSameDay(day, selectedDay.value),
              eventLoader: entriesForDay,
              calendarStyle: CalendarStyle(
                selectedDecoration: BoxDecoration(
                  color: theme.colorScheme.tertiary,
                  shape: BoxShape.circle,
                ),
                todayDecoration: BoxDecoration(
                  color: theme.colorScheme.tertiaryContainer,
                  shape: BoxShape.circle,
                ),
                todayTextStyle: TextStyle(
                  color: theme.colorScheme.onTertiaryContainer,
                  fontWeight: FontWeight.bold,
                ),
              ),
              calendarBuilders: CalendarBuilders<PlannerEntry>(
                markerBuilder: (context, day, events) {
                  final hasMilestone = milestonesForDay(day).isNotEmpty;
                  if (events.isEmpty && !hasMilestone) return null;
                  return Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      ...events
                          .take(3)
                          .map(
                            (_) => Container(
                              width: 5,
                              height: 5,
                              margin: const EdgeInsets.symmetric(horizontal: 1),
                              decoration: BoxDecoration(
                                color: theme.colorScheme.tertiary,
                                shape: BoxShape.circle,
                              ),
                            ),
                          ),
                      if (hasMilestone)
                        Padding(
                          padding: const EdgeInsets.only(left: 1),
                          child: Icon(
                            Icons.star_rounded,
                            size: 7,
                            color: theme.plannerTheme.milestoneAccentBackground,
                          ),
                        ),
                    ],
                  );
                },
              ),
              headerStyle: HeaderStyle(
                formatButtonVisible: false,
                titleCentered: true,
                titleTextStyle: theme.textTheme.titleMedium!,
              ),
              onDaySelected: (selected, focused) {
                selectedDay.value = selected;
                focusedDay.value = focused;
                onDaySelected?.call(selected);
              },
              onPageChanged: (day) => focusedDay.value = day,
            ),
            const Divider(height: 1),
            Expanded(
              child: selectedEntries.isEmpty && selectedMilestones.isEmpty
                  ? Center(
                      child: Text(
                        'Keine Einträge für ${kNewDateFormat.format(selectedDay.value)}',
                        style: theme.textTheme.bodyMedium?.copyWith(
                          color: theme.colorScheme.onSurface.withValues(
                            alpha: 0.6,
                          ),
                        ),
                      ),
                    )
                  : ListView(
                      padding: EdgeInsets.fromLTRB(
                        20,
                        12,
                        20,
                        getBottomBarHeight(context),
                      ),
                      children: [
                        ...selectedMilestones.map(
                          (m) => PlannerMilestoneTile(milestone: m),
                        ),
                        ...selectedEntries.map(
                          (entry) => PlannerEntryTile(entry: entry),
                        ),
                      ],
                    ),
            ),
          ],
        );
      },
    );
  }
}
