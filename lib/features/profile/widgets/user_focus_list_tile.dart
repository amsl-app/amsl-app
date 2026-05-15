import 'package:flutter/material.dart';
import 'package:gap/gap.dart';

import '../../journal/models/focus_icons.dart';

class UserFocusListTile extends StatelessWidget {
  final String icon;
  final String name;
  final bool hidden;
  final Function onHide;

  const UserFocusListTile({
    super.key,
    required this.hidden,
    required this.icon,
    required this.name,
    required this.onHide,
  });

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Row(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        FocusIcons.getIconFromString(
              icon,
              height: 30,
              width: 30,
              color: hidden
                  ? theme.colorScheme.primary.withValues(alpha: 0.3)
                  : theme.colorScheme.primary,
            ) ??
            const Placeholder(),
        const Gap(20.0),
        Expanded(
          child: Text(
            name,
            style: theme.textTheme.titleSmall!.copyWith(
              color: hidden
                  ? theme.colorScheme.primary.withValues(alpha: 0.3)
                  : theme.colorScheme.primary,
              decoration: hidden
                  ? TextDecoration.lineThrough
                  : TextDecoration.none,
            ),
          ),
        ),
        IconButton(
          onPressed: () {
            onHide();
          },
          icon: Icon(hidden ? Icons.visibility : Icons.visibility_off),
        ),
      ],
    );
  }
}
