import 'package:amsl_app/features/journal/widgets/summary/summary_icon.dart';
import 'package:collection/collection.dart';
import 'package:flutter/material.dart';

import '../../../../models/tori/journal/journal_entry.dart';

class ReflectionSummaryList extends StatelessWidget {
  const ReflectionSummaryList({super.key, required this.journals});

  final List<ToriJournalEntry> journals;

  @override
  Widget build(BuildContext context) {
    List<SummaryDay> days = getSummaryDays();

    return Row(
      mainAxisSize: MainAxisSize.max,
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: List.generate(
        days.length,
        (index) => SummaryIcon(
          label: days[index].label,
          checked: days[index].hasEntry,
        ),
      ),
    );
  }

  String germanWeekday(int day) {
    return switch (day) {
      1 => "Mo",
      2 => "Di",
      3 => "Mi",
      4 => "Do",
      5 => "Fr",
      6 => "Sa",
      _ => "So",
    };
  }

  List<SummaryDay> getSummaryDays() {
    List<SummaryDay> days = [];

    for (DateTime day in getLastFiveDays()) {
      DateTime nextDay = day.add(const Duration(days: 1));

      days.add(
        SummaryDay(
          germanWeekday(day.weekday),
          journals.firstWhereOrNull(
                (element) =>
                    element.created.isAfter(day) &&
                    element.created.isBefore(nextDay),
              ) !=
              null,
        ),
      );
    }
    return days;
  }

  List<DateTime> getLastFiveDays() {
    DateTime now = DateTime.now();
    now = DateTime(now.year, now.month, now.day);
    List<DateTime> dates = [];
    for (int i = 4; i >= 0; i--) {
      dates.add(now.subtract(Duration(days: i)));
    }
    return dates;
  }
}

class SummaryDay {
  final String label;
  final bool hasEntry;

  SummaryDay(this.label, this.hasEntry);
}
