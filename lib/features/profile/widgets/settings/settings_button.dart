import 'package:flutter/material.dart';

class SettingsButton extends StatelessWidget {
  final String label;
  final IconData icon;
  final Function onTap;
  final Color buttonColor;
  final Color labelColor;

  const SettingsButton({
    super.key,
    required this.label,
    required this.icon,
    required this.onTap,
    this.buttonColor = const Color.fromRGBO(240, 240, 240, 1.0),
    this.labelColor = Colors.black,
  });

  @override
  Widget build(BuildContext context) {
    final br = BorderRadius.circular(10);

    final theme = Theme.of(context);
    return ClipRRect(
      borderRadius: br,
      child: Material(
        child: Ink(
          color: buttonColor,
          child: InkWell(
            borderRadius: br,
            onTap: () => onTap(),
            child: Padding(
              padding: const EdgeInsets.all(15.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  Icon(icon, color: labelColor),
                  const SizedBox(width: 10),
                  Text(
                    label,
                    style: theme.textTheme.titleMedium!.copyWith(
                      color: labelColor,
                    ),
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
