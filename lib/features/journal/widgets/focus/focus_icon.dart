import 'package:amsl_app/features/journal/models/focus_icons.dart';
import 'package:flutter/material.dart';
import 'package:gap/gap.dart';

import '../../../../models/tori/journal/journal_focus.dart';

class FocusIcon extends StatelessWidget {
  final double size;
  final bool selected;
  final Color backgroundColor;
  final Color activeBackgroundColor;
  final Color labelColor;
  final Color iconColor;
  final Color activeIconColor;
  final JournalFocus focus;

  const FocusIcon({
    super.key,
    required this.size,
    required this.focus,
    required this.selected,
    required this.iconColor,
    required this.activeIconColor,
    required this.backgroundColor,
    required this.activeBackgroundColor,
    required this.labelColor,
  });

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Column(
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20.0),
          child: AspectRatio(
            aspectRatio: 1,
            child: ClipOval(
              child: Container(
                padding: const EdgeInsets.all(15.0),
                color: selected ? activeBackgroundColor : backgroundColor,
                child:
                    FocusIcons.getIconFromString(
                      focus.iconString,
                      color: selected ? activeIconColor : iconColor,
                    ) ??
                    Container(),
              ),
            ),
          ),
        ),
        const Gap(8.0),
        Text(
          focus.name,
          maxLines: 1,
          style: theme.textTheme.titleSmall!.copyWith(color: labelColor),
        ),
      ],
    );
  }
}
