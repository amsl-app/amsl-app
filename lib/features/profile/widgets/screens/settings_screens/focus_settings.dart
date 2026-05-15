import 'package:amsl_app/constants.dart';
import 'package:amsl_app/features/journal/providers/focus/focus.dart';
import 'package:amsl_app/widgets/async_value_extension.dart';
import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

import '../../../../../models/tori/journal/journal_focus.dart';
import '../../../../../widgets/error/error_bar.dart';
import '../../../../journal/widgets/focus/add_focus_dialog.dart';
import '../../../../tracking/tracking.dart';
import '../../user_focus_list_tile.dart';

class FocusSettings extends ConsumerStatefulWidget {
  const FocusSettings({super.key});

  @override
  ConsumerState<FocusSettings> createState() => _FocusSettingsState();
}

class _FocusSettingsState extends ConsumerState<FocusSettings> {
  bool addFocus = false;
  TextEditingController controller = TextEditingController();

  @override
  Widget build(BuildContext context) {
    final asyncFocus = ref.watch(focusProvider);

    return asyncFocus.build(
      context,
      builder: (context, foci) {
        return _build(
          context,
          ref,
          foci!.values.where((element) => element.userId != null).toList(),
        );
      },
    );
  }

  Widget _build(BuildContext context, WidgetRef ref, List<JournalFocus> foci) {
    final theme = Theme.of(context);
    return Scaffold(
      appBar: AppBar(
        titleSpacing: 0,
        title: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20.0),
          child: Align(
            alignment: Alignment.centerLeft,
            child: Text(
              "Deine Fokusse",
              style: TextStyle(color: theme.colorScheme.onSurface),
            ),
          ),
        ),
        backgroundColor: theme.colorScheme.surface,
        actions: [
          IconButton(
            icon: const Icon(Icons.add),
            onPressed: () => setState(() {
              addFocus = !addFocus;
            }),
          ),
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20.0),
        child: SingleChildScrollView(
          child: foci.isNotEmpty || addFocus
              ? Column(
                  children: List.generate(foci.length + 2, (index) {
                    if (index == foci.length + 1) {
                      return Gap(getBottomBarPadding(context));
                    }
                    if (index == foci.length) {
                      if (addFocus) {
                        return AddFocusRow(
                          onSave: () => setState(() {
                            addFocus = false;
                          }),
                        );
                      } else {
                        return Container();
                      }
                    }
                    JournalFocus focus = foci[index];
                    return UserFocusListTile(
                      hidden: focus.hidden,
                      icon: focus.iconString,
                      name: focus.name,
                      onHide: () async {
                        final new_hidden = !focus.hidden;
                        try {
                          await ref
                              .read(focusProvider.notifier)
                              .editFocus(focusID: focus.id, hidden: new_hidden);
                          trackEvent(
                            category: TrackingCategory.journalFocus,
                            action: new_hidden
                                ? TrackingAction.hide
                                : TrackingAction.show,
                            name: focus.id,
                          );
                        } on Exception catch (e) {
                          if (context.mounted) {
                            showException(context, e);
                          }
                        }
                      },
                    );
                  }),
                )
              : Text(
                  "Du hast noch keinen eigenen Fokus angelegt.",
                  style: theme.textTheme.bodyLarge,
                  textAlign: TextAlign.center,
                ),
        ),
      ),
    );
  }
}
