import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';

const _dotIntervals = [
  Interval(0.25, 0.8),
  Interval(0.35, 0.9),
  Interval(0.45, 1.0),
];
const _indicatorHeight = 60.0;
const _bubbleLeft = 12.0;
const _bubbleBottom = 12.0;
const _statusBubbleWidth = 70.0;
const _statusBubbleHeight = 36.0;
const _statusBubbleHorizontalPadding = 8.0;
const _statusBubbleBorderRadius = 27.0;
const _flashingCircleSize = 10.0;

class TypingIndicator extends HookWidget {
  const TypingIndicator({
    super.key,
    this.bubbleColor = const Color(0xFF646b7f),
    this.flashingCircleDarkColor = const Color(0xFF333333),
    this.flashingCircleBrightColor = const Color(0xFFaec1dd),
  });

  final Color bubbleColor;
  final Color flashingCircleDarkColor;
  final Color flashingCircleBrightColor;

  @override
  Widget build(BuildContext context) {
    final appearanceController = useAnimationController(
      duration: const Duration(milliseconds: 750),
    );
    final repeatingController = useAnimationController(
      duration: const Duration(milliseconds: 1500),
    );

    final indicatorSpaceAnimation = CurvedAnimation(
      parent: appearanceController,
      curve: const Interval(0.0, 0.4, curve: Curves.easeOut),
      reverseCurve: const Interval(0.0, 1.0, curve: Curves.easeOut),
    ).drive(Tween<double>(begin: 0.0, end: _indicatorHeight));

    final largeBubbleAnimation = CurvedAnimation(
      parent: appearanceController,
      curve: const Interval(0.3, 1.0, curve: Curves.elasticOut),
      reverseCurve: const Interval(0.5, 1.0, curve: Curves.easeOut),
    );

    useEffect(() {
      appearanceController.forward();
      repeatingController.repeat();

      return null;
    }, [appearanceController, repeatingController]);

    return AnimatedBuilder(
      animation: indicatorSpaceAnimation,
      builder: (context, child) {
        return SizedBox(height: indicatorSpaceAnimation.value, child: child);
      },
      child: Stack(
        children: [
          AnimatedBubble(
            animation: largeBubbleAnimation,
            left: _bubbleLeft,
            bottom: _bubbleBottom,
            bubble: StatusBubble(
              animation: repeatingController,
              dotIntervals: _dotIntervals,
              flashingCircleDarkColor: flashingCircleDarkColor,
              flashingCircleBrightColor: flashingCircleBrightColor,
              bubbleColor: bubbleColor,
            ),
          ),
        ],
      ),
    );
  }
}

class AnimatedBubble extends StatelessWidget {
  const AnimatedBubble({
    super.key,
    required this.animation,
    required this.left,
    required this.bottom,
    required this.bubble,
  });

  final Animation<double> animation;
  final double left;
  final double bottom;
  final Widget bubble;

  @override
  Widget build(BuildContext context) {
    return Positioned(
      left: left,
      bottom: bottom,
      child: AnimatedBuilder(
        animation: animation,
        builder: (context, child) {
          return Transform.scale(
            scale: animation.value,
            alignment: Alignment.bottomLeft,
            child: child,
          );
        },
        child: bubble,
      ),
    );
  }
}

class StatusBubble extends StatelessWidget {
  const StatusBubble({
    super.key,
    required this.animation,
    required this.dotIntervals,
    required this.flashingCircleBrightColor,
    required this.flashingCircleDarkColor,
    required this.bubbleColor,
  });

  final Animation<double> animation;
  final List<Interval> dotIntervals;
  final Color flashingCircleDarkColor;
  final Color flashingCircleBrightColor;
  final Color bubbleColor;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: _statusBubbleWidth,
      height: _statusBubbleHeight,
      padding: const EdgeInsets.symmetric(
        horizontal: _statusBubbleHorizontalPadding,
      ),
      decoration: BoxDecoration(
        borderRadius: const BorderRadius.all(
          Radius.circular(_statusBubbleBorderRadius),
        ),
        color: bubbleColor,
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: List.generate(
          dotIntervals.length,
          (index) => FlashingCircle(
            index: index,
            animation: animation,
            dotIntervals: dotIntervals,
            flashingCircleDarkColor: flashingCircleDarkColor,
            flashingCircleBrightColor: flashingCircleBrightColor,
          ),
        ),
      ),
    );
  }
}

class FlashingCircle extends StatelessWidget {
  const FlashingCircle({
    super.key,
    required this.index,
    required this.animation,
    required this.dotIntervals,
    required this.flashingCircleBrightColor,
    required this.flashingCircleDarkColor,
  });

  final int index;
  final Animation<double> animation;
  final List<Interval> dotIntervals;
  final Color flashingCircleDarkColor;
  final Color flashingCircleBrightColor;

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      animation: animation,
      builder: (context, child) {
        final circleFlashPercent = dotIntervals[index].transform(
          animation.value,
        );
        final circleColorPercent = sin(pi * circleFlashPercent);

        return _FlashingDot(
          color: Color.lerp(
            flashingCircleDarkColor,
            flashingCircleBrightColor,
            circleColorPercent,
          ),
        );
      },
    );
  }
}

class _FlashingDot extends StatelessWidget {
  const _FlashingDot({required this.color});

  final Color? color;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: _flashingCircleSize,
      height: _flashingCircleSize,
      child: DecoratedBox(
        decoration: BoxDecoration(shape: BoxShape.circle, color: color),
      ),
    );
  }
}
