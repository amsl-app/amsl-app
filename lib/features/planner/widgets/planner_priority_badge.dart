import 'package:amsl_app/themes/planner_theme.dart';
import 'package:flutter/material.dart';

class PlannerPriorityBadge extends StatelessWidget {
  const PlannerPriorityBadge({super.key, required this.priority});

  final int priority;

  String _label() => switch (priority) {
    1 => 'Niedrig',
    2 => 'Mittel',
    _ => 'Hoch',
  };

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final planner = theme.plannerTheme;
    final (bg, fg) = switch (priority) {
      1 => (planner.lowPriorityBackground, planner.lowPriorityForeground),
      2 => (planner.mediumPriorityBackground, planner.mediumPriorityForeground),
      _ => (planner.highPriorityBackground, planner.highPriorityForeground),
    };
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 2),
      decoration: BoxDecoration(
        color: bg,
        borderRadius: BorderRadius.circular(20),
      ),
      child: Text(
        _label(),
        style: theme.textTheme.labelSmall?.copyWith(
          color: fg,
          fontWeight: FontWeight.bold,
        ),
      ),
    );
  }
}
