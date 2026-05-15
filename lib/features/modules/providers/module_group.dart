import 'package:logging/logging.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

import '../../../hikari/exception.dart';
import '../../../hikari/hikari.dart';
import '../../../models/tori/modules/module_group.dart';
import '../../../providers/hikari_provider.dart';

part 'module_group.g.dart';

@Riverpod(keepAlive: true, dependencies: [HikariPod])
class ModuleGroupsProvider extends _$ModuleGroupsProvider {
  static final log = Logger("ModuleGroups");

  @override
  Future<Map<String, ModuleGroup>> build() async {
    final hikari = ref.watch(hikariPodProvider);
    return _loadModuleGroupsFromApi(hikari);
  }

  Future<Map<String, ModuleGroup>> _loadModuleGroupsFromApi(
    Hikari hikari,
  ) async {
    try {
      final hikari_groups = await hikari.moduleApi.getModuleGroups();
      return {
        for (final group in hikari_groups)
          group.key: ModuleGroup.fromHikari(group),
      };
    } on HikariException catch (e) {
      throw e.copyWith(resolve: reloadModuleGroups);
    }
  }

  Future<Map<String, ModuleGroup>> reloadModuleGroups() async {
    ref.invalidateSelf();
    return future;
  }
}
