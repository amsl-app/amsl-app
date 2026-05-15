import 'package:amsl_app/features/profile/widgets/screens/settings.dart';
import 'package:amsl_app/widgets/async_value_extension.dart';
import 'package:amsl_app/widgets/loading/loading_text.dart';
import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:shimmer/shimmer.dart';

import '../../../../../models/hikari/user/user.dart';
import '../../../../widgets/dialogs/amsl_dialog.dart';
import '../../../history/widgets/screens/history.dart';
import '../../providers/user_provider.dart';

class ProfileScreen extends StatefulHookConsumerWidget {
  const ProfileScreen({super.key});

  @override
  ConsumerState<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends ConsumerState<ProfileScreen> {
  @override
  Widget build(BuildContext context) {
    final asyncUser = ref.watch(userPodProvider);
    return asyncUser.build(
      context,
      builder: (context, user) => _build(context, user),
      loadingBuilder: (context) => _build(context, null),
      errorBuilder: (context, error, stackTrace) => _build(context, null),
    );
  }

  Widget _build(BuildContext context, User? user) {
    final theme = Theme.of(context);

    return Scaffold(
      appBar: AppBar(
        titleSpacing: 0,
        title: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20.0),
          child: Align(
            alignment: Alignment.centerLeft,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: user == null
                  ? [
                      Shimmer.fromColors(
                        baseColor: Colors.grey.shade300,
                        highlightColor: Colors.grey.shade100,
                        period: const Duration(milliseconds: 3000),
                        child: LayoutBuilder(
                          builder:
                              (
                                BuildContext context,
                                BoxConstraints constrains,
                              ) {
                                return Container(
                                  height: 15,
                                  width: constrains.maxWidth * 0.4,
                                  color: Colors.white,
                                );
                              },
                        ),
                      ),
                      const Gap(5),
                      Shimmer.fromColors(
                        baseColor: Colors.grey.shade300,
                        highlightColor: Colors.grey.shade100,
                        period: const Duration(milliseconds: 3000),
                        child: LayoutBuilder(
                          builder:
                              (
                                BuildContext context,
                                BoxConstraints constrains,
                              ) {
                                return Container(
                                  height: 15,
                                  width: constrains.maxWidth * 0.6,
                                  color: Colors.white,
                                );
                              },
                        ),
                      ),
                    ]
                  : [
                      Text(
                        user.name ?? "",
                        style: TextStyle(color: theme.colorScheme.onSurface),
                      ),
                    ],
            ),
          ),
        ),
        backgroundColor: theme.colorScheme.surface,
        actions: [
          IconButton(
            icon: const Icon(Icons.poll_outlined),
            onPressed: () {
              final userNotifier = ref.read(userPodProvider.notifier);
              showAmslBottomSheet(
                bottomBar: true,
                context: context,
                onClose: () => Navigator.pop(context),
                child: FutureBuilder(
                  future: userNotifier.generateSurveyCode(),
                  builder: (BuildContext context, snapshot) {
                    if (snapshot.hasData) {
                      return Column(
                        children: [
                          Text(
                            "Dies ist dein Code um an unseren Umfragen teilzunehmen: ",
                            style: theme.textTheme.bodyLarge,
                          ),
                          SelectableText(
                            snapshot.data!,
                            style: theme.textTheme.titleMedium,
                          ),
                        ],
                      );
                    }
                    if (snapshot.hasError) {
                      return Text(snapshot.error.toString());
                    }
                    return const LoadingText(width: 200);
                  },
                ),
              );
            },
          ),
        ],
      ),
      body: DefaultTabController(
        length: 2,
        initialIndex: 0,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisSize: MainAxisSize.max,
          children: [
            TabBar(
              onTap: (int i) {
                if (i == 1) FocusManager.instance.primaryFocus?.unfocus();
              },
              isScrollable: false,
              labelPadding: const EdgeInsets.symmetric(horizontal: 20.0),
              padding: EdgeInsets.zero,
              indicatorColor: theme.colorScheme.tertiaryContainer,
              dividerColor: theme.colorScheme.surfaceContainer,
              indicatorSize: TabBarIndicatorSize.tab,
              indicatorWeight: 4,
              labelColor: theme.colorScheme.primary,
              labelStyle: theme.textTheme.titleMedium,
              tabs: const [
                Tab(text: "Historie"),
                Tab(text: "Einstellungen"),
              ],
            ),
            const Expanded(
              child: TabBarView(children: [History(), Settings()]),
            ),
          ],
        ),
      ),
    );
  }
}
