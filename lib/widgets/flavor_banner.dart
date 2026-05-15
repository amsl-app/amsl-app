import 'package:amsl_app/flavors.dart';
import 'package:flutter/material.dart';

class FlavorBanner extends StatelessWidget {
  final Widget child;
  final bool show;

  const FlavorBanner({super.key, this.show = true, required this.child});

  @override
  Widget build(BuildContext context) {
    if (!show) {
      return child;
    }
    return Banner(
      location: BannerLocation.topStart,
      message: F.name.toUpperCase(),
      color: Colors.green.withValues(alpha: 0.6),
      textStyle: const TextStyle(
        fontWeight: FontWeight.w700,
        fontSize: 12.0,
        letterSpacing: 1.0,
      ),
      textDirection: TextDirection.ltr,
      child: child,
    );
  }
}
