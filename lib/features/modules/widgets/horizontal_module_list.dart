import 'package:amsl_app/utils.dart';
import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:logging/logging.dart';

import '../../../models/tori/modules/module.dart';
import '../../../models/tori/modules/module_assessment.dart';
import 'module_card.dart';

class HorizontalModuleList extends StatelessWidget {
  static final log = Logger("HorizontalModuleList");

  const HorizontalModuleList({super.key, this.onTap, required this.modules});

  final Function(Module)? onTap;
  final List<ModuleAssessmentSet> modules;

  VoidCallback? _createOnTap(Module session) {
    if (onTap != null) {
      return () => onTap!(session);
    }
    return null;
  }

  @override
  Widget build(BuildContext context) {
    final baseTheme = Theme.of(context);
    final List<Widget> children =
        generateInterrupted<ModuleAssessmentSet, Widget>(
          modules.where((module) => module.module.hide == false),
          (module, _) {
            final moduleTheme = module.module.theme;
            ThemeData theme = baseTheme;
            if (moduleTheme != null) {
              theme = theme.copyWith(
                extensions: (Map<Object, ThemeExtension<dynamic>>.from(
                  theme.extensions,
                )..[moduleTheme.type] = moduleTheme).values,
              );
            }
            return SizedBox(
              width: 330,
              child: Theme(
                data: theme,
                child: ModuleCard(
                  module: module,
                  onTap: _createOnTap(module.module),
                ),
              ),
            );
          },
          const Gap(16),
          growable: true,
        );
    children.insert(0, const Gap(20));
    children.add(const Gap(20));
    return ListView(
      shrinkWrap: true,
      scrollDirection: Axis.horizontal,
      physics: const BouncingScrollPhysics(
        parent: RangeMaintainingScrollPhysics(
          parent: AlwaysScrollableScrollPhysics(),
        ),
      ),
      children: children,
    );
  }
}
