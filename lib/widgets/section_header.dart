import 'package:amsl_app/themes/section_header_theme.dart';
import 'package:flutter/material.dart';

class SectionHeader extends StatelessWidget {
  const SectionHeader({super.key, this.icon, this.text});

  final IconData? icon;
  final String? text;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        if (icon != null)
          Container(
            padding: const EdgeInsets.all(4),
            child: Icon(
              icon,
              size: 24,
              color: theme.sectionHeaderTheme.iconColor,
            ),
          ),
        if (text != null)
          Text(text!, style: theme.sectionHeaderTheme.textStyle),
      ],
    );
  }
}
