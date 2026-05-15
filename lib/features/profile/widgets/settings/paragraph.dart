import 'package:flutter/material.dart';
import 'package:gap/gap.dart';

class Paragraph extends StatelessWidget {
  final String title;
  final String content;

  const Paragraph({super.key, required this.content, required this.title});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          title,
          style: theme.textTheme.titleMedium!.copyWith(
            color: theme.colorScheme.surfaceContainer,
          ),
        ),
        const Gap(10),
        ClipRRect(
          borderRadius: BorderRadius.circular(20),
          child: Material(
            child: Ink(
              color: const Color.fromRGBO(240, 240, 240, 1.0),
              child: Padding(
                padding: const EdgeInsets.all(12.0),
                child: Text(content),
              ),
            ),
          ),
        ),
      ],
    );
  }
}
