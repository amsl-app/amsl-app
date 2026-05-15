import 'dart:math';

import 'package:amsl_app/models/tori/journal/journal_content.dart';
import 'package:amsl_app/utils.dart';
import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:moment_dart/moment_dart.dart';

import '../../../../constants.dart';
import '../../../../models/tori/journal/journal_entry.dart';
import '../../models/moods.dart';
import 'focus_tag.dart';

class SingleJournal extends StatelessWidget {
  const SingleJournal({super.key, required this.journal});

  final ToriJournalEntry journal;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final textTheme = theme.textTheme.apply(
      displayColor: theme.colorScheme.primary,
      bodyColor: theme.colorScheme.primary,
    );
    return SingleChildScrollView(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: buildJournalWidgets(
          context,
          journal: journal,
          textTheme: textTheme,
          theme: theme,
        ),
      ),
    );
  }

  Widget buildJournalContent({
    required JournalContent content,
    required TextTheme textTheme,
  }) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        if (content.title != null)
          Text(content.title!, style: textTheme.titleSmall),
        if (content.content != null)
          Text(content.content!, style: textTheme.bodyMedium),
      ],
    );
  }

  List<Widget> buildJournalContents({
    required List<JournalContent> contents,
    required TextTheme textTheme,
  }) {
    return List.from(
      Iterable.generate(max(0, contents.length * 2 - 1)).map((index) {
        final itemIndex = index ~/ 2;
        if (index.isEven) {
          return buildJournalContent(
            content: contents[itemIndex],
            textTheme: textTheme,
          );
        }
        return const Gap(8);
      }),
      growable: false,
    );
  }

  List<Widget> buildJournalWidgets(
    BuildContext context, {
    required ToriJournalEntry journal,
    required TextTheme textTheme,
    required ThemeData theme,
  }) {
    final content = <Widget>[];

    content.addAll([
      Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text("Darum ging es: ", style: textTheme.titleMedium),
          Expanded(
            child: Text(
              toBeginningOfSentence(
                journal.created.toLocal().toMoment().calendar(),
              ),
              textAlign: TextAlign.right,
              style: textTheme.bodyMedium,
            ),
          ),
        ],
      ),
      const Gap(10.0),
      ContentWrapperWidget(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: buildJournalContents(
            contents: journal.content,
            textTheme: textTheme,
          ),
        ),
      ),
    ]);

    if (journal.focus.isNotEmpty) {
      content.addAll([
        const Gap(20.0),
        Text(
          "Darauf hast du dich konzentriert: ",
          style: textTheme.titleMedium,
        ),
        const Gap(10.0),
        ContentWrapperWidget(
          child: SingleChildScrollView(
            scrollDirection: Axis.horizontal,
            child: Row(
              children: journal.focus
                  .map(
                    (e) => FocusTag(
                      focus: e,
                      background: theme.colorScheme.primary,
                      color: theme.colorScheme.onPrimary,
                    ),
                  )
                  .toList(),
            ),
          ),
        ),
      ]);
    }

    final mood = journal.mood;
    if (mood != null) {
      content.addAll([
        const Gap(20.0),
        Text("Deine Stimmung war: ", style: textTheme.titleMedium),
        const Gap(10.0),
        ContentWrapperWidget(
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Row(
              children: [
                ClipOval(
                  child: Container(
                    height: 50.0,
                    width: 50.0,
                    color: theme.colorScheme.primary,
                    child: Center(
                      child: Icon(
                        Moods.get(mood).data.icon,
                        color: theme.colorScheme.onPrimary,
                        size: 30.0,
                      ),
                    ),
                  ),
                ),
                const Gap(8),
                Text(
                  Moods.get(mood).data.description,
                  style: textTheme.titleSmall,
                ),
              ],
            ),
          ),
        ),
      ]);
    }

    content.add(Gap(getBottomBarPadding(context)));
    return content;
  }
}

class ContentWrapperWidget extends StatelessWidget {
  final Widget child;

  const ContentWrapperWidget({super.key, required this.child});

  @override
  Widget build(BuildContext context) {
    const Color lightYellow = Color.fromRGBO(245, 231, 202, 1.0);

    return ClipRRect(
      borderRadius: BorderRadius.circular(12.0),
      child: Container(
        width: double.infinity,
        color: lightYellow,
        padding: const EdgeInsets.all(20.0),
        child: child,
      ),
    );
  }
}
