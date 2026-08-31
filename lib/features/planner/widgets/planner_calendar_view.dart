import 'package:amsl_app/constants.dart';
import 'package:amsl_app/features/planner/providers/goals.dart';
import 'package:amsl_app/features/planner/providers/milestone.dart';
import 'package:amsl_app/features/planner/providers/planner.dart';
import 'package:amsl_app/features/planner/providers/planner_configuration.dart';
import 'package:amsl_app/features/planner/widgets/tiles/planner_entry_tile.dart';
import 'package:amsl_app/features/planner/widgets/tiles/planner_goal_tile.dart';
import 'package:amsl_app/features/planner/widgets/tiles/planner_milestone_tile.dart';
import 'package:amsl_app/models/tori/planner/planner_entry.dart';
import 'package:amsl_app/models/tori/planner/planner_goal.dart';
import 'package:amsl_app/models/tori/planner/planner_milestone.dart';
import 'package:amsl_app/themes/planner_theme.dart';
import 'package:amsl_app/widgets/async_value_extension.dart';
import 'package:amsl_app/widgets/loading/skeleton_loading_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:gap/gap.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:table_calendar/table_calendar.dart';

class PlannerCalendarView extends HookConsumerWidget {
  const PlannerCalendarView({super.key, this.onDaySelected});

  final ValueChanged<DateTime>? onDaySelected;

  static DateTime _weekStart(DateTime day) {
    final normalized = DateTime(day.year, day.month, day.day);
    return normalized.subtract(
      Duration(days: (normalized.weekday - DateTime.monday) % 7),
    );
  }

  // Wraps sliver content with the overlap injector required by the
  // enclosing NestedScrollView (see planner_screen.dart) so this tab's
  // scrolling merges into the same scroll as the header/tab bar above it.
  Widget _sliverScrollView(BuildContext context, List<Widget> slivers) {
    return CustomScrollView(
      slivers: [
        SliverOverlapInjector(
          handle: NestedScrollView.sliverOverlapAbsorberHandleFor(context),
        ),
        ...slivers,
      ],
    );
  }

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final theme = Theme.of(context);
    final focusedDay = useState(DateTime.now());
    final selectedDay = useState(DateTime.now());
    final calendarFormat = useState(CalendarFormat.month);
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
      loadingBuilder: (_) =>
          _sliverScrollView(context, [SliverToBoxAdapter(child: skeleton)]),
      errorBuilder: (_, e, st) =>
          _sliverScrollView(context, [SliverToBoxAdapter(child: skeleton)]),
      builder: (context, data) {
        final entriesByDay = groupEntriesByDay(data?.entries ?? []);
        final milestonesByDay = groupMilestonesByDay(
          data?.sortedMilestones ?? [],
        );
        final goalsByDay = groupGoalsByDay(data?.goals.values ?? []);
        List<PlannerEntry> entriesForDay(DateTime day) =>
            entriesByDay[DateTime(day.year, day.month, day.day)] ?? [];
        List<PlannerMilestone> milestonesForDay(DateTime day) =>
            milestonesByDay[DateTime(day.year, day.month, day.day)] ?? [];
        List<PlannerGoal> goalsForDay(DateTime day) =>
            goalsByDay[DateTime(day.year, day.month, day.day)] ?? [];
        final selectedEntries = entriesForDay(selectedDay.value);
        final selectedMilestones = milestonesForDay(selectedDay.value);
        final selectedGoals = goalsForDay(selectedDay.value);
        final isWeekView = calendarFormat.value == CalendarFormat.week;
        final panelDays = isWeekView
            ? List.generate(
                7,
                (i) => _weekStart(selectedDay.value).add(Duration(days: i)),
              )
            : [selectedDay.value];
        final hasAnyItems = panelDays.any(
          (d) =>
              entriesForDay(d).isNotEmpty ||
              milestonesForDay(d).isNotEmpty ||
              goalsForDay(d).isNotEmpty,
        );

        final calendar = TableCalendar<PlannerEntry>(
          firstDay: DateTime(2020),
          lastDay: DateTime(2100),
          focusedDay: focusedDay.value,
          calendarFormat: calendarFormat.value,
          availableGestures: AvailableGestures.horizontalSwipe,
          availableCalendarFormats: const {
            CalendarFormat.month: 'Tag',
            CalendarFormat.week: 'Woche',
          },
          onFormatChanged: (format) {
            calendarFormat.value = format;
            if (format == CalendarFormat.week) {
              selectedDay.value = focusedDay.value;
              onDaySelected?.call(focusedDay.value);
            } else {
              final firstOfMonth = DateTime(
                focusedDay.value.year,
                focusedDay.value.month,
              );
              selectedDay.value = firstOfMonth;
              onDaySelected?.call(firstOfMonth);
            }
          },
          startingDayOfWeek: StartingDayOfWeek.monday,
          selectedDayPredicate: (day) => isWeekView
              ? isSameDay(_weekStart(day), _weekStart(selectedDay.value))
              : isSameDay(day, selectedDay.value),
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
              final hasGoal = goalsForDay(day).isNotEmpty;
              if (events.isEmpty && !hasMilestone && !hasGoal) return null;
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
                  if (hasGoal)
                    Padding(
                      padding: const EdgeInsets.only(left: 1),
                      child: Icon(
                        Icons.emoji_events_outlined,
                        size: 7,
                        color: theme.colorScheme.onSurface.withValues(
                          alpha: 0.6,
                        ),
                      ),
                    ),
                ],
              );
            },
          ),
          headerStyle: HeaderStyle(
            titleCentered: true,
            titleTextStyle: theme.textTheme.titleMedium!,
            formatButtonDecoration: BoxDecoration(
              color: theme.colorScheme.tertiaryContainer,
              borderRadius: BorderRadius.circular(12),
            ),
            formatButtonTextStyle: TextStyle(
              color: theme.colorScheme.onTertiaryContainer,
            ),
          ),
          onDaySelected: (selected, focused) {
            selectedDay.value = selected;
            focusedDay.value = focused;
            onDaySelected?.call(selected);
          },
          onPageChanged: (day) {
            focusedDay.value = day;
            final newSelection = isWeekView
                ? day
                : DateTime(day.year, day.month);
            selectedDay.value = newSelection;
            onDaySelected?.call(newSelection);
          },
        );

        final dayItems = isWeekView
            ? [
                for (final day in panelDays)
                  if (entriesForDay(day).isNotEmpty ||
                      milestonesForDay(day).isNotEmpty ||
                      goalsForDay(day).isNotEmpty) ...[
                    Padding(
                      padding: const EdgeInsets.only(top: 12, bottom: 4),
                      child: Text(
                        kNewDateFormat.format(day),
                        style: theme.textTheme.labelLarge?.copyWith(
                          color: theme.colorScheme.onTertiaryContainer,
                        ),
                      ),
                    ),
                    ...milestonesForDay(
                      day,
                    ).map((m) => PlannerMilestoneTile(milestone: m)),
                    ...goalsForDay(day).map((g) => PlannerGoalTile(goal: g)),
                    ...entriesForDay(
                      day,
                    ).map((entry) => PlannerEntryTile(entry: entry)),
                  ],
              ]
            : [
                ...selectedGoals.map((g) => PlannerGoalTile(goal: g)),
                const Gap(4),
                ...selectedMilestones.map(
                  (m) => PlannerMilestoneTile(milestone: m),
                ),
                const Gap(4),
                ...selectedEntries.map(
                  (entry) => PlannerEntryTile(entry: entry),
                ),
              ];

        return _sliverScrollView(context, [
          SliverToBoxAdapter(child: calendar),
          if (!hasAnyItems)
            SliverFillRemaining(
              hasScrollBody: false,
              child: Center(
                child: Text(
                  isWeekView
                      ? 'Keine Aktivitäten für ${kNewDateFormat.format(panelDays.first)} - ${kNewDateFormat.format(panelDays.last)}'
                      : 'Keine Aktivitäten für ${kNewDateFormat.format(selectedDay.value)}',
                  style: theme.textTheme.bodyMedium?.copyWith(
                    color: theme.colorScheme.onSurface.withValues(alpha: 0.6),
                  ),
                ),
              ),
            )
          else
            SliverPadding(
              padding: EdgeInsets.fromLTRB(
                20,
                12,
                20,
                getBottomBarHeight(context),
              ),
              sliver: SliverList(delegate: SliverChildListDelegate(dayItems)),
            ),
        ]);
      },
    );
  }
}
