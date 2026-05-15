import 'dart:async';

import 'package:amsl_app/utils.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:moment_dart/moment_dart.dart';

class MomentText extends HookWidget {
  final DateTime localDate;
  final int? maxLines;
  final TextStyle? style;

  MomentText({super.key, required DateTime date, this.maxLines, this.style})
    : localDate = date.toLocal();

  String _getDateString(Duration timeSince) {
    final days = timeSince.inDays.abs();
    final String ds;
    if (days > 1) {
      ds = localDate.toMoment().calendar(omitHours: days > 3);
    } else {
      ds = timeSince.toDurationString(form: Abbreviation.semi, round: false);
    }
    return toBeginningOfSentence(ds);
  }

  @override
  Widget build(BuildContext context) {
    final dateString = useState(
      _getDateString(localDate.difference(DateTime.now())),
    );
    final timerRef = useRef<Timer?>(null);

    useEffect(() {
      void updateDateString() {
        final dt = localDate.difference(DateTime.now());
        final newDateString = _getDateString(dt);
        if (dateString.value != newDateString) {
          dateString.value = newDateString;
        }
        if (dt.inDays <= -1) {
          return;
        }

        final seconds = dt.inSeconds.abs();
        final wait = seconds < 3600
            ? const Duration(seconds: 1)
            : Duration(seconds: 60 - seconds % 60);
        timerRef.value = Timer(wait, updateDateString);
      }

      updateDateString();

      return () {
        timerRef.value?.cancel();
      };
    }, [localDate]);

    return Text(dateString.value, maxLines: maxLines, style: style);
  }
}
