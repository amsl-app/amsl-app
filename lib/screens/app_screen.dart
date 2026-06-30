import 'dart:math';
import 'dart:ui';

import 'package:amsl_app/features/notifications/notification.dart';
import 'package:amsl_app/features/preferences/preferences.dart';
import 'package:amsl_app/features/profile/providers/variant_provider.dart';
import 'package:amsl_app/features/preferences/storage_keys.dart';
import 'package:amsl_app/features/preferences/storages.dart';
import 'package:amsl_app/features/tracking/tracking.dart';
import 'package:amsl_app/models/tori/modules/module_configuration.dart';
import 'package:amsl_app/providers/hikari_provider.dart';
import 'package:amsl_app/variants.dart';
import 'package:blur/blur.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:logging/logging.dart';
import '../features/modules/providers/module_configuration.dart';
import '../features/profile/providers/user_provider.dart';
import '../models/hikari/modules/session.dart' as hikari_session;
import '../models/tori/modules/module.dart';
import '../models/tori/modules/session.dart';
import '../widgets/absorb_hit.dart';
import '../widgets/buttons/rounded_corner_button.dart';
import '../widgets/dialogs/amsl_dialog.dart';
import '../widgets/error/error_bar.dart';

class AppScreen extends StatefulHookConsumerWidget {
  /// The current state of the parent StatefulShellRoute.
  final StatefulNavigationShell navigationShell;

  const AppScreen({super.key, required this.navigationShell});

  @override
  ConsumerState<AppScreen> createState() => _AppScreenState();
}

class _AppScreenState extends ConsumerState<AppScreen>
    with WidgetsBindingObserver {
  static final log = Logger('AppScreenState');
  final listeners = <ProviderSubscription>[];

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addObserver(this);
    log.info("AppScreenState initState called");

    listeners.addAll([
      // Module Update Listeners
      ref.listenManual<
        AsyncValue<ModuleConfiguration>
      >(moduleConfigurationProviderProvider, (previous, next) {
        final ModuleConfiguration? oldModules;
        final ModuleConfiguration? newModules;
        try {
          oldModules = previous?.value;
          newModules = next.value;
        } on HikariNotInitializedException catch (e) {
          log.info("Ignoring error: $e");
          return;
        }
        if (newModules == null || newModules == oldModules) return;
        log.fine(
          "Module configuration updated, triggering notification state update",
        );
        NotificationService().recreateNotifications(
          ref.read(preferencesProvider),
          moduleConfig: newModules,
        );
      }),

      // Preference Listeners
      ref.listenManual<PreferencesState>(preferencesProvider, (previous, next) {
        final analyticsPermission = next.trackingPermission;
        final crashReportingPermission = next.crashReportingPermission;
        final userID = ref.read(userPodProvider).asData?.value.id;
        updateTrackers(
          analyticsPermission,
          crashReportingPermission,
          userID: userID,
        );

        NotificationService().recreateNotifications(
          next,
          moduleConfig: ref
              .read(moduleConfigurationProviderProvider)
              .asData
              ?.value,
        );
      }, fireImmediately: true),
    ]);

    ref.listenManual<AsyncValue<Variant>>(variantPodProvider, (previous, next) {
      final variantName = next.value?.variantName;
      if (variantName != null) {
        trackDimension(
          dimension: TrackingDimension.variant,
          value: variantName,
        );
      }
    });
  }

  @override
  void dispose() {
    WidgetsBinding.instance.removeObserver(this);
    // for (final listener in listeners) {
    //   listener.close();
    // }
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    final asyncUserProvider = ref.watch(userPodProvider);
    final moduleConfigurationProvider = ref.watch(
      moduleConfigurationProviderProvider,
    );
    final sharedPreferences = ref.watch(storagesProvider).shared;

    final bool onboardingDismissed =
        sharedPreferences.getBool(StorageKey.dismissedOnBoarding.key) ?? false;

    final userData = asyncUserProvider.asData;
    final moduleConfigurationData = moduleConfigurationProvider.asData;
    final Module? onboarding =
        moduleConfigurationData?.value.onboarding?.module;

    startSession(Session session) {
      context.pushNamed(
        "chat",
        pathParameters: {
          "moduleID": session.module.target!.id,
          "sessionID": session.id,
        },
      );
    }

    dismissOnboarding() async {
      await sharedPreferences.setBool(StorageKey.dismissedOnBoarding.key, true);
      setState(() {});
    }

    startOnboarding() {
      if (onboarding != null) {
        log.info("Starting onboarding module ${onboarding.id}");
        Session session;
        if (onboarding.defaultSession != null) {
          session = onboarding.defaultSession!;
        } else {
          session = onboarding.sessions.valueAt(0);
        }
        while (session.status == hikari_session.SessionStatus.finished &&
            session.next != null &&
            session.next!.status != hikari_session.SessionStatus.notStarted) {
          session = session.next!;
        }
        dismissOnboarding(); // Dismiss onboarding when user starts it
        startSession(session);
      } else {
        showMessage(
          context,
          label: "Es ist etwas schief gegangen. Starte die App neu.",
        );
        log.severe("No onboarding module found");
      }
    }

    bool isInReflectionEntry = GoRouterState.of(
      context,
    ).uri.toString().contains("reflection/course");

    bool isInChat = GoRouterState.of(context).uri.toString().contains("chat");

    bool showOnboarding =
        userData != null &&
        userData.value.variant.onboardingEnabled &&
        onboarding != null &&
        !onboardingDismissed &&
        widget.navigationShell.currentIndex == 0;

    bool showBottomNavigationBar = !(isInChat || isInReflectionEntry);

    bool blurBottomNavigationBar = showBottomNavigationBar && showOnboarding;

    // bool showChat =
    //     showBottomNavigationBar &&
    //     !showOnboarding &&
    //     false; // TODO find soultion here

    return Builder(
      builder: (BuildContext context) {
        onTap(int index) {
          log.info(
            "Moving from ${widget.navigationShell.currentIndex} to $index",
          );

          widget.navigationShell.goBranch(
            index,
            initialLocation: index == widget.navigationShell.currentIndex,
          );
        }

        Color buttonColor(int index) {
          if (widget.navigationShell.currentIndex == index) {
            return theme.bottomNavigationBarTheme.selectedItemColor!;
          }
          return theme.bottomNavigationBarTheme.unselectedItemColor!;
        }

        return Scaffold(
          body: Stack(
            children: [
              widget.navigationShell,
              //Onboarding screen
              Visibility(
                visible: showOnboarding,
                child: Stack(
                  children: [
                    Blur(child: Container()),
                    Container(
                      padding: EdgeInsets.only(
                        bottom: max(
                          MediaQuery.of(context).padding.bottom - 30,
                          0,
                        ),
                      ),
                      child: AmslDialog(
                        bottomBar: true,
                        onClose: () {
                          dismissOnboarding();
                        },
                        content:
                            "Bevor du los legts. Lass mich dir eine Einführung geben.",
                        buttonBar: [
                          RoundedCornerButton(
                            label: "Los gehts",
                            onTap: () => startOnboarding(),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
              // if (showChat)
              //   MovableFloatingActionButton(
              //     onPressed: () {
              //       context.pushNamed("chat");
              //     },
              //     onRemove: () =>
              //         ref.read(currentSessionProvider.notifier).clear(),
              //     initialOffset: Offset(
              //       MediaQuery.of(context).size.width - 60 - 16,
              //       MediaQuery.of(context).size.height -
              //           60 -
              //           (showBottomNavigationBar ? 80 : 0) -
              //           16,
              //     ),
              //     child: SvgPicture.asset(
              //       "assets/images/avatar_images/avatar_centered.svg",
              //     ),
              //   ),
              //Loading animation
            ],
          ),
          extendBody: true,
          bottomNavigationBar: (showBottomNavigationBar)
              ? ClipRRect(
                  borderRadius: const BorderRadius.only(
                    topLeft: Radius.circular(16),
                    topRight: Radius.circular(16),
                  ),
                  child: AbsorbHit(
                    child: Stack(
                      alignment: AlignmentDirectional.bottomEnd,
                      children: [
                        Theme(
                          // Material 3 seems very buggy for bottom app bar
                          // ignore: deprecated_member_use
                          data: theme.copyWith(useMaterial3: false),
                          child: BottomAppBar(
                            child: Container(
                              padding: const EdgeInsets.only(
                                left: 10,
                                right: 10,
                                top: 4,
                              ),
                              child: Row(
                                mainAxisSize: MainAxisSize.max,
                                children: [
                                  Expanded(
                                    flex: 2,
                                    child: GestureDetector(
                                      behavior: HitTestBehavior.translucent,
                                      onTap: () {
                                        onTap(0);
                                      },
                                      child: Container(
                                        padding: const EdgeInsets.all(4),
                                        child: Column(
                                          mainAxisSize: MainAxisSize.min,
                                          children: [
                                            Icon(
                                              Icons.home_outlined,
                                              color: buttonColor(0),
                                            ),
                                            Text(
                                              "Home",
                                              style: theme.textTheme.titleSmall!
                                                  .copyWith(
                                                    color: buttonColor(0),
                                                  ),
                                            ),
                                          ],
                                        ),
                                      ),
                                    ),
                                  ),
                                  // const Gap(4),
                                  // Expanded(
                                  //   flex: 2,
                                  //   child: GestureDetector(
                                  //     behavior: HitTestBehavior.translucent,
                                  //     onTap: () {
                                  //       onTap(1);
                                  //     },
                                  //     child: Container(
                                  //       padding: const EdgeInsets.all(4),
                                  //       child: Column(
                                  //         mainAxisSize: MainAxisSize.min,
                                  //         children: [
                                  //           Icon(
                                  //             Icons.now_widgets_outlined,
                                  //             color: buttonColor(1),
                                  //           ),
                                  //           Text(
                                  //             "Tools",
                                  //             style: theme.textTheme.titleSmall!
                                  //                 .copyWith(
                                  //                   color: buttonColor(1),
                                  //                 ),
                                  //           ),
                                  //         ],
                                  //       ),
                                  //     ),
                                  //   ),
                                  // ),
                                  // const Expanded(flex: 1, child: SizedBox()),
                                  Expanded(
                                    flex: 2,
                                    child: GestureDetector(
                                      behavior: HitTestBehavior.translucent,
                                      onTap: () {
                                        onTap(1);
                                      },
                                      child: Container(
                                        padding: const EdgeInsets.all(4),
                                        child: Column(
                                          mainAxisSize: MainAxisSize.min,
                                          children: [
                                            Icon(
                                              Icons.folder_copy_outlined,
                                              color: buttonColor(1),
                                            ),
                                            Text(
                                              "Einheiten",
                                              style: theme.textTheme.titleSmall!
                                                  .copyWith(
                                                    color: buttonColor(1),
                                                  ),
                                            ),
                                          ],
                                        ),
                                      ),
                                    ),
                                  ),
                                  // const Gap(4),
                                  Expanded(
                                    flex: 2,
                                    child: GestureDetector(
                                      behavior: HitTestBehavior.translucent,
                                      onTap: () {
                                        onTap(2);
                                      },
                                      child: Container(
                                        padding: const EdgeInsets.all(4),
                                        child: Column(
                                          mainAxisSize: MainAxisSize.min,
                                          children: [
                                            Icon(
                                              Icons.perm_contact_cal_outlined,
                                              color: buttonColor(2),
                                            ),
                                            Text(
                                              "Profil",
                                              style: theme.textTheme.titleSmall!
                                                  .copyWith(
                                                    color: buttonColor(2),
                                                  ),
                                            ),
                                          ],
                                        ),
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ),
                        //onboarding blur
                        Visibility(
                          visible: blurBottomNavigationBar,
                          child: Positioned.fill(
                            child: BackdropFilter(
                              filter: ImageFilter.blur(sigmaX: 2, sigmaY: 2),
                              child: Container(
                                decoration: BoxDecoration(
                                  color: Colors.white.withValues(alpha: 0),
                                ),
                                alignment: Alignment.center,
                                child: Container(),
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                )
              : null,
        );
      },
    );
  }
}
