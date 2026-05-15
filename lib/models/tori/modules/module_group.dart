import '../../hikari/modules/module_group.dart' as hikari_module_group;

class ModuleGroup {
  final String key;
  final String label;
  final List<String> moduleIDs;
  final int weight;

  ModuleGroup({
    required this.key,
    required this.label,
    required this.moduleIDs,
    required this.weight,
  });

  ModuleGroup.fromHikari(hikari_module_group.ModuleGroup group)
    : key = group.key,
      label = group.label,
      moduleIDs = group.moduleIDs,
      weight = group.weight;
}
