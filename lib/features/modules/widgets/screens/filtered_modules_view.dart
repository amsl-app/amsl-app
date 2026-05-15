import 'package:amsl_app/models/tori/modules/module_group.dart';
import 'package:amsl_app/widgets/section_header.dart';
import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:go_router/go_router.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

import '../../../../models/tori/modules/module_assessment.dart';
import '../vertical_module_list.dart';

class FilteredModulesView extends StatelessWidget {
  final String keyword;
  final Iterable<(ModuleGroup, List<ModuleAssessmentSet>)> modulesByGroups;

  const FilteredModulesView({
    super.key,
    required this.modulesByGroups,
    required this.keyword,
  });

  @override
  Widget build(BuildContext context) {
    final filteredModules = filterModules(keyword);
    return ListView(
      children: [
        for (final (group, moudles) in filteredModules)
          _buildSubList(context, group, moudles),
      ],
    );
  }

  Widget _buildSubList(
    BuildContext context,
    ModuleGroup group,
    List<ModuleAssessmentSet> modules,
  ) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        SectionHeader(text: group.label.toUpperCase()),
        const Gap(12),
        Consumer(
          builder: (context, ref, child) {
            return VerticalModuleList(
              modules: modules,
              onTap: (module) {
                if (context.mounted) {
                  context.pushNamed(
                    "module",
                    pathParameters: {"moduleID": module.module.id},
                  );
                }
              },
            );
          },
        ),
      ],
    );
  }

  Iterable<(ModuleGroup, List<ModuleAssessmentSet>)> filterModules(
    String keyword,
  ) {
    final filteredModules = <(ModuleGroup, List<ModuleAssessmentSet>)>[];
    for (final (group, moudles) in modulesByGroups) {
      final modules = List<ModuleAssessmentSet>.from(moudles);
      if (keyword.isNotEmpty) {
        for (int i = 0; i < modules.length; i++) {
          if (!modules[i].module.title.toLowerCase().contains(
            keyword.toLowerCase(),
          )) {
            modules.removeAt(i);
            i--;
          }
        }
      }
      filteredModules.add((group, modules));
    }
    return filteredModules;
  }
}
