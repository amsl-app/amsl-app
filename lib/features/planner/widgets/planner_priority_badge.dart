import 'package:flutter/material.dart';

class PlannerPriorityBadge extends StatelessWidget {
  const PlannerPriorityBadge({super.key, required this.priority});

  final int priority;

  Color _bg() => switch (priority) {
    1 => const Color(0xFFE8F5E9),
    2 => const Color(0xFFFFF3E0),
    _ => const Color(0xFFFFEBEE),
  };

  Color _fg() => switch (priority) {
    1 => const Color(0xFF2E7D32),
    2 => const Color(0xFFE65100),
    _ => const Color(0xFFC62828),
  };

  String _label() => switch (priority) {
    1 => 'Niedrig',
    2 => 'Mittel',
    _ => 'Hoch',
  };

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 2),
      decoration: BoxDecoration(
        color: _bg(),
        borderRadius: BorderRadius.circular(20),
      ),
      child: Text(
        _label(),
        style: Theme.of(context).textTheme.labelSmall?.copyWith(
          color: _fg(),
          fontWeight: FontWeight.bold,
        ),
      ),
    );
  }
}
