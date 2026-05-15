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

  final _controller = CountDownController();
  CircularCountDownTimer? clock;
  bool showReset = false;

  void toggle() {
    setState(() {
      showReset = true;
      if (!_controller.isStarted.value) {
        _controller.start();
      } else if (_controller.isPaused.value) {
        _controller.resume();
      } else {
        _controller.pause();
      }
    });
  } // Conditional flag

  void reset() {
    setState(() {
      showReset = false;
      _controller.pause();
      _controller.reset();
    });
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final double height = MediaQuery.of(context).size.height / 2;
    final double width = MediaQuery.of(context).size.width / 2;

    log.info("Clock value: $clock");

    clock ??= CircularCountDownTimer(
      controller: _controller,
      isReverseAnimation: true,
      ringColor: theme.colorScheme.onPrimary,
      height: height,
      width: width,
      autoStart: false,
      duration: 25 * 60,
      isReverse: true,
      textStyle: TextStyle(
        color: theme.colorScheme.onPrimary,
        fontSize: 28,
        fontWeight: FontWeight.bold,
      ),
      fillColor: theme.colorScheme.primary,
      backgroundColor: theme.colorScheme.primary,
      strokeCap: StrokeCap.round,
      onComplete: () {},
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
          children: <Widget>[
            Center(child: clock),
            const Gap(10),
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 20.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  GestureDetector(
                    onTap: () => toggle(),
                    child: Container(
                      width: width / 2.5,
                      height: height / 8,
                      decoration: BoxDecoration(
                        color: theme.colorScheme.primary,
                        borderRadius: BorderRadius.circular(10.0),
                      ),
                      child: _buildButton(theme),
                    ),
                  ),
                  Visibility(
                    visible: showReset,
                    child: GestureDetector(
                      onTap: () => reset(),
                      child: Row(
                        children: [
                          const Gap(20),
                          Container(
                            width: width / 2.5,
                            height: height / 8,
                            decoration: BoxDecoration(
                              color: theme.colorScheme.primary,
                              borderRadius: BorderRadius.circular(10.0),
                            ),
                            child: Icon(
                              Icons.restart_alt,
                              color: theme.colorScheme.onPrimary,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildButton(ThemeData theme) {
    if (!_controller.isStarted.value || _controller.isPaused.value) {
      return Icon(Icons.play_arrow_sharp, color: theme.colorScheme.onPrimary);
    }
    return Icon(Icons.pause_sharp, color: theme.colorScheme.onPrimary);
  }
}
