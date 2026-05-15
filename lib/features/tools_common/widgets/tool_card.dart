import 'package:amsl_app/themes/tool_card_theme.dart';
import 'package:amsl_app/widgets/dialogs/amsl_dialog.dart';
import 'package:flutter/material.dart';

class Tool {
  final String id;
  final String name;
  final Widget? decoration;
  final Widget? widget;

  Tool({required this.id, required this.name, this.decoration, this.widget});
}

class ToolCard extends StatelessWidget {
  const ToolCard(this.tool, {super.key, required this.onTap});

  final Tool tool;
  final GestureTapCallback onTap;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context).toolCardTheme;

    return ClipRRect(
      borderRadius: BorderRadius.circular(16),
      child: Container(
        constraints: const BoxConstraints.expand(height: 77),
        child: Material(
          color: theme.backgroundColor,
          child: Ink(
            child: InkWell(
              onTap: () {
                if (tool.widget == null) {
                  showAmslBottomSheet(
                    bottomBar: true,
                    onClose: () {
                      Navigator.of(context).pop();
                    },
                    context: context,
                    child: Text(
                      "Das Tool \"${tool.name}\" ist noch nicht verfügbar. Wir arbeiten daran!",
                    ),
                  );
                } else {
                  onTap();
                }
              },
              child: Stack(
                children: [
                  if (tool.decoration != null) tool.decoration!,
                  Row(
                    children: [
                      Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Container(
                            padding: const EdgeInsets.only(left: 16),
                            child: Text(tool.name, style: theme.labelStyle),
                          ),
                        ],
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
