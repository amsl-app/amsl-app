import 'package:amsl_app/screens/home/home_card_order_provider.dart';
import 'package:amsl_app/widgets/dialogs/amsl_dialog.dart';
import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

void showHomeSettingsSheet(BuildContext context) {
  showAmslBottomSheet(
    context: context,
    bottomBar: true,
    onClose: () => Navigator.of(context).pop(),
    child: Consumer(
      builder: (context, ref, _) {
        final theme = Theme.of(context);
        final order = ref.watch(homeCardOrderProvider);
        return Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Karten anordnen',
              style: theme.textTheme.titleMedium?.copyWith(
                fontWeight: FontWeight.bold,
              ),
            ),
            const Gap(12),
            ReorderableListView(
              shrinkWrap: true,
              physics: const NeverScrollableScrollPhysics(),
              onReorder: (oldIndex, newIndex) => ref
                  .read(homeCardOrderProvider.notifier)
                  .reorder(oldIndex, newIndex),
              children: [
                for (final id in order)
                  ListTile(
                    key: ValueKey(id),
                    leading: Icon(id.icon),
                    title: Text(id.label),
                    trailing: const Icon(Icons.drag_handle),
                  ),
              ],
            ),
          ],
        );
      },
    ),
  );
}
