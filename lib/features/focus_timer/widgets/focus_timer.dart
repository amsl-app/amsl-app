import 'package:amsl_app/constants.dart';
import 'package:circular_countdown_timer/circular_countdown_timer.dart';
import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:logging/logging.dart';

class FocusTimer extends StatefulWidget {
  static final log = Logger("FocusTimer");

  const FocusTimer({super.key});

  @override
  State<FocusTimer> createState() => _FocusTimerState();
}

class _FocusTimerState extends State<FocusTimer> {
  static final log = Logger("FocusTimerState");

  static const _workDuration = 25 * 60;
  static const _breakDuration = 5 * 60;
  static const _rounds = 4;

  // Classic pomodoro: 4 work rounds, with a break after each but the last.
  static final _phaseDurations = [
    for (var round = 0; round < _rounds; round++) ...[
      _workDuration,
      if (round < _rounds - 1) _breakDuration,
    ],
  ];

  final _controller = CountDownController();
  CircularCountDownTimer? clock;
  int phaseIndex = 0;

  bool _suppressComplete = false;

  bool get isBreak => phaseIndex.isOdd;
  int get round => phaseIndex ~/ 2 + 1;
  bool get showReset => phaseIndex != 0 || _controller.isStarted.value;

  void toggle() {
    setState(() {
      if (!_controller.isStarted.value) {
        _controller.start();
      } else if (_controller.isPaused.value) {
        _controller.resume();
      } else {
        _controller.pause();
      }
    });
  }

  void reset() {
    setState(() {
      phaseIndex = 0;
      // CountDownController.reset() triggers onComplete; indicate that it is not a real compelte
      _suppressComplete = true;
      _controller.restart(duration: _phaseDurations[0]);
      _controller.reset();
      _suppressComplete = false;
    });
  }

  void skip() => _nextPhase();

  void _nextPhase() {
    // Check if it is an actual complete
    if (_suppressComplete) return;
    final next = phaseIndex + 1;
    if (next >= _phaseDurations.length) {
      reset();
      return;
    }
    setState(() => phaseIndex = next);
    _controller.restart(duration: _phaseDurations[next]);
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final double size = MediaQuery.of(context).size.width / 2;

    log.info("Clock value: $clock");

    clock ??= CircularCountDownTimer(
      controller: _controller,
      isReverseAnimation: true,
      ringColor: theme.colorScheme.onPrimary,
      height: size,
      width: size,
      autoStart: false,
      duration: _phaseDurations[0],
      isReverse: true,
      textStyle: TextStyle(
        color: theme.colorScheme.onPrimary,
        fontSize: 28,
        fontWeight: FontWeight.bold,
      ),
      fillColor: theme.colorScheme.primary,
      backgroundColor: theme.colorScheme.primary,
      strokeCap: StrokeCap.round,
      onComplete: _nextPhase,
    );

    return Scaffold(
      backgroundColor: theme.colorScheme.tertiaryContainer,
      appBar: AppBar(
        scrolledUnderElevation: 0.0,
        elevation: 0.0,
        title: Align(
          alignment: Alignment.centerLeft,
          child: Text(
            "Focus Timer",
            style: TextStyle(color: theme.colorScheme.onTertiaryContainer),
          ),
        ),
        backgroundColor: theme.colorScheme.tertiaryContainer,
      ),
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          children: [
            Text(
              "Der 25-Minuten-Fokus-Timer basiert auf der Pomodoro-Technik. "
              "Dabei wechseln sich vier Runden aus jeweils 25 Minuten "
              "konzentrierter Arbeit und 5 Minuten Pause ab. Die Dauer kann "
              "individuell angepasst werden. Probiere verschiedene "
              "Einstellungen aus und finde heraus, welche am besten zu dir "
              "passt.",
              style: TextStyle(color: theme.colorScheme.onTertiaryContainer),
            ),
            const Gap(20),
            Text(
              "Runde $round von $_rounds · ${isBreak ? 'Pause' : 'Arbeiten'}",
              style: theme.textTheme.titleMedium!.copyWith(
                color: theme.colorScheme.onTertiaryContainer,
              ),
            ),
            const Gap(20),
            Align(alignment: Alignment.topCenter, child: clock),
            const Gap(20),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                GestureDetector(
                  onTap: toggle,
                  child: _actionButtonIcon(theme, size, _toggleIcon()),
                ),
                Visibility(
                  visible: showReset,
                  child: GestureDetector(
                    onTap: reset,
                    child: Row(
                      children: [
                        const Gap(20),
                        _actionButtonIcon(theme, size, Icons.restart_alt),
                      ],
                    ),
                  ),
                ),
                GestureDetector(
                  onTap: skip,
                  child: Row(
                    children: [
                      const Gap(20),
                      _actionButtonIcon(theme, size, Icons.skip_next),
                    ],
                  ),
                ),
              ],
            ),
            Gap(getBottomBarHeight(context)),
          ],
        ),
      ),
    );
  }

  IconData _toggleIcon() {
    if (!_controller.isStarted.value || _controller.isPaused.value) {
      return Icons.play_arrow_sharp;
    }
    return Icons.pause_sharp;
  }

  Widget _actionButtonIcon(ThemeData theme, double size, IconData icon) {
    return Container(
      padding: const EdgeInsets.all(8.0),
      width: size / 2.5,
      decoration: BoxDecoration(
        color: theme.colorScheme.primary,
        borderRadius: BorderRadius.circular(10.0),
      ),
      child: Icon(icon, color: theme.colorScheme.onPrimary),
    );
  }
}
