import 'package:flutter/material.dart';
import 'package:gap/gap.dart';

class ScoreTrackRow extends StatelessWidget {
  final String label;
  final double value;
  final double min;
  final double max;
  final Color trackColor;
  final Color fillColor;
  final Color dotColor;
  final TextStyle? labelStyle;
  final TextStyle? valueStyle;

  const ScoreTrackRow({
    super.key,
    required this.label,
    required this.value,
    required this.min,
    required this.max,
    required this.trackColor,
    required this.fillColor,
    required this.dotColor,
    this.labelStyle,
    this.valueStyle,
  });

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Row(
      children: [
        if (label.isNotEmpty) ...[
          SizedBox(
            width: 100,
            child: Text(
              label,
              style: labelStyle ?? theme.textTheme.bodySmall,
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
            ),
          ),
          const Gap(12),
        ],
        Expanded(
          child: _Track(
            fraction: (max - min) > 0
                ? ((value - min) / (max - min)).clamp(0.0, 1.0)
                : 0.0,
            trackColor: trackColor,
            fillColor: fillColor,
            dotColor: dotColor,
          ),
        ),
        const Gap(10),
        SizedBox(
          width: 28,
          child: Text(
            value.toStringAsFixed(0),
            style: valueStyle ?? theme.textTheme.bodySmall,
            textAlign: TextAlign.right,
          ),
        ),
      ],
    );
  }
}

class _Track extends StatelessWidget {
  final double fraction;
  final Color trackColor;
  final Color fillColor;
  final Color dotColor;

  const _Track({
    required this.fraction,
    required this.trackColor,
    required this.fillColor,
    required this.dotColor,
  });

  @override
  Widget build(BuildContext context) {
    const dotSize = 10.0;
    const trackHeight = 2.0;

    return LayoutBuilder(
      builder: (context, constraints) {
        final totalWidth = constraints.maxWidth;
        final dotLeft = (totalWidth - dotSize) * fraction;

        return SizedBox(
          height: dotSize,
          child: Stack(
            clipBehavior: Clip.none,
            children: [
              Positioned(
                top: (dotSize - trackHeight) / 2,
                left: 0,
                right: 0,
                child: Container(
                  height: trackHeight,
                  decoration: BoxDecoration(
                    color: trackColor,
                    borderRadius: BorderRadius.circular(1),
                  ),
                ),
              ),
              Positioned(
                top: (dotSize - trackHeight) / 2,
                left: 0,
                width: totalWidth * fraction,
                child: Container(
                  height: trackHeight,
                  decoration: BoxDecoration(
                    color: fillColor,
                    borderRadius: BorderRadius.circular(1),
                  ),
                ),
              ),
              Positioned(
                left: dotLeft,
                top: 0,
                child: Container(
                  width: dotSize,
                  height: dotSize,
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    color: dotColor,
                  ),
                ),
              ),
            ],
          ),
        );
      },
    );
  }
}
