import 'package:amsl_app/models/tori/theme/module_theme.dart';
import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:logging/logging.dart';
import 'package:percent_indicator/percent_indicator.dart';

import '../../../models/tori/modules/module_assessment.dart';
import '../../../widgets/cached_image.dart';

class ModuleCard extends HookConsumerWidget {
  static final log = Logger("ModuleCard");

  const ModuleCard({super.key, required this.module, this.onTap});

  final ModuleAssessmentSet module;
  final GestureTapCallback? onTap;

  Widget _buildImage(String? image) {
    final Widget? child;

    if (image != null) {
      child = CachedImage(imageUrl: image, fit: BoxFit.cover);
    } else {
      child = Container();
    }

    return child;
  }

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final baseTheme = Theme.of(context);
    final moduleTheme = baseTheme.moduleTheme;
    final theme = baseTheme.copyWith(
      cardColor: moduleTheme.color,
      textTheme: baseTheme.textTheme.apply(
        displayColor: moduleTheme.textColor,
        decorationColor: moduleTheme.textColor,
        bodyColor: moduleTheme.textColor,
      ),
      extensions: (Map<Object, ThemeExtension<dynamic>>.from(
        baseTheme.extensions,
      )..[moduleTheme.sessionTheme.type] = moduleTheme.sessionTheme).values,
    );

    const br = BorderRadius.all(Radius.circular(16));

    return ClipRRect(
      borderRadius: br,
      child: Theme(
        data: theme,
        child: Material(
          type: MaterialType.card,
          child: Ink(
            child: InkWell(
              borderRadius: br,
              onTap: onTap,
              child: Row(
                children: [
                  Flexible(
                    flex: 11,
                    child: Padding(
                      padding: const EdgeInsets.only(
                        left: 16,
                        top: 16,
                        bottom: 16,
                        right: 8,
                      ),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          SizedBox(
                            width: double.infinity,
                            //height: 30,
                            // Kind of hacky but this makes sure the elements bellow the text don't shift around
                            // child: AutoSizeText(
                            //   module.module.title,
                            //   style: theme.textTheme.titleMedium,
                            //   minFontSize: ((theme.textTheme.titleMedium
                            //                   ?.fontSize ??
                            //               12) *
                            //           0.6)
                            //       .round()
                            //       .toDouble(),
                            //   softWrap: true,
                            //   overflow: TextOverflow.ellipsis,
                            // ),
                            child: Text(
                              module.module.title,
                              style: theme.textTheme.titleSmall,
                              maxLines: 2,
                              overflow: TextOverflow.ellipsis,
                            ),
                          ),
                          Expanded(child: Container()),
                          Text(
                            getSessionCountText(theme, module),
                            style: theme.textTheme.bodySmall!.copyWith(
                              color: moduleTheme.progressBarTheme.textColor,
                            ),
                          ),
                          const Gap(8),
                          SizedBox(
                            width: double.infinity,
                            child: LinearPercentIndicator(
                              lineHeight: 10,
                              padding: EdgeInsets.zero,
                              progressColor: moduleTheme.progressBarTheme.color,
                              barRadius: const Radius.circular(32),
                              backgroundColor:
                                  moduleTheme.progressBarTheme.trackColor,
                              percent: getPercent(module),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                  Flexible(flex: 8, child: _buildImage(module.module.banner)),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  String getSessionCountText(ThemeData theme, ModuleAssessmentSet module) {
    int toDo = module.sessionsToDo;
    if (module.isDone) {
      return "modul abgeschlossen".toUpperCase();
    }
    switch (toDo) {
      case 0:
        return "alle einheiten abgeschlossen".toUpperCase();
      case 1:
        return "noch eine einheit".toUpperCase();
      default:
        return "noch $toDo einheiten".toUpperCase();
    }
  }

  double getPercent(ModuleAssessmentSet module) {
    if (module.completion != null) return 1;
    int base = module.module.sessions.length;
    if (module.postAssessment.isDefined) base++;

    return module.sessionsDone / base;
  }
}
