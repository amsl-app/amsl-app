import 'package:amsl_app/features/chat/widgets/elements/bubble.dart';
import 'package:flutter/material.dart';

String stringFromSeconds(int seconds) {
  int hours = seconds ~/ 3600;
  int secondsRemaining = seconds % 3600;
  int minutesRemaining = secondsRemaining ~/ 60;

  String hoursString = hours.toString();
  String minutesString = minutesRemaining.toString().padLeft(2, '0');

  return '$hoursString Stunden und $minutesString Minuten';
}

class DurationBubble extends StatelessWidget {
  final int duration;
  final bool sentByMe;

  const DurationBubble({
    super.key,
    required this.duration,
    required this.sentByMe,
  });

  @override
  Widget build(BuildContext context) {
    return Bubble(stringFromSeconds(duration), sentByMe);
  }
}
