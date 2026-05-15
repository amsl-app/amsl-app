import 'dart:math';

import 'package:intl/intl.dart' as intl;

List<O> generateInterruptedMulti<I, O>(
  Iterable<I> iter,
  O Function(List<I>, int, int) callback,
  O filler, {
  bool growable = true,
  required int perRow,
}) {
  final list = List<I>.from(iter, growable: false);

  return List.generate(max(list.length + list.length ~/ perRow, 0), (index) {
    if (index % 2 == 0) {
      final start = (index ~/ 2) * perRow;
      var sublist = list.sublist(start, min(start + perRow, list.length));
      return callback(sublist, perRow, start);
    } else {
      return filler;
    }
  }, growable: growable);
}

List<O> generateInterrupted<I, O>(
  Iterable<I> iter,
  O Function(I, int) callback,
  O filler, {
  bool growable = true,
}) {
  final list = List.from(iter, growable: false);

  return List.generate(max(2 * list.length - 1, 0), (index) {
    if (index % 2 == 0) {
      final i = index ~/ 2;
      final item = list[i];
      return callback(item, i);
    } else {
      return filler;
    }
  }, growable: growable);
}

String toBeginningOfSentence(String string, [String? locale]) {
  // toBeginningOfSentenceCase never returns null when we pass in a String;
  locale ??= intl.Intl.getCurrentLocale();
  return intl.toBeginningOfSentenceCase(string, locale)!;
}
