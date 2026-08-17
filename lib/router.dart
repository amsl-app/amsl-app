import 'package:amsl_app/authentication/async_login_provider.dart';
import 'package:amsl_app/features/assessment/widgets/screens/assessment_evaluation_screen.dart';
import 'package:amsl_app/features/assessment/widgets/screens/assessment_screen.dart';
import 'package:amsl_app/features/chat/widgets/chat_screen/chat_screen.dart';
import 'package:amsl_app/features/focus_timer/widgets/focus_timer.dart';
import 'package:amsl_app/features/journal/widgets/screens/journal.dart';
import 'package:amsl_app/features/journal/widgets/screens/reflection_screen.dart';
import 'package:amsl_app/features/journal/widgets/screens/single_journal_screen.dart';
import 'package:amsl_app/features/modules/widgets/screens/modules_screen.dart';
import 'package:amsl_app/features/modules/widgets/screens/session_selection_screen.dart';
import 'package:amsl_app/features/pdf/widgets/pdf_screen.dart';
import 'package:amsl_app/features/profile/widgets/screens/profile_screen.dart';
import 'package:amsl_app/features/profile/widgets/screens/settings_screens/about_us/about_us.dart';
import 'package:amsl_app/features/profile/widgets/screens/settings_screens/app_information/app_information.dart';
import 'package:amsl_app/features/profile/widgets/screens/settings_screens/app_information/package_license.dart';
import 'package:amsl_app/features/profile/widgets/screens/settings_screens/focus_settings.dart';
import 'package:amsl_app/features/profile/widgets/screens/settings_screens/notification_settings.dart';
import 'package:amsl_app/features/profile/widgets/screens/settings_screens/profile_settings.dart';
import 'package:amsl_app/features/profile/widgets/settings/debug_settings.dart';
import 'package:amsl_app/features/quiz/widgets/screens/module_quiz_screen.dart';
import 'package:amsl_app/features/quiz/widgets/screens/quiz.dart';
import 'package:amsl_app/features/quiz/widgets/screens/quiz_session_screen.dart';
import 'package:amsl_app/features/tracking/tracking.dart';
import 'package:amsl_app/features/upgrade_check/upgrade_alert.dart';
import 'package:amsl_app/models/hikari/assessments/assessment_session.dart'
    as hikari_assessment;
import 'package:amsl_app/screens/app_screen.dart';
import 'package:amsl_app/screens/main_screen.dart';
import 'package:amsl_app/screens/start_screen.dart';
import 'package:amsl_app/widgets/error/error_bar.dart';
import 'package:amsl_app/widgets/flavor_banner.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:logging/logging.dart';

final _log = Logger("Router");

GoRouter createRouterDelegate(LoginState logInState) {
  final GlobalKey<NavigatorState> rootNavigatorKey = GlobalKey<NavigatorState>(
    debugLabel: 'root',
  );

  final GlobalKey<NavigatorState> homeNavigatorKey = GlobalKey<NavigatorState>(
    debugLabel: 'home',
  );

  final GlobalKey<NavigatorState> modulesNavigatorKey =
      GlobalKey<NavigatorState>(debugLabel: 'modules');

  final GlobalKey<NavigatorState> profileNavigatorKey =
      GlobalKey<NavigatorState>(debugLabel: 'profile');

  final initialPath = logInState is Authenticated ? '/home' : '/start';

  _log.info("Initial Path: $initialPath");

  return GoRouter(
    navigatorKey: rootNavigatorKey,
    initialLocation: initialPath,
    routes: <RouteBase>[
      GoRoute(
        name: "start",
        path: '/start',
        builder: (BuildContext context, GoRouterState state) =>
            const UpgradeAlert(
              child: FlavorBanner(show: kDebugMode, child: StartScreen()),
            ),
      ),
      StatefulShellRoute.indexedStack(
        branches: <StatefulShellBranch>[
          StatefulShellBranch(
            navigatorKey: homeNavigatorKey,
            routes: <RouteBase>[
              GoRoute(
                name: "home",
                path: '/home',
                builder: (BuildContext context, GoRouterState state) =>
                    const MainScreen(),
                routes: <RouteBase>[
                  GoRoute(
                    name: 'chat',
                    path: '/chat/:moduleID/:sessionID',
                    builder: (BuildContext context, GoRouterState state) {
                      final moduleID = state.pathParameters['moduleID']!;
                      final sessionID = state.pathParameters['sessionID']!;
                      return ChatScreen(
                        moduleID: moduleID,
                        sessionID: sessionID,
                      );
                    },
                    routes: <RouteBase>[
                      GoRoute(
                        name: 'sources',
                        path: '/sources',
                        builder: (BuildContext context, GoRouterState state) {
                          final moduleID = state.pathParameters['moduleID']!;
                          final sessionID = state.pathParameters['sessionID']!;
                          return PDFScreen(
                            moduleID: moduleID,
                            sessionID: sessionID,
                          );
                        },
                      ),
                    ],
                  ),
                  GoRoute(
                    name: "focus_timer",
                    path: '/focus_timer',
                    builder: (BuildContext context, GoRouterState state) =>
                        const FocusTimer(),
                  ),
                  GoRoute(
                    name: 'reflection',
                    path: '/reflection',
                    builder: (BuildContext context, GoRouterState state) {
                      return const ReflectionScreen();
                    },
                    routes: [
                      GoRoute(
                        name: 'reflection_detail',
                        path: 'detail/:journalID',
                        builder: (BuildContext context, GoRouterState state) {
                          String journalID = state.pathParameters['journalID']!;

                          //Tracking: open journal
                          trackEvent(
                            category: TrackingCategory.journal,
                            action: TrackingAction.open,
                            name: journalID,
                          );

                          return SingleJournalScreen(journalID: journalID);
                        },
                      ),
                      GoRoute(
                        name: 'reflection_course',
                        path: 'course',
                        builder: (BuildContext context, GoRouterState state) {
                          return const Journal();
                        },
                      ),
                    ],
                  ),
                  GoRoute(
                    name: 'quiz',
                    path: '/quiz',
                    builder: (BuildContext context, GoRouterState state) {
                      return const QuizScreen();
                    },
                    routes: [
                      GoRoute(
                        name: 'quiz_module_detail',
                        path: 'module/:moduleID',
                        builder: (BuildContext context, GoRouterState state) {
                          return ModuleQuizScreen(
                            moduleID: state.pathParameters['moduleID']!,
                          );
                        },
                        routes: [
                          GoRoute(
                            name: 'quiz_session',
                            path: 'session/:quizID',
                            builder:
                                (BuildContext context, GoRouterState state) {
                                  return QuizSessionScreen(
                                    moduleID: state.pathParameters['moduleID']!,
                                    quizID: state.pathParameters['quizID']!,
                                  );
                                },
                          ),
                        ],
                      ),
                    ],
                  ),
                ],
              ),
            ],
          ),
          StatefulShellBranch(
            navigatorKey: modulesNavigatorKey,
            routes: <RouteBase>[
              StatefulShellRoute.indexedStack(
                branches: <StatefulShellBranch>[
                  StatefulShellBranch(
                    routes: <RouteBase>[
                      GoRoute(
                        name: "modules",
                        path: '/modules',
                        builder: (BuildContext context, GoRouterState state) =>
                            const ModulesScreen(),
                        routes: <RouteBase>[
                          GoRoute(
                            name: "module",
                            path: '/:moduleID',
                            builder:
                                (BuildContext context, GoRouterState state) {
                                  final moduleID =
                                      state.pathParameters['moduleID']!;
                                  return SessionSelectionScreen(
                                    moduleID: moduleID,
                                  );
                                },
                            routes: <RouteBase>[
                              GoRoute(
                                name: 'assessment',
                                path: 'assessment/:prePost',
                                pageBuilder:
                                    (
                                      BuildContext context,
                                      GoRouterState state,
                                    ) {
                                      final moduleID =
                                          state.pathParameters['moduleID']!;
                                      return NoTransitionPage(
                                        child: AssessmentScreen(
                                          moduleID: moduleID,
                                          prePost:
                                              state.pathParameters['prePost']! ==
                                                  "pre"
                                              ? hikari_assessment
                                                    .AssessmentType
                                                    .pre
                                              : hikari_assessment
                                                    .AssessmentType
                                                    .post,
                                        ),
                                      );
                                    },
                              ),
                              GoRoute(
                                name: 'assessment_evaluation',
                                path: 'assessment_evaluation',
                                builder:
                                    (
                                      BuildContext context,
                                      GoRouterState state,
                                    ) {
                                      final moduleID =
                                          state.pathParameters['moduleID']!;
                                      return AssessmentEvaluation(
                                        moduleID: moduleID,
                                      );
                                    },
                              ),
                            ],
                          ),
                        ],
                      ),
                    ],
                  ),
                ],
                builder: (context, state, shell) {
                  return shell;
                },
              ),
            ],
          ),
          StatefulShellBranch(
            navigatorKey: profileNavigatorKey,
            routes: <RouteBase>[
              GoRoute(
                name: 'profile',
                path: '/profile',
                builder: (BuildContext context, GoRouterState state) =>
                    const ProfileScreen(),
                routes: <RouteBase>[
                  GoRoute(
                    name: 'profile_settings',
                    path: 'profile/profile_settings',
                    builder: (BuildContext context, GoRouterState state) =>
                        const ProfileSettings(),
                  ),
                  GoRoute(
                    name: 'notification_settings',
                    path: 'profile/notification_settings',
                    builder: (BuildContext context, GoRouterState state) =>
                        const NotificationSettings(),
                  ),
                  GoRoute(
                    name: 'focus_settings',
                    path: 'profile/focus_settings',
                    builder: (BuildContext context, GoRouterState state) =>
                        const FocusSettings(),
                  ),
                  GoRoute(
                    name: 'debug_settings',
                    path: 'profile/debug_settings',
                    builder: (BuildContext context, GoRouterState state) =>
                        const DebugSettings(),
                  ),
                  GoRoute(
                    name: 'about_us',
                    path: 'profile/about_us',
                    builder: (BuildContext context, GoRouterState state) =>
                        const AboutUs(),
                  ),
                  GoRoute(
                    name: 'app_info',
                    path: 'profile/app_info',
                    builder: (BuildContext context, GoRouterState state) =>
                        const AppInformation(),
                    routes: <RouteBase>[
                      GoRoute(
                        name: 'package_license',
                        path: 'profile/app_info/licenses/:packageId',
                        builder: (BuildContext context, GoRouterState state) =>
                            PackageLicense(
                              licenseData: state.extra! as PackageLicenseData,
                            ),
                      ),
                    ],
                  ),
                ],
              ),
            ],
          ),
        ],
        builder: (context, state, shell) {
          return Consumer(
            builder: (context, ref, shell) {
              final Widget child;
              switch (logInState) {
                case Authenticated():
                  child = UpgradeAlert(
                    child: FlavorBanner(
                      show: kDebugMode,
                      child: MessageBarFrame(
                        child: AppScreen(
                          navigationShell: shell as StatefulNavigationShell,
                        ),
                      ),
                    ),
                  );
                  break;
                case Unauthenticated():
                  child = Text("if you see this text there is a bug");
                  break;
              }

              return child;
            },
            child: shell,
          );
        },
      ),
    ],
  );
}
