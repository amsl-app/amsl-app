import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class HapticRefreshIndicator extends StatelessWidget {
  const HapticRefreshIndicator({
    super.key,
    required this.onRefresh,
    required this.child,
  });

  final Future<void> Function() onRefresh;
  final Widget child;

  @override
  Widget build(BuildContext context) {
    return RefreshIndicator(
      onRefresh: () async {
        await HapticFeedback.heavyImpact();
        await onRefresh();
      },
      child: child,
    );
  }
}
