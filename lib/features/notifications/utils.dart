import 'package:flutter/material.dart';

extension ExtensionDateTime on DateTime {
  bool sameDayAs(DateTime other) {
    return year == other.year && month == other.month && day == other.day;
  }

  bool sameDayWithOffsetAs(DateTime other, Duration negativeOffset) {
    other = other.subtract(negativeOffset);
    return year == other.year && month == other.month && day == other.day;
  }

  DateTime withoutTime() {
    return DateTime(year, month, day);
  }

  DateTime withTime(TimeOfDay time) {
    return DateTime(year, month, day, time.hour, time.minute);
  }

  bool isToday() {
    return sameDayAs(DateTime.now());
  }
}
