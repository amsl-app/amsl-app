import 'package:amsl_app/features/journal/models/focus_icons.dart';
import 'package:amsl_app/features/journal/providers/focus/focus.dart';
import 'package:amsl_app/features/tracking/tracking.dart';
import 'package:amsl_app/widgets/async_value_extension.dart';
import 'package:amsl_app/widgets/dialogs/closeable_dialog.dart';
import 'package:flutter/material.dart';
import 'package:flutter_shakemywidget/flutter_shakemywidget.dart';
import 'package:gap/gap.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

import '../../../../hikari/exception.dart';
import '../../../../widgets/error/error_bar.dart';

class AddFocusRow extends StatefulHookConsumerWidget {
  const AddFocusRow({super.key, this.onSave});

  final Function? onSave;
  @override
  ConsumerState<AddFocusRow> createState() => _AddFocusDialogState();
}

class _AddFocusDialogState extends ConsumerState<AddFocusRow> {
  bool isLoading = false;
  bool textError = false;
  bool iconError = false;

  final TextEditingController _controller = TextEditingController();
  Widget? _icon;

  final shakeKey = GlobalKey<ShakeWidgetState>();

  Future _save(String label, Widget? icon) async {
    if (isLoading) return;
    iconError = textError = false;

    if (icon == null) {
      setState(() {
        shakeKey.currentState?.shake();
        iconError = true;
      });
    }
    if (label.isEmpty) {
      setState(() {
        textError = true;
      });
    }
    if (iconError || textError) return;

    setState(() {
      isLoading = true;
    });
    if (mounted) {
      ref
          .read(focusProvider.notifier)
          .addFocus(
            name: _controller.text,
            icon: FocusIcons.getStringFromIcon(icon!)!,
          )
          .handle(
            context,
            onData: (_) {
              trackEvent(
                category: TrackingCategory.journalFocus,
                action: TrackingAction.add,
                name: _controller.text,
              );
              if (widget.onSave != null) {
                widget.onSave!();
              }
            },
            onError: (e, s) {
              setState(() {
                isLoading = false;
              });
              final Object exception;
              if (e is HikariException) {
                exception = e.copyWith(resolve: () => _save(label, icon));
              } else {
                exception = e;
              }
              showException(context, exception);
            },
          );
    }
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Column(
      mainAxisSize: MainAxisSize.min,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            InkWell(
              onTap: () async {
                IconWrapper newIcon = IconWrapper();
                await showDialog(
                  context: context,
                  builder: (BuildContext context) {
                    return SelectIconDialog(icon: newIcon);
                  },
                );
                setState(() {
                  iconError = false;
                  _icon = newIcon.icon;
                });
              },
              child: Container(
                width: 50,
                height: 50,
                decoration: BoxDecoration(
                  border: Border.all(
                    width: 2.0,
                    color: iconError
                        ? theme.colorScheme.onError
                        : theme.colorScheme.primary,
                  ),
                  borderRadius: BorderRadius.circular(12.0),
                ),
                child: Center(
                  child: ShakeMe(
                    key: shakeKey,
                    shakeCount: 3,
                    shakeOffset: 5,
                    shakeDuration: const Duration(milliseconds: 500),
                    child:
                        _icon ??
                        SizedBox(
                          height: 32,
                          width: 32,
                          child: Icon(
                            Icons.emoji_emotions,
                            size: 32,
                            color: iconError
                                ? theme.colorScheme.onError
                                : theme.colorScheme.primary,
                          ),
                        ),
                  ),
                ),
              ),
            ),
            const Gap(10.0),
            Expanded(
              child: Container(
                width: 50,
                height: 50,
                decoration: BoxDecoration(
                  border: Border.all(
                    width: 2.0,
                    color: iconError
                        ? theme.colorScheme.onError
                        : theme.colorScheme.primary,
                  ),
                  borderRadius: BorderRadius.circular(12.0),
                ),
                padding: const EdgeInsets.symmetric(horizontal: 10.0),
                child: Row(
                  children: [
                    Expanded(
                      child: TextFormField(
                        autofocus: true,
                        style: theme.textTheme.bodyMedium!.copyWith(
                          color: theme.colorScheme.onSurface,
                        ),
                        maxLength: 32,
                        controller: _controller,
                        decoration: const InputDecoration(
                          border: InputBorder.none,
                          counterText: "",
                        ),
                        onTap: () => setState(() {
                          textError = false;
                        }),
                      ),
                    ),
                    IconButton(
                      onPressed: !isLoading
                          ? () => _save(_controller.text.trim(), _icon)
                          : null,
                      icon: const Icon(
                        Icons.send,
                        // color: isLoading
                        //     ? theme.colorScheme.onPrimary.withValues(alpha: 0.5)
                        //     : theme.colorScheme.primary,
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
        if (iconError)
          const Padding(
            padding: EdgeInsets.only(top: 10.0),
            child: Text(
              "Bitte wähle ein Icon aus.",
              style: TextStyle(color: Colors.red),
            ),
          ),
        if (textError)
          const Padding(
            padding: EdgeInsets.only(top: 10.0),
            child: Text(
              "Bitte gib einen Namen ein.",
              style: TextStyle(color: Colors.red),
            ),
          ),
      ],
    );
  }
}

class SelectIconDialog extends StatelessWidget {
  SelectIconDialog({super.key, required this.icon});

  final IconWrapper icon;

  final List<Widget> icons = FocusIcons.getIconMap(
    width: size,
    height: size,
  ).values.toList();
  final int rows = (FocusIcons.getIconMap().length / columns).ceil();

  static const size = 40.0;
  static const int columns = 3;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    List<Widget> icons = FocusIcons.getIconMap(
      width: size,
      height: size,
    ).values.toList();
    final int rows = (icons.length / columns).ceil();

    return CloseableDialog(
      backgroundColor: theme.colorScheme.surface,
      child: LayoutBuilder(
        builder: (context, constraints) {
          return Container(
            constraints: BoxConstraints(maxHeight: constraints.maxHeight * 0.7),
            child: Padding(
              padding: const EdgeInsets.all(0.0),
              child: SingleChildScrollView(
                child: Column(
                  children: List.generate(
                    rows,
                    (currentRow) => Padding(
                      padding: const EdgeInsets.symmetric(vertical: 20.0),
                      child: Row(
                        mainAxisSize: MainAxisSize.max,
                        mainAxisAlignment: MainAxisAlignment.spaceAround,
                        children: List.generate(
                          columns,
                          (currentColumn) => _getCurrentIcon(
                            context: context,
                            currentColumn: currentColumn,
                            currentRow: currentRow,
                          ),
                        ),
                      ),
                    ),
                  ),
                ),
              ),
            ),
          );
        },
      ),
    );
  }

  Widget _getCurrentIcon({
    required BuildContext context,
    required int currentColumn,
    required int currentRow,
  }) {
    int index = currentRow * columns + currentColumn;

    if (index >= icons.length) {
      return const SizedBox(width: size, height: size);
    }
    return GestureDetector(
      child: icons[index],
      onTap: () {
        icon.icon = icons[index];
        Navigator.pop(context);
      },
    );
  }
}

class IconWrapper {
  Widget? icon;
}
