import 'package:flutter/material.dart';

class RoundedCornerIconButton extends StatelessWidget {
  final IconData icon;
  final Color buttonColor;
  final Color iconColore;
  final double iconSize;
  final Color? borderColor;
  final Function onTap;
  final bool active;

  const RoundedCornerIconButton({
    super.key,
    this.buttonColor = const Color(0xFF0C132A),
    this.iconColore = const Color(0xFFFFFFFF),
    this.borderColor,
    this.iconSize = 24,
    this.active = true,
    required this.icon,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return ClipRRect(
      borderRadius: BorderRadius.circular(12),
      child: Material(
        color: buttonColor,
        child: Ink(
          child: InkWell(
            onTap: () => onTap(),
            child: Container(
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(12),
                border: borderColor != null
                    ? Border.all(color: borderColor!, width: 2)
                    : null,
              ),
              padding: const EdgeInsets.all(4),
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Icon(
                  icon,
                  color: active ? iconColore : iconColore.withAlpha(100),
                  size: iconSize,
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
