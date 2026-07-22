import 'package:amsl_app/constants.dart';
import 'package:amsl_app/features/planner/widgets/create_entry_sheet.dart';
import 'package:amsl_app/features/planner/widgets/create_milestone_sheet.dart';
import 'package:amsl_app/features/planner/widgets/planner_assistant_sheet.dart';
import 'package:amsl_app/features/planner/widgets/planner_calendar_view.dart';
import 'package:amsl_app/features/planner/widgets/planner_ical_sheet.dart';
import 'package:amsl_app/features/planner/widgets/planner_list_view.dart';
import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:gap/gap.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

class PlannerScreen extends HookConsumerWidget {
  const PlannerScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final theme = Theme.of(context);
    final tabController = useTabController(initialLength: 2);
    final selectedDate = useState(DateTime.now());

    return Scaffold(
      backgroundColor: theme.colorScheme.tertiaryContainer,
      appBar: AppBar(
        scrolledUnderElevation: 0.0,
        elevation: 0.0,
        backgroundColor: theme.colorScheme.tertiaryContainer,
        title: Align(
          alignment: Alignment.centerLeft,
          child: Text(
            'Planner',
            style: TextStyle(color: theme.colorScheme.onTertiaryContainer),
          ),
        ),
        actions: [
          IconButton(
            onPressed: () => showPlannerIcalSheet(context, ref),
            icon: Icon(
              Icons.calendar_month_outlined,
              color: theme.colorScheme.onTertiaryContainer,
            ),
            tooltip: 'Kalender abonnieren',
          ),
          PopupMenuButton<void>(
            tooltip: 'Hinzufügen',
            icon: Icon(Icons.add, color: theme.colorScheme.onTertiaryContainer),
            itemBuilder: (context) => [
              PopupMenuItem(
                onTap: () => showCreateEntrySheet(
                  context,
                  ref,
                  initialDate: tabController.index == 1
                      ? selectedDate.value
                      : null,
                ),
                child: Row(
                  children: [
                    Icon(
                      Icons.checklist_rtl,
                      color: theme.colorScheme.onSurface,
                    ),
                    const Gap(8.0),
                    Text('Neuer Eintrag', style: theme.textTheme.bodyMedium),
                  ],
                ),
              ),
              PopupMenuItem(
                onTap: () => showCreateMilestoneSheet(
                  context,
                  ref,
                  initialDate: tabController.index == 1
                      ? selectedDate.value
                      : null,
                ),
                child: Row(
                  children: [
                    Icon(
                      Icons.flag_rounded,
                      color: theme.colorScheme.onSurface,
                    ),
                    const Gap(8.0),
                    Text(
                      'Neuer Meilenstein',
                      style: theme.textTheme.bodyMedium,
                    ),
                  ],
                ),
              ),
            ],
          ),
        ],
        bottom: TabBar(
          controller: tabController,
          indicatorColor: theme.colorScheme.tertiary,
          labelColor: theme.colorScheme.onTertiaryContainer,
          unselectedLabelColor: theme.colorScheme.onTertiaryContainer
              .withValues(alpha: 0.5),
          dividerColor: Colors.transparent,
          tabs: const [
            Tab(text: 'Liste'),
            Tab(text: 'Kalender'),
          ],
        ),
      ),
      floatingActionButton: Padding(
        padding: EdgeInsets.only(bottom: getBottomBarPadding(context)),
        child: FloatingActionButton(
          onPressed: () => showPlannerAssistantSheet(context, ref),
          backgroundColor: theme.colorScheme.tertiary,
          foregroundColor: theme.colorScheme.onTertiary,
          child: const Icon(Icons.auto_fix_high),
        ),
      ),
      body: TabBarView(
        controller: tabController,
        children: [
          const PlannerListView(),
          PlannerCalendarView(onDaySelected: (day) => selectedDate.value = day),
        ],
      ),
    );
  }
}
