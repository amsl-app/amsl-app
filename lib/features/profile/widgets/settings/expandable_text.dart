import 'package:flutter/material.dart';

class ExpandableText extends StatefulWidget {
  final String label;
  final String content;
  final Color color;

  const ExpandableText({
    super.key,
    required this.label,
    required this.content,
    this.color = const Color.fromRGBO(240, 240, 240, 1.0),
  });

  @override
  State<ExpandableText> createState() => _ExpandableTextState();
}

class _ExpandableTextState extends State<ExpandableText> {
  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return ClipRRect(
      borderRadius: BorderRadius.circular(12),
      child: Material(
        child: Ink(
          color: widget.color,
          child: Theme(
            data: ThemeData(dividerColor: Colors.transparent),
            child: ExpansionTile(
              title: Text(widget.label, style: theme.textTheme.titleMedium!),
              children: [
                Align(
                  alignment: Alignment.topLeft,
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: SelectableText(
                      widget.content,
                      style: theme.textTheme.bodyLarge,
                    ),
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
