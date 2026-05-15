import 'package:flutter/material.dart';
import 'package:gap/gap.dart';

import '../../../models/tori/modules/module_assessment.dart';
import 'module_card.dart';

class VerticalModuleList extends StatelessWidget {
  final List<ModuleAssessmentSet> modules;

  const VerticalModuleList({super.key, this.onTap, required this.modules});

  final Function(ModuleAssessmentSet)? onTap;

  VoidCallback? _createOnTap(ModuleAssessmentSet module) {
    if (onTap != null) {
      return () => onTap!(module);
    }
    return null;
  }

  @override
  Widget build(BuildContext context) {
    final baseTheme = Theme.of(context);

    const aspectRatio = 327.0 / 126.0;
    final List<Widget> children = [];
    for (ModuleAssessmentSet module in modules.where(
      (module) => !module.module.hide,
    )) {
      final moduleTheme = module.module.theme;
      ThemeData theme = baseTheme;
      if (moduleTheme != null) {
        theme = theme.copyWith(
          extensions: (Map<Object, ThemeExtension<dynamic>>.from(
            theme.extensions,
          )..[moduleTheme.type] = moduleTheme).values,
        );
      }
      children.add(
        AspectRatio(
          aspectRatio: aspectRatio,
          child: Theme(
            data: theme,
            child: ModuleCard(module: module, onTap: _createOnTap(module)),
          ),
        ),
      );
      children.add(const Gap(30));
    }

    if (modules.isEmpty) {
      return Padding(
        padding: const EdgeInsets.only(bottom: 30.0),
        child: Text("Keine Ergebnisse", style: baseTheme.textTheme.titleLarge),
      );
    }

    return Column(children: children);
  }
}
