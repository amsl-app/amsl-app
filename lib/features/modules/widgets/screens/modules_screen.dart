import 'package:amsl_app/features/modules/providers/module_provider.dart';
import 'package:amsl_app/features/modules/widgets/add_module_dialog.dart';
import 'package:amsl_app/widgets/async_value_extension.dart';
import 'package:amsl_app/widgets/loading/haptic_refresh_indicator.dart';
import 'package:amsl_app/widgets/loading/skeleton_loading_widget.dart';
import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:logging/logging.dart';
import '../../../../widgets/search_widget.dart';
import '../../providers/module_configuration.dart';
import 'filtered_modules_view.dart';

class ModulesScreen extends StatefulHookConsumerWidget {
  const ModulesScreen({super.key});

  @override
  ConsumerState<ModulesScreen> createState() => _ModulesScreenState();
}

class _ModulesScreenState extends ConsumerState<ModulesScreen> {
  final log = Logger("ModulesScreenState");

  String keyword = "";

  @override
  Widget build(BuildContext context) {
    final asyncModuleConfig = ref.watch(moduleConfigurationProviderProvider);
    final theme = Theme.of(context);

    Future<void> onRefresh() async =>
        ref.read(moduleProvider.notifier).reloadModules(complete: true);

    return DefaultTabController(
      length: 1,
      initialIndex: 0,
      child: Scaffold(
        appBar: AppBar(
          scrolledUnderElevation: 0.0,
          titleSpacing: 0,
          title: Align(
            alignment: Alignment.centerLeft,
            child: TabBar(
              onTap: (index) {},
              labelPadding: const EdgeInsets.symmetric(horizontal: 20.0),
              padding: EdgeInsets.zero,
              indicatorColor: theme.colorScheme.tertiary,
              indicatorSize: TabBarIndicatorSize.tab,
              indicatorWeight: 4,
              labelStyle: theme.textTheme.titleMedium,
              tabs: const [Tab(text: "Themen")],
            ),
          ),
          backgroundColor: theme.colorScheme.surface,
        ),
        body: Column(
          children: [
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  SearchWidget(
                    onChange: (value) {
                      setState(() {
                        keyword = value;
                      });
                    },
                  ),
                  ClipOval(
                    child: Material(
                      child: Ink(
                        color: theme.colorScheme.tertiary,
                        child: InkWell(
                          onTap: () => showAddModuleDialog(context),
                          child: const Padding(
                            padding: EdgeInsets.all(4.0),
                            child: Icon(Icons.add),
                          ),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
            Expanded(
              child: Container(
                padding: const EdgeInsets.symmetric(horizontal: 20),
                child: HapticRefreshIndicator(
                  onRefresh: () {
                    return onRefresh();
                  },
                  child: asyncModuleConfig.build(
                    context,
                    builder: (context, moduleConfig) {
                      return FilteredModulesView(
                        modulesByGroups: moduleConfig!.groupedShownModules,
                        keyword: keyword,
                      );
                    },
                    loadingBuilder: (context) =>
                        const SkeletonLoadingWidget(rows: 3),
                    errorBuilder: (context, error, stackTrace) =>
                        const SkeletonLoadingWidget(rows: 3),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
