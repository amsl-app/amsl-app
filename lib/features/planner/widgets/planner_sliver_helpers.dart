import 'package:flutter/material.dart';
import 'package:gap/gap.dart';

/// Wraps sliver content with the overlap injector required by the
/// enclosing NestedScrollView (see planner_screen.dart) so a planner tab's
/// scrolling merges into the same scroll as the header/tab bar above it.
Widget plannerSliverScrollView(BuildContext context, List<Widget> slivers) {
  return CustomScrollView(
    slivers: [
      SliverOverlapInjector(
        handle: NestedScrollView.sliverOverlapAbsorberHandleFor(context),
      ),
      ...slivers,
    ],
  );
}

/// Concatenates widget groups (e.g. goal/milestone/entry tiles for a day),
/// inserting a Gap(4) only between consecutive non-empty groups so an empty
/// group doesn't leave a stray gap.
List<Widget> intersperseGroups(List<List<Widget>> groups) {
  final result = <Widget>[];
  for (final group in groups.where((g) => g.isNotEmpty)) {
    if (result.isNotEmpty) result.add(const Gap(4));
    result.addAll(group);
  }
  return result;
}
