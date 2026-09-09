import 'package:flutter/material.dart';

/// Animated page indicator dots that jump to a page when tapped.
class PlannerPageDots extends StatelessWidget {
  const PlannerPageDots({
    super.key,
    required this.count,
    required this.currentPage,
    required this.controller,
  });

  final int count;
  final int currentPage;
  final PageController controller;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: List.generate(count, (i) {
        final selected = currentPage == i;
        return GestureDetector(
          onTap: () => controller.animateToPage(
            i,
            duration: const Duration(milliseconds: 300),
            curve: Curves.easeInOut,
          ),
          child: AnimatedContainer(
            duration: const Duration(milliseconds: 200),
            margin: const EdgeInsets.symmetric(horizontal: 3),
            width: selected ? 16 : 8,
            height: 8,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(4),
              color: selected
                  ? theme.colorScheme.primary
                  : theme.colorScheme.outline.withValues(alpha: 0.4),
            ),
          ),
        );
      }),
    );
  }
}
