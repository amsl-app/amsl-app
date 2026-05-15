import 'package:amsl_app/features/modules/providers/module_group.dart';
import 'package:amsl_app/hikari/hikari.dart';
import 'package:amsl_app/providers/hikari_provider.dart';
import 'package:collection/collection.dart';
import 'package:logging/logging.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

import '../../../models/hikari/modules/module_category.dart';
import '../../../models/tori/modules/module_assessment.dart';
import '../../../models/tori/modules/module_configuration.dart';
import '../../../models/tori/modules/module_group.dart';
import 'module_provider.dart';

part 'module_configuration.g.dart';

@Riverpod(
  keepAlive: true,
  dependencies: [HikariPod, ModuleNotifier, ModuleGroupsProvider],
)
class ModuleConfigurationProvider extends _$ModuleConfigurationProvider {
  static final log = Logger("Modules");

  @override
  Future<ModuleConfiguration> build() async {
    final hikari = ref.watch(hikariPodProvider);

    log.finer("rebuilding");
    return _loadModuleConfigFromApi(hikari);
  }

  static Map<ModuleCategory, List<ModuleAssessmentSet>> perCategoryModules(
    List<ModuleAssessmentSet> modules,
  ) {
    Map<ModuleCategory, List<ModuleAssessmentSet>> result = {};
    for (ModuleAssessmentSet module in modules) {
      final modulesInCategory = result.putIfAbsent(
        module.module.category,
        () => [],
      );
      modulesInCategory.add(module);
    }
    return result;
  }

  Future<ModuleConfiguration> _loadModuleConfigFromApi(Hikari hikari) async {
    //load parallel
    final asyncModule = ref.watch(moduleProvider.future);
    final asyncModuleGroups = ref.watch(moduleGroupsProviderProvider.future);

    final result = await Future.wait([asyncModule, asyncModuleGroups]);

    final Map<String, ModuleAssessmentSet> modules =
        result[0] as Map<String, ModuleAssessmentSet>;

    final Map<String, ModuleGroup> moduleGroups =
        result[1] as Map<String, ModuleGroup>;

    List<ModuleAssessmentSet> modulesList = modules.values.toList(
      growable: false,
    );

    for (ModuleAssessmentSet module in modulesList) {
      log.info("${module.module.id}: ${module.module.category}");
    }

    // We sort from highest weight to lowest weight
    modulesList.sortBy<num>((module) => -module.module.weight);

    final categoryMap = perCategoryModules(modulesList);

    log.info(
      "Got modules: ${categoryMap.map((category, modules) => MapEntry(category, modules.map((module) => module.module.id)))}",
    );

    return ModuleConfiguration(modules: categoryMap, groups: moduleGroups);
  }
}
