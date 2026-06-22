import 'package:amsl_app/constants.dart';
import 'package:amsl_app/features/modules/providers/module_configuration.dart';
import 'package:amsl_app/features/planner/providers/planner.dart';
import 'package:amsl_app/features/planner/widgets/create_entry_sheet.dart';
import 'package:amsl_app/features/planner/widgets/planner_page_dots.dart';
import 'package:amsl_app/hikari/exception.dart';
import 'package:amsl_app/models/hikari/planner/new_planner_entry.dart';
import 'package:amsl_app/providers/hikari_provider.dart';
import 'package:amsl_app/widgets/buttons/rounded_corner_button.dart';
import 'package:amsl_app/widgets/dialogs/amsl_dialog.dart';
import 'package:amsl_app/widgets/error/error_bar.dart';
import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:gap/gap.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

class PlannerAssistantSheet extends HookConsumerWidget {
  const PlannerAssistantSheet({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final theme = Theme.of(context);
    final textController = useTextEditingController();
    final isConfirming = useState(false);
    final suggestions = useState<List<NewEntryData>?>(null);
    final pageController = usePageController();
    final currentPage = useState(0);

    final moduleConfig = ref.watch(moduleConfigurationProviderProvider);
    final modules = moduleConfig.value?.shownModules.toList() ?? [];

    Future<void> submit() async {
      final text = textController.text.trim();
      if (text.isEmpty) return;

      final hikari = ref.read(hikariPodProvider);
      try {
        final result = await hikari.plannerApi.askAssistant(
          text: text,
          today: kOldDateFormat.format(DateTime.now()),
        );
        if (result.isEmpty) {
          if (context.mounted) {
            showMessage(
              context,
              label: 'Keine Einträge erkannt',
              error: true,
            );
          }
          return;
        }
        suggestions.value = result
            .map(
              (e) => NewEntryData(
                title: e.title,
                date: DateTime.parse(e.date),
                priority: e.priority,
                module: e.moduleId,
                session: e.sessionId,
              ),
            )
            .toList();
      } on HikariException catch (_) {
        if (context.mounted) showMessage(context, error: true);
      }
    }

    Future<void> confirm() async {
      final entries = suggestions.value;
      if (entries == null) return;

      final invalid = entries.where(
        (e) => e.title == null || e.title!.trim().isEmpty,
      );
      if (invalid.isNotEmpty) {
        showMessage(context, label: 'Bitte einen Titel eingeben', error: true);
        return;
      }

      isConfirming.value = true;
      try {
        await ref.read(plannerProviderProvider.notifier).bulkCreateEntries(
          entries
              .map(
                (e) => NewPlannerEntry(
                  date: kOldDateFormat.format(e.date),
                  title: e.title!,
                  priority: e.priority,
                  moduleId: e.module,
                  sessionId: e.session,
                ),
              )
              .toList(),
        );
        if (context.mounted) Navigator.of(context).pop();
      } on HikariException catch (_) {
        if (context.mounted) showMessage(context, error: true);
      } finally {
        isConfirming.value = false;
      }
    }

    if (suggestions.value != null) {
      final entries = suggestions.value!;
      return Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Text(
            'Vorschläge prüfen',
            style: theme.textTheme.titleSmall?.copyWith(
              color: theme.colorScheme.onSurface.withValues(alpha: 0.5),
              letterSpacing: 0.5,
            ),
          ),
          const Gap(16),
          SizedBox(
            height: MediaQuery.sizeOf(context).height * 0.34,
            child: PageView.builder(
              controller: pageController,
              onPageChanged: (i) => currentPage.value = i,
              itemCount: entries.length,
              itemBuilder: (_, i) => SingleChildScrollView(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    Text(
                      'Eintrag #${i + 1}',
                      style: theme.textTheme.titleSmall?.copyWith(
                        color: theme.colorScheme.onSurface.withValues(
                          alpha: 0.5,
                        ),
                        letterSpacing: 0.5,
                      ),
                    ),
                    const Gap(8),
                    CreateEntryCard(entry: entries[i], modules: modules),
                  ],
                ),
              ),
            ),
          ),
          if (entries.length > 1) ...[
            const Gap(8),
            PlannerPageDots(
              count: entries.length,
              currentPage: currentPage.value,
              controller: pageController,
            ),
          ],
          const Gap(12),
          Row(
            children: [
              TextButton(
                onPressed: isConfirming.value
                    ? null
                    : () => suggestions.value = null,
                child: const Text('Zurück'),
              ),
              const Gap(8),
              Expanded(
                child: RoundedCornerButton(
                  label: 'Alle erstellen',
                  onTap: isConfirming.value ? null : confirm,
                  buttonColor: theme.colorScheme.primary,
                  labelColor: theme.colorScheme.onPrimary,
                ),
              ),
            ],
          ),
        ],
      );
    }

    final inputBorder = OutlineInputBorder(
      borderRadius: BorderRadius.circular(12),
      borderSide: BorderSide(
        color: theme.colorScheme.outline.withValues(alpha: 0.4),
      ),
    );
    final focusedBorder = OutlineInputBorder(
      borderRadius: BorderRadius.circular(12),
      borderSide: BorderSide(color: theme.colorScheme.primary, width: 2),
    );

    return Column(
      mainAxisSize: MainAxisSize.min,
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        Text(
          'Planner Assistent',
          style: theme.textTheme.titleSmall?.copyWith(
            color: theme.colorScheme.onSurface.withValues(alpha: 0.5),
            letterSpacing: 0.5,
          ),
        ),
        const Gap(16),
        TextField(
          controller: textController,
          maxLines: 5,
          minLines: 3,
          textCapitalization: TextCapitalization.sentences,
          style: theme.textTheme.bodyLarge,
          decoration: InputDecoration(
            hintText: 'Beschreibe, was du planen möchtest…',
            border: inputBorder,
            enabledBorder: inputBorder,
            focusedBorder: focusedBorder,
            contentPadding: const EdgeInsets.symmetric(
              horizontal: 12,
              vertical: 10,
            ),
          ),
        ),
        const Gap(12),
        RoundedCornerButton(
          label: 'Analysieren',
          onTap: submit,
          buttonColor: theme.colorScheme.primary,
          labelColor: theme.colorScheme.onPrimary,
        ),
      ],
    );
  }
}

void showPlannerAssistantSheet(BuildContext context, WidgetRef ref) {
  showAmslBottomSheet(
    context: context,
    child: const PlannerAssistantSheet(),
    onClose: () => Navigator.of(context).pop(),
    bottomBar: true,
  );
}
