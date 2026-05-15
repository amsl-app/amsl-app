import 'package:amsl_app/features/tools_common/widgets/tool_card.dart';
import 'package:amsl_app/utils.dart';
import 'package:flutter/material.dart';
import 'package:gap/gap.dart';

class ToolList extends StatelessWidget {
  const ToolList({super.key, required this.tools, required this.onTap});

  final Iterable<Tool> tools;
  final Function(Tool) onTap;

  GestureTapCallback _createOnTap(Tool tool) {
    return () => onTap(tool);
  }

  Widget _buildRow(List<Tool> tools, int perRow, _) {
    const gap = Gap(24);
    final List<Widget> children;

    children = generateInterrupted(
      tools,
      (tool, _) => Expanded(child: ToolCard(tool, onTap: _createOnTap(tool))),
      gap,
      growable: true,
    );

    // Fill up with placeholders to make each row equal in length
    for (var i = tools.length; i < perRow; i++) {
      children.add(gap);
      children.add(Expanded(child: Container()));
    }

    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: children,
    );
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    if (tools.isEmpty) {
      return Text("Keine Tools gefunden", style: theme.textTheme.titleLarge);
    }
    final List<Widget> children = generateInterruptedMulti(
      tools,
      _buildRow,
      const Gap(24),
      perRow: 2,
    );

    return Column(children: children);
  }
}
