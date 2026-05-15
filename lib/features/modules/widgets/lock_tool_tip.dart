import 'dart:async';

import 'package:amsl_app/models/hikari/modules/session.dart';
import 'package:flutter/material.dart';

class LockTooltip extends StatefulWidget {
  final LockedUntil lockedUntil;
  final Widget? child;

  const LockTooltip({super.key, required this.lockedUntil, this.child});

  @override
  State<LockTooltip> createState() => _LockTooltipState();
}

class _LockTooltipState extends State<LockTooltip> {
  late String text;

  void updateHint() {
    if (mounted) {
      setState(() {
        text = widget.lockedUntil.unlockHint();
      });
      Timer(const Duration(seconds: 1), updateHint);
    }
  }

  @override
  void initState() {
    super.initState();
    text = widget.lockedUntil.unlockHint();
    Timer(const Duration(seconds: 1), updateHint);
  }

  @override
  Widget build(BuildContext context) {
    return Tooltip(
      message: text,
      showDuration: const Duration(seconds: 5),
      child: widget.child,
    );
  }
}
