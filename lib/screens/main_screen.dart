import 'package:amsl_app/constants.dart';
import 'package:amsl_app/features/modules/providers/module_configuration.dart';
import 'package:amsl_app/features/modules/widgets/add_module_dialog.dart';
import 'package:amsl_app/features/modules/widgets/horizontal_module_list.dart';
import 'package:amsl_app/features/special_image/load.dart';
import 'package:amsl_app/features/tools_common/widgets/tool_list.dart';
import 'package:amsl_app/models/tori/modules/module_group.dart';
import 'package:amsl_app/widgets/async_value_extension.dart';
import 'package:amsl_app/widgets/error/error_bar.dart';
import 'package:amsl_app/widgets/loading/loading_text.dart';
import 'package:amsl_app/widgets/loading/skeleton_loading_widget.dart';
import 'package:amsl_app/widgets/buttons/reload_button.dart';
import 'package:amsl_app/widgets/section_header.dart';
import 'package:flutter/material.dart';

import 'package:gap/gap.dart';
import 'package:go_router/go_router.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:logging/logging.dart';

import '../../features/tools_common/providers/tools.dart';
import '../models/tori/modules/module_assessment.dart';

class MainScreen extends StatefulHookConsumerWidget {
  static final log = Logger("MainScreen");

  const MainScreen({super.key});

  @override
  ConsumerState<MainScreen> createState() => _MainScreenState();
}

class _MainScreenState extends ConsumerState<MainScreen> {
  static final log = Logger("MainScreenState");

  @override
  Widget build(BuildContext context) {
    log.info("Building home screen");

    return Scaffold(
      body: SafeArea(
        child: Stack(
          children: [
            backgroundImage(),
            Container(
              padding: const EdgeInsets.only(top: 35),
              child: SizedBox(
                height: double.infinity,
                child: SingleChildScrollView(
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      loadSpecialImage(),
                      _buildGroups(context),
                      _buildTools(context),
                      Gap(getBottomBarHeight(context)),
                    ],
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildTools(BuildContext context) {
    final asyncTools = ref.watch(toolsProvider);

    return Row(
      children: [
        Expanded(
          child: Container(
            padding: const EdgeInsets.symmetric(horizontal: 20),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SectionHeader(
                  icon: Icons.widgets_outlined,
                  text: "Tools".toUpperCase(),
                ),
                Container(
                  padding: const EdgeInsets.only(top: 12),
                  child: asyncTools.build(
                    context,
                    builder: (context, tools) {
                      return ToolList(
                        tools: tools!.values,
                        onTap: (tool) {
                          log.info("Selected tool: ${tool.id}");
                          context.pushNamed(tool.id);
                        },
                      );
                    },
                    loadingBuilder: (context) => _buildTopicLoading(context),
                    errorBuilder: (context, error, stackTrace) =>
                        _buildTopicLoading(context),
                  ),
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildTopicLoading(BuildContext context) {
    return SkeletonLoadingWidget(columns: 2);
  }

  Widget _buildGroups(BuildContext context) {
    final asyncModules = ref.watch(moduleConfigurationProviderProvider);
    final theme = Theme.of(context);
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.only(left: 20, right: 20),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              const SectionHeader(icon: Icons.folder_copy_outlined),
              const Gap(4),
              Row(
                children: [
                  ReloadButton(onTap: () async => reloadAll(ref, context)),
                  const Gap(4),
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
            ],
          ),
        ),
        asyncModules.build(
          context,
          builder: (context, moduleConfig) {
            log.fine("Showing main screen with module config $moduleConfig");
            final modulesByGroups = moduleConfig!.groupedShownModules;
            return Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                for (final (group, moudles) in modulesByGroups)
                  _buildModules(context, group, moudles),
              ],
            );
          },
          loadingBuilder: (context) => _buildModuleLoading(context),
          errorBuilder: (context, error, stackTrace) =>
              _buildModuleLoading(context),
        ),
      ],
    );
  }

  Widget _buildModuleLoading(BuildContext context) {
    return const Padding(
      padding: EdgeInsets.symmetric(horizontal: 20, vertical: 12),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisSize: MainAxisSize.min,
        children: [
          LoadingText(width: 150),
          Gap(12),
          SingleChildScrollView(
            scrollDirection: Axis.horizontal,
            child: SkeletonLoadingWidget(columns: 1, rows: 2, width: 330),
          ),
        ],
      ),
    );
  }

  Widget _buildModules(
    BuildContext context,
    ModuleGroup group,
    List<ModuleAssessmentSet> modules,
  ) {
    log.info("Building modules");

    return Container(
      padding: const EdgeInsets.only(left: 0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisSize: MainAxisSize.min,
        children: [
          Padding(
            padding: const EdgeInsets.only(left: 20.0),
            child: SectionHeader(text: (group.label).toUpperCase()),
          ),
          const Gap(12),
          SizedBox(
            height: 125,
            child: HorizontalModuleList(
              modules: modules,
              onTap: (module) {
                log.info("Selected ${module.title}");

                if (context.mounted) {
                  context.goNamed(
                    "module",
                    pathParameters: {"moduleID": module.id},
                  );
                }
              },
            ),
          ),
          const Gap(24),
        ],
      ),
    );
  }
}
