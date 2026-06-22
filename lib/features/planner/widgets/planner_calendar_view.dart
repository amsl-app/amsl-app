import 'package:amsl_app/constants.dart';
import 'package:amsl_app/features/planner/providers/planner.dart';
import 'package:amsl_app/features/planner/widgets/planner_entry_tile.dart';
import 'package:amsl_app/models/hikari/planner/planner_entry.dart';
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
    final entriesAsync = ref.watch(plannerProviderProvider);

    final skeleton = Padding(
      padding: const EdgeInsets.fromLTRB(20, 8, 20, 0),
      child: SkeletonLoadingWidget(
        rows: 3,
        color: theme.colorScheme.tertiaryContainer,
      ),
    );

    return entriesAsync.build(
      context,
      loadingBuilder: (_) => skeleton,
      errorBuilder: (_, e, st) => skeleton,
      builder: (context, data) {
        final eventMap = groupEntriesByDay(data ?? []);
        List<PlannerEntry> entriesForDay(DateTime day) =>
            eventMap[DateTime(day.year, day.month, day.day)] ?? [];
        final selectedEntries = entriesForDay(selectedDay.value);

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
                markerDecoration: BoxDecoration(
                  color: theme.colorScheme.tertiary,
                  shape: BoxShape.circle,
                ),
                markersMaxCount: 3,
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
              child: selectedEntries.isEmpty
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
                  : ListView.builder(
                      padding: EdgeInsets.fromLTRB(
                        20,
                        12,
                        20,
                        getBottomBarHeight(context),
                      ),
                      itemCount: selectedEntries.length,
                      itemBuilder: (context, i) {
                        final entry = selectedEntries[i];
                        return PlannerEntryTile(entry: entry);
                      },
                    ),
            ),
          ],
        );
      },
    );
  }
}

