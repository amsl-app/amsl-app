import 'package:amsl_app/models/tori/modules/module_assessment.dart';
import 'package:amsl_app/widgets/text/moment_text.dart';
import 'package:flutter/material.dart';
import 'package:gap/gap.dart';

import '../../../models/tori/assessments/assessment_session.dart';
import '../../../models/tori/modules/session.dart';

class HistoryTile extends StatelessWidget {
  final HistoryTileData historyTileObject;
  final bool first;
  final bool last;

  const HistoryTile({
    super.key,
    required this.historyTileObject,
    this.first = false,
    this.last = false,
  });

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final String title = historyTileObject.title;
    final String subtitle = historyTileObject.subtitle;
    final DateTime date = historyTileObject.date;
    final IconData iconData = historyTileObject.iconData;

    return IntrinsicHeight(
      child: Row(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.end,
        children: [
          Column(
            children: [
              Expanded(
                child: VerticalDivider(
                  color: first ? theme.colorScheme.surface : Colors.black,
                  thickness: 2,
                ),
              ),
              Icon(Icons.circle, size: 20, color: theme.colorScheme.tertiary),
              Expanded(
                child: VerticalDivider(
                  color: last ? theme.colorScheme.surface : Colors.black,
                  thickness: 2,
                ),
              ),
              SizedBox(
                height: 20,
                child: VerticalDivider(
                  color: last ? theme.colorScheme.surface : Colors.black,
                  thickness: 2,
                ),
              ),
            ],
          ),
          const Gap(10),
          Expanded(
            child: Column(
              children: [
                Expanded(
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(12),
                    child: Container(
                      color: const Color.fromRGBO(240, 240, 240, 1.0),
                      child: Padding(
                        padding: const EdgeInsets.all(20.0),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Row(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              mainAxisAlignment: MainAxisAlignment.start,
                              mainAxisSize: MainAxisSize.max,
                              children: [
                                Icon(iconData, size: 24),
                                const Gap(20),
                                Expanded(
                                  child: RichText(
                                    text: TextSpan(
                                      text: title,
                                      style: theme.textTheme.titleMedium,
                                      children: [
                                        TextSpan(
                                          text: " - $subtitle",
                                          style: theme.textTheme.bodyLarge,
                                        ),
                                      ],
                                    ),
                                  ),
                                ),
                              ],
                            ),
                            const Gap(10),
                            Align(
                              alignment: Alignment.centerRight,
                              child: MomentText(
                                date: date,
                                maxLines: 1,
                                style: theme.textTheme.bodyLarge,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                ),
                const Gap(20),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class HistoryTileData {
  final Session? session;
  final ToriAssessmentSession? assessmentSession;
  final ModuleAssessmentSet? module;
  final String title;
  final String subtitle;
  final DateTime date;
  final IconData iconData;
  final bool hide;

  HistoryTileData({
    required this.title,
    required this.subtitle,
    required this.date,
    required this.iconData,
    required this.session,
    required this.assessmentSession,
    required this.module,
    this.hide = false,
  });

  bool contains(String keyword) {
    keyword = keyword.toLowerCase();

    String tempTitle = title.toLowerCase();
    String tempSubtitle = subtitle.toLowerCase();
    String tempDate = date.toString().toLowerCase();

    return tempDate.contains(keyword) ||
        tempSubtitle.contains(keyword) ||
        tempTitle.contains(keyword);
  }

  @override
  String toString() {
    return 'HistoryTileData{session: ${session?.id}, module: ${module?.module.id}, date: $date}';
  }
}
