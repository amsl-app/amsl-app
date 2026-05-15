import 'dart:math';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class MovableFloatingActionButton extends StatefulWidget {
  final VoidCallback onPressed;
  final VoidCallback? onRemove;
  final Offset initialOffset;
  final Widget child;
  final double removeThreshold;

  const MovableFloatingActionButton({
    super.key,
    required this.onPressed,
    this.onRemove,
    required this.initialOffset,
    required this.child,
    this.removeThreshold = 120.0,
  });

  @override
  State<MovableFloatingActionButton> createState() =>
      _MovableFloatingActionButtonState();
}

class _MovableFloatingActionButtonState
    extends State<MovableFloatingActionButton> {
  Offset? _position;
  bool _isFarEnough = false;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final size = MediaQuery.of(context).size;
    final currentPosition = _position ?? widget.initialOffset;
    final distance = (currentPosition - widget.initialOffset).distance;
    final opacity = max(0.2, 1.0 - (distance / 200.0)).clamp(0.0, 1.0);

    return Positioned(
      left: currentPosition.dx,
      top: currentPosition.dy,
      child: GestureDetector(
        onPanUpdate: (details) {
          final newPosition = Offset(
            (currentPosition.dx + details.delta.dx).clamp(0.0, size.width - 60),
            (currentPosition.dy + details.delta.dy).clamp(
              0.0,
              size.height - 60,
            ),
          );

          final newDistance = (newPosition - widget.initialOffset).distance;
          final newIsFarEnough = newDistance > widget.removeThreshold;

          if (newIsFarEnough != _isFarEnough) {
            HapticFeedback.lightImpact();
          }

          setState(() {
            _position = newPosition;
            _isFarEnough = newIsFarEnough;
          });
        },
        onPanEnd: (details) {
          if (_isFarEnough) {
            widget.onRemove?.call();
          } else {
            setState(() {
              _position = null;
              _isFarEnough = false;
            });
          }
        },
        child: Opacity(
          opacity: opacity,
          child: SizedBox(
            height: 60,
            width: 60,
            child: FloatingActionButton(
              onPressed: widget.onPressed,
              shape: const CircleBorder(),
              backgroundColor: theme.colorScheme.surface,
              splashColor: Colors.transparent,
              focusColor: Colors.transparent,
              elevation: 0,
              child: Padding(
                padding: const EdgeInsets.all(2),
                child: widget.child,
              ),
            ),
          ),
        ),
      ),
    );
  }
}
