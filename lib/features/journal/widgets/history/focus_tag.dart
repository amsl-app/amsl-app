import 'package:amsl_app/features/journal/models/focus_icons.dart';
import 'package:amsl_app/models/tori/journal/journal_focus.dart';
import 'package:flutter/material.dart';
import 'package:gap/gap.dart';

class FocusTag extends StatelessWidget {
  const FocusTag({
    super.key,
    required this.focus,
    required this.background,
    required this.color,
    this.iconSize = 20.0,
    this.fontSize = 12.0,
    this.borderRadius = 30.0,
  });

  final JournalFocus focus;
  final Color background;
  final Color color;
  final double iconSize;
  final double fontSize;
  final double borderRadius;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(borderRadius),
        child: Container(
          color: background,
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                FocusIcons.getIconFromString(
                      focus.iconString,
                      width: iconSize,
                      height: iconSize,
                      color: color,
                    ) ??
                    Container(),
                const Gap(5.0),
                Text(
                  focus.name,
                  style: theme.textTheme.bodySmall!.copyWith(
                    color: color,
                    fontSize: fontSize,
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
