import 'package:amsl_app/authentication/async_login_provider.dart';
import 'package:amsl_app/router.dart';
import 'package:amsl_app/themes/app_theme.dart';
import 'package:amsl_app/flavors.dart';
import 'package:amsl_app/widgets/async_value_extension.dart';
import 'package:amsl_app/widgets/loading/loading_screen.dart';
import 'package:feedback/feedback.dart';
import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:logging/logging.dart';

class App extends ConsumerStatefulWidget {
  const App({super.key});

  @override
  ConsumerState<App> createState() => _AppState();
}

class _AppState extends ConsumerState<App> {
  static final log = Logger('AppLogger');

  @override
  Widget build(BuildContext context) {
    log.info("Running app");

    // Todo: We should watch asyncLoginProvider here and how a loading screen
    //  while the provider is loading
    //  currently the app jumps from the login screen into the main screen
    //  once loading is done
    return ref
        .watch(asyncLoginProvider)
        .build(
          context,
          builder: (context, loginState) =>
              _buildApp(loginState ?? Unauthenticated()),
          errorBuilder: (context, error, stackTrace) =>
              _buildApp(Unauthenticated()),
          loadingBuilder: (context) => _buildApp(null),
        );
  }

  Widget _buildApp(LoginState? logInState) {
    return BetterFeedback(
      theme: FeedbackThemeData(
        colorScheme: AppTheme.lightColorScheme,
        dragHandleColor: AppTheme.lightColorScheme.onSurface,
        activeFeedbackModeColor: AppTheme.lightColorScheme.secondary,
      ),
      child: logInState != null
          ? MaterialApp.router(
              title: F.title,
              theme: AppTheme.light,
              darkTheme: AppTheme.dark,
              themeMode: ThemeMode.light,
              debugShowCheckedModeBanner: false,
              routerConfig: createRouterDelegate(logInState),
            )
          : MaterialApp(
              title: F.title,
              theme: AppTheme.light,
              darkTheme: AppTheme.dark,
              themeMode: ThemeMode.light,
              debugShowCheckedModeBanner: false,
              home: AmslLoadingScreen(),
            ),
    );
  }
}
