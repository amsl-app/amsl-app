import 'package:flutter/material.dart';

class MoodIcon extends StatelessWidget {
  final double size;
  final IconData mood;
  final bool selected;
  final Color backgroundColor;
  final Color activeBackgroundColor;
  final Color iconColor;
  final Color activeIconColor;

  const MoodIcon({
    super.key,
    required this.mood,
    required this.selected,
    required this.size,
    required this.iconColor,
    required this.activeIconColor,
    required this.backgroundColor,
    required this.activeBackgroundColor,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.center,
      mainAxisSize: MainAxisSize.min,
      children: [
        ClipOval(
          child: Container(
            padding: const EdgeInsets.all(6),
            color: selected ? activeBackgroundColor : backgroundColor,
            child: Icon(
              mood,
              size: size,
              color: selected ? activeIconColor : iconColor,
            ),
          ),
        ),
      ],
    );
  }
}
