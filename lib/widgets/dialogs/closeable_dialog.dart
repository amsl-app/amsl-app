import 'package:flutter/material.dart';

class CloseableDialog extends StatelessWidget {
  const CloseableDialog({
    super.key,
    required this.child,
    this.backgroundColor = Colors.white,
    this.onClose,
    this.insetPadding = const EdgeInsets.all(20.0),
    this.outsidePadding = const EdgeInsets.only(
      left: 20.0,
      right: 20.0,
      top: 20.0,
    ),
  });

  final Widget child;
  final Color backgroundColor;
  final Function? onClose;
  final EdgeInsets insetPadding;
  final EdgeInsets outsidePadding;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Dialog(
      backgroundColor: Colors.transparent,
      insetPadding: insetPadding,
      elevation: 0.0,
      child: LayoutBuilder(
        builder: (context, constraints) {
          return Stack(
            children: [
              Padding(
                padding: outsidePadding,
                child: Container(
                  // constraints:
                  //     BoxConstraints(maxHeight: constraints.maxHeight * 0.7),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(20.0),
                    border: Border.all(
                      width: 3.0,
                      color: theme.colorScheme.primary,
                    ),
                    color: backgroundColor,
                  ),
                  child: child,
                ),
              ),
              Positioned(
                top: 5,
                right: 5,
                child: ClipOval(
                  child: Material(
                    color: theme.colorScheme.primary,
                    child: Ink(
                      child: InkWell(
                        onTap: () {
                          if (onClose != null) onClose!();
                          Navigator.pop(context);
                        },
                        child: SizedBox(
                          width: 40,
                          height: 40,
                          child: Center(
                            child: Icon(
                              Icons.close,
                              size: 20,
                              color: theme.colorScheme.onPrimary,
                            ),
                          ),
                        ),
                      ),
                    ),
                  ),
                ),
              ),
            ],
          );
        },
      ),
    );
  }
}
