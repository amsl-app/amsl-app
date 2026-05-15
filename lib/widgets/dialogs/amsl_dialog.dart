import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

import '../../constants.dart';

class AmslDialog extends StatelessWidget {
  final String content;
  final Widget? child;
  final List<Widget> buttonBar;
  final Function? onClose;
  final bool bottomBar;
  final bool error;
  final Color backgroundColor;
  final Color textBackgroundColor;

  const AmslDialog({
    super.key,
    this.content = "Es ist ein Fehler beim Laden aufgetreten",
    this.child,
    this.buttonBar = const [],
    this.onClose,
    this.bottomBar = false,
    this.error = false,
    this.backgroundColor = const Color(0xFFE2E2E2),
    this.textBackgroundColor = Colors.white,
  });

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    Widget? child = this.child;

    child ??= Text(
      content,
      style: theme.textTheme.bodyLarge!.copyWith(
        fontWeight: FontWeight.bold,
        color: error ? theme.colorScheme.onError : theme.colorScheme.onSurface,
      ),
      textAlign: TextAlign.center,
    );

    return LayoutBuilder(
      builder: (context, constraints) {
        return SizedBox(
          height: constraints.maxHeight,
          child: Stack(
            children: [
              Positioned(
                height: constraints.maxHeight,
                width: constraints.maxWidth,
                top: bottomBar ? 80.0 - getBottomBarHeight(context) : 80.0,
                child: Align(
                  alignment: Alignment.bottomCenter,
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 20),
                        child: ClipRRect(
                          borderRadius: BorderRadius.circular(20),
                          child: Container(
                            constraints: BoxConstraints(
                              maxHeight: constraints.maxHeight * 0.6,
                            ),
                            color: backgroundColor,
                            width: double.infinity,
                            child: SingleChildScrollView(
                              child: Column(
                                mainAxisSize: MainAxisSize.min,
                                children: [
                                  if (onClose != null)
                                    Align(
                                      alignment: Alignment.topRight,
                                      child: IconButton(
                                        padding: EdgeInsets.zero,
                                        color: error
                                            ? theme.colorScheme.onError
                                            : theme.colorScheme.onSurface,
                                        iconSize: 20,
                                        onPressed: () => onClose!(),
                                        icon: const Icon(Icons.close_rounded),
                                      ),
                                    ),
                                  Padding(
                                    padding: EdgeInsets.only(
                                      left: 20.0,
                                      right: 20.0,
                                      bottom: buttonBar.isNotEmpty ? 0.0 : 20.0,
                                      top: onClose != null ? 0 : 20.0,
                                    ),
                                    child: Container(
                                      padding: const EdgeInsets.all(12),
                                      decoration: BoxDecoration(
                                        borderRadius: const BorderRadius.all(
                                          Radius.circular(12),
                                        ),
                                        color: textBackgroundColor,
                                      ),
                                      child: child,
                                    ),
                                  ),
                                  if (buttonBar.isNotEmpty)
                                    Padding(
                                      padding: EdgeInsets.all(20.0),
                                      child: SingleChildScrollView(
                                        child: Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.spaceEvenly,
                                          children: buttonBar,
                                        ),
                                      ),
                                    ),
                                ],
                              ),
                            ),
                          ),
                        ),
                      ),
                      RotationTransition(
                        turns: const AlwaysStoppedAnimation(8 / 360),
                        child: SvgPicture.asset(
                          "assets/images/avatar_images/amsl_body.svg",
                          height: 200,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        );
      },
    );
  }
}

Future showAmslBottomSheet({
  required BuildContext context,
  Function? onClose,
  String content = "Es ist ein Fehler beim Laden aufgetreten",
  Widget? child,
  List<Widget> buttonBar = const [],
  bool bottomBar = false,
  bool error = false,
}) async {
  await showModalBottomSheet(
    isScrollControlled: true,
    enableDrag: false,
    isDismissible: false,
    elevation: 0,
    context: context,
    backgroundColor: Colors.transparent,
    builder: (BuildContext context) {
      return AmslDialog(
        content: content,
        bottomBar: bottomBar,
        buttonBar: buttonBar,
        error: error,
        onClose: onClose == null ? null : () => onClose(),
        child: child,
      );
    },
  );
}
