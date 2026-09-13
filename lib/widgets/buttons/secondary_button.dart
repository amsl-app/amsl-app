import 'package:flutter/material.dart';

/// A plain, less prominent text-only button for secondary actions.
class SecondaryButton extends StatelessWidget {
  final String label;
  final VoidCallback onTap;

  const SecondaryButton({super.key, required this.label, required this.onTap});

  @override
  Widget build(BuildContext context) {
    return TextButton(onPressed: onTap, child: Text(label));
  }
}
