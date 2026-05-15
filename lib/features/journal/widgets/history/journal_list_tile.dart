import 'package:amsl_app/features/journal/models/moods.dart';
import 'package:amsl_app/features/journal/widgets/history/focus_tag.dart';
import 'package:amsl_app/models/tori/journal/journal_entry.dart';
import 'package:amsl_app/widgets/text/moment_text.dart';
import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:go_router/go_router.dart';

class JournalListTile extends StatelessWidget {
  final ToriJournalEntry journal;
  final bool first;
  final bool last;

  const JournalListTile({
    super.key,
    required this.journal,
    this.first = false,
    this.last = false,
  });

  static const Color lightYellow = Color.fromRGBO(245, 231, 202, 1.0);

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return IntrinsicHeight(
      child: Row(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.end,
        children: [
          Column(
            children: [
              Expanded(
                child: VerticalDivider(
                  color: first
                      ? theme.colorScheme.tertiaryContainer
                      : lightYellow,
                  thickness: 2,
                ),
              ),
              Icon(Icons.circle, size: 20, color: theme.colorScheme.primary),
              Expanded(
                child: VerticalDivider(
                  color: last
                      ? theme.colorScheme.tertiaryContainer
                      : lightYellow,
                  thickness: 2,
                ),
              ),
              SizedBox(
                height: 20,
                child: VerticalDivider(
                  color: last
                      ? theme.colorScheme.tertiaryContainer
                      : lightYellow,
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
                  child: JournalListTileBox(
                    journal: journal,
                    onTap: () => context.goNamed(
                      'reflection_detail',
                      pathParameters: {'journalID': journal.id},
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

class JournalListTileBox extends StatelessWidget {
  final ToriJournalEntry journal;
  final Function onTap;

  const JournalListTileBox({
    super.key,
    required this.journal,
    required this.onTap,
  });

  static const Color lightYellow = Color.fromRGBO(245, 231, 202, 1.0);

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final textTheme = theme.textTheme.apply(
      displayColor: theme.colorScheme.primary,
      bodyColor: theme.colorScheme.primary,
    );

    final String title =
        journal.title ?? journal.content.firstOrNull?.title ?? "";
    IconData? iconData = switch (journal.mood) {
      double mood? => Moods.get(mood).data.icon,
      _ => null,
    };

    return ClipRRect(
      borderRadius: BorderRadius.circular(12),
      child: Material(
        color: lightYellow,
        child: Ink(
          child: InkWell(
            onTap: () => onTap(),
            child: Padding(
              padding: const EdgeInsets.only(
                top: 12,
                bottom: 4,
                left: 16,
                right: 16,
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.start,
                    mainAxisSize: MainAxisSize.max,
                    children: [
                      if (iconData != null)
                        Icon(
                          iconData,
                          size: 30,
                          color: theme.colorScheme.primary,
                        ),
                      if (iconData != null) const Gap(20),
                      Expanded(
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.start,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              title,
                              maxLines: 1,
                              overflow: TextOverflow.ellipsis,
                              style: textTheme.titleMedium,
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                  const Gap(5),
                  Wrap(
                    children: List.generate(
                      journal.focus.length,
                      (index) => FocusTag(
                        focus: journal.focus[index],
                        background: theme.colorScheme.tertiaryContainer,
                        color: theme.colorScheme.primary,
                      ),
                    ),
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      MomentText(
                        date: journal.created,
                        maxLines: 1,
                        style: textTheme.bodySmall,
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
