import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_hooks/flutter_hooks.dart';

class ReloadButton extends HookWidget {
  final RefreshCallback onTap;
  final Color? color;

  const ReloadButton({super.key, required this.onTap, this.color});

  @override
  Widget build(BuildContext context) {
    final controller = useAnimationController(
      duration: const Duration(seconds: 1),
    );
    final isSpinning = useState(false);

    return IconButton(
      icon: RotationTransition(
        turns: CurvedAnimation(parent: controller, curve: Curves.ease),
        child: Icon(Icons.refresh, size: 30, color: color),
      ),
      onPressed: isSpinning.value
          ? null
          : () async {
              await Future.wait([
                Future(() async {
                  try {
                    await onTap();
                  } on Exception {
                    // ignore
                  }
                }),
                _startSpinning(context, controller, isSpinning),
              ]);
            },
    );
  }

  Future<void> _startSpinning(
    BuildContext context,
    AnimationController controller,
    ValueNotifier<bool> isSpinning,
  ) async {
    HapticFeedback.heavyImpact();
    isSpinning.value = true;
    controller.reset();
    controller.forward().whenCompleteOrCancel(() {
      if (context.mounted) {
        isSpinning.value = false;
      }
    });
  }
}
