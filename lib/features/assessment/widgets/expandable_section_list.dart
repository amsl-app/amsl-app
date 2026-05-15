import 'package:amsl_app/constants.dart';
import 'package:flutter/material.dart';
import 'package:gap/gap.dart';

class ExpandableSectionList extends StatefulWidget {
  final List<ExpandableSection> children;
  final double gap;
  final int startIndex;

  const ExpandableSectionList({
    super.key,
    required this.children,
    this.gap = 20.0,
    this.startIndex = 0,
  });

  @override
  State<ExpandableSectionList> createState() => _ExpandableSectionListState();
}

class _ExpandableSectionListState extends State<ExpandableSectionList> {
  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Column(
      children: List.generate(((widget.children.length * 2)), (index) {
        if (index == (widget.children.length * 2) - 1) {
          return Gap(getBottomBarPadding(context));
        }
        if (index % 2 == 0) {
          int childIndex = index ~/ 2;
          ExpandableSection section = widget.children[childIndex];
          return ClipRRect(
            borderRadius: BorderRadius.circular(12),
            child: Container(
              color: const Color.fromRGBO(240, 240, 240, 1.0),
              width: double.infinity,
              child: Padding(
                padding: const EdgeInsets.all(12.0),
                child: Theme(
                  data: theme.copyWith(dividerColor: Colors.transparent),
                  child: ExpansionTile(
                    initiallyExpanded: (widget.startIndex == childIndex),
                    title: Text(
                      section.label,
                      style: theme.textTheme.titleLarge,
                    ),
                    children: [const Gap(20), section.child],
                  ),
                ),
              ),
            ),
          );
        }
        return Gap(widget.gap);
      }),
    );
  }
}

class ExpandableSection {
  final String label;
  final Widget child;

  ExpandableSection({required this.label, required this.child});
}
