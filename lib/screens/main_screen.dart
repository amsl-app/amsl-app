import 'package:amsl_app/constants.dart';
import 'package:amsl_app/features/profile/providers/user_provider.dart';
import 'package:amsl_app/screens/home/home_card_order_provider.dart';
import 'package:amsl_app/screens/home/home_settings_sheet.dart';
import 'package:amsl_app/screens/home/journal_home_card.dart';
import 'package:amsl_app/screens/home/module_home_card.dart';
import 'package:amsl_app/screens/home/planner_home_card.dart';
import 'package:amsl_app/screens/home/self_management_home_card.dart';
import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:intl/intl.dart';
import 'package:logging/logging.dart';

class MainScreen extends ConsumerWidget {
  static final log = Logger('MainScreen');

  const MainScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    log.info('Building home screen');
    final order = ref.watch(homeCardOrderProvider);

    return Scaffold(
      body: SafeArea(
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const _GreetingSection(),
                const Gap(24),
                for (int i = 0; i < order.length; i++) ...[
                  if (i > 0) const Gap(16),
                  _cardFor(order[i]),
                ],
                const Gap(24),
                Gap(getBottomBarHeight(context)),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _cardFor(HomeCardId id) => switch (id) {
    HomeCardId.journal => const JournalHomeCard(),
    HomeCardId.module => const ModuleHomeCard(),
    HomeCardId.planner => const PlannerHomeCard(),
    HomeCardId.selfManagement => const SelfManagementHomeCard(),
  };
}

class _GreetingSection extends ConsumerWidget {
  const _GreetingSection();

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final asyncUser = ref.watch(userPodProvider);
    final theme = Theme.of(context);
    final name = asyncUser.value?.name ?? '';
    final dateStr = DateFormat('EEEE, d. MMMM').format(DateTime.now());

    return Padding(
      padding: const EdgeInsets.only(top: 24),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisSize: MainAxisSize.min,
              children: [
                Text(
                  'Hello $name!',
                  style: theme.textTheme.titleLarge?.copyWith(
                    fontWeight: FontWeight.bold,
                  ),
                ),
                Text(
                  dateStr,
                  style: theme.textTheme.bodyMedium?.copyWith(
                    color: theme.colorScheme.onSurface.withValues(alpha: 0.6),
                  ),
                ),
              ],
            ),
          ),
          IconButton(
            icon: const Icon(Icons.tune),
            onPressed: () => showHomeSettingsSheet(context),
            tooltip: 'Karten anordnen',
          ),
        ],
      ),
    );
  }
}
